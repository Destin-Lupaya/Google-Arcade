# Automate Data Capture at Scale with Document AI: Challenge Lab
# 1 hour 30 minutes
# 5 Credits
# GSP367
# Google Cloud self-paced labs logo

# Overview
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students enrolled in the Automate Data Capture at Scale with Document AI quest. Are you ready for the challenge?

# Challenge scenario
# You are a data engineer at large infrastructure management company and have been assigned to work on a internal project with the financial division of the company. The company has to process an ever increasing mountain of documents that all require individual manual processing for validation and authorization, which is an expensive task that requires a lot of staff. The company plans to leverage GCP tools to automate the process of collecting, categorizing, and verifying documents in an efficient and less labor intensive manner.

# Your challenge
# To complete this challenge successfully you must create a document processing pipeline that will automatically process documents that are uploaded to Cloud Storage. The pipeline consists of a primary Cloud Function that processes new files that are uploaded to Cloud Storage using a Document AI form processor to extract the data from the document. The function then saves the form data detected in those files to BigQuery.

# You are provided with the source code for a Cloud Function that will perform the processing, and you are expected to deploy the document processing pipeline as shown in the architecture below, making sure to correctly configure the components for your specific pipeline.

# Document AI challenge lab Solution Architecture

# Task 1. Enable the Cloud Document AI API and copy lab source files.
# In this task, you must enable the Cloud Document AI API and copy your starter files into Cloud Shell.

# Enable the Cloud Document AI API
# Enable the Cloud Document AI API.
# Enable Cloud Document AI API
# Copy the lab source files into your Cloud Shell
# The cloud function with predefined code is hosted on a remote Cloud Storage bucket. You will now copy these source files into your Cloud Shell. These files include the source code for the Cloud Function and the schema for the BigQuery table that you will create in the lab.

# In Cloud Shell, enter the following command to clone the source repository for the lab:
#   mkdir ./document-ai-challenge
#   gsutil -m cp -r gs://cloud-training/gsp367/* \
#     ~/document-ai-challenge/
# Copied!
# Task 2. Create a form processor
# In this task, you must create an instance of the general form processor using the Document AI Form Parser processor in the General (non-specialized) section. The general form processor will process any type of document and extract all the text content it can identify in the document as well as form information that it infers from the layout.

# Create the processor using the following configuration details:
# Property	Value
# Processor Type	Form Parser
# Processor Name	processor name
# Region	US
# Note: You will configure a Cloud Function later in this lab with the PROCESSOR ID and PARSER LOCATION of this processor so that the Cloud Function will use this specific processor to process invoices. Click on the created processor and note the PROCESSOR ID. However, the processor region is the PARSER LOCATION.
# Create a form processor
# Task 3. Create Google Cloud resources
# In this task, you must prepare your environment by creating the Google Cloud Storage and BigQuery resources that are required for your document processing pipeline.

# Create input, output, and archive Cloud Storage buckets
# In this step, you must create the three Cloud Storage buckets listed below with uniform bucket level access enabled.
# Bucket Name	Purpose	Storage class	Location
# input_bucket_name	For input invoices	Standard	us-central1
# output_bucket_name	For storing processed data	Standard	us-central1
# archive_bucket_name	For archiving invoices	Standard	us-central1
# Note: A bucket can be created using the gsutil tool with the -mb parameter, along with -c parameter to set the storage class, -l to set the (regional) location and the -b flag with the value of on or off to set uniform bucket level access. Read the mb - Make buckets reference for more about creating buckets using gsutil.
# Create a BigQuery dataset and tables
# In this step, you must create a BigQuery dataset and the output table required for your data processing pipeline.

# Dataset
# Dataset Name	Location
# invoice_parser_results	US
# Note: Use bq mk to create BigQuery resources. The command line switch parameter -d is used to create a dataset and --location is used to set the location of the resource. Read the Create datasets guide for more information about creating datasets using the bq command-line tool.
# Table
# The table schema for the extracted information has been provided for you in the JSON file document-ai-challenge/scripts/table-schema/doc_ai_extracted_entities.json. Use this schema to create a table named doc_ai_extracted_entities in the invoice_parser_results dataset.

# Note: Use bq mk to create BigQuery resources. The command line switch --table is used to create a table. For more information about creating tables with a schema definition using the bq command-line tool, read the Create and use tables guide.
# You can navigate to BigQuery in the Cloud Console and inspect the schema of tables in the invoice_parser_results dataset using BigQuery SQL workspace.

# Create Google Cloud resources
# Task 4. Deploy the document processing Cloud Function
# To complete this task, you must deploy the Cloud Function that your data processing pipeline uses to process invoices uploaded to Cloud Storage. This function will use a Document AI API Generic Form processor to extract form data from the raw documents.

# You can examine the source code of the Cloud Function using the Code Editor or any other editor of your choice. The Cloud Function is stored in the following folders in Cloud Shell:

# Process Invoices - scripts/cloud-functions/process-invoices
# The Cloud Function, process-invoices, must be triggered when files are uploaded to the input files storage bucket you created earlier.

# Deploy the Cloud Function to process documents uploaded to Cloud Storage
# Deploy a Cloud Function that uses a Document AI form processor to parse form documents that have been uploaded to a Cloud Storage bucket.

# Navigate to scripts directory:

#  cd ~/document-ai-challenge/scripts 
# Copied!
# Deploy the Cloud Function:

#   export PROJECT_ID=$(gcloud config get-value core/project)   
#   export CLOUD_FUNCTION_LOCATION=us-central1
#   gcloud functions deploy process-invoices \
#   --region=${CLOUD_FUNCTION_LOCATION} \
#   --entry-point=process_invoice \
#   --runtime=python37 \
#   --service-account=${PROJECT_ID}@appspot.gserviceaccount.com \
#   --source=cloud-functions/process-invoices \
#   --timeout=400 \
#   --env-vars-file=cloud-functions/process-invoices/.env.yaml \
#   --trigger-resource=gs://${PROJECT_ID}-input-invoices \
#   --trigger-event=google.storage.object.finalize
# Copied!
# If you inspect the Cloud Function source code you will see that the function gets the Document AI processor details via two runtime environment variables.

# You will have to reconfigure the Cloud Function deployment so that the environment variablesPROCESSOR_ID and PARSER_LOCATION contain the correct values for the Form Parser processor you deployed in a previous step.
# Make sure the PARSER_LOCATION value must be in lower case.
# Wait for the function to be fully redeployed.

# Deploy Document Processing Cloud Function
# Task 5. Test and validate the end-to-end solution
# For your final task you must successfully process the set of invoices that are available in the ~/document-ai-challenge/invoices folder using your pipeline.

# Upload these invoices to the input Cloud Storage bucket and monitor the progress of the pipeline.

# Watch the events until you see a final event indicating that the function execution finished with a status of OK.

# Once the pipeline has fully processed the documents, you will see that the form information that is extracted from the invoices by the Document AI processor has been written out into the BigQuery table.

# Note: To monitor progress, click Logs in the Management section of the Cloud function to view logs.
# Note : You may see some errors that do not affect document processing significantly, especially timeouts, in this lab. If you not see data being reported as being written to BigQuery within 5 minutes in the logs then double check that the parameters set in the .env.yaml file in the previous section are correct and try again.
# In particular make sure the Processor ID and location variables that you set are valid and note that the location parameter must be in lower case. Also note that the event list does not automatically refresh.
# Validate data processed by the pipeline
# Congratulations
# Over the course of this challenge lab you have demonstrated your knowledge of working with Document AI.

# Automate Data Capture at Scale with Document AI Skill badge

# Earn your next skill badge
# This self-paced lab is part of the Automate Data Capture at Scale with Document AI quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated October 12, 2022 Lab Last Tested May 2, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.