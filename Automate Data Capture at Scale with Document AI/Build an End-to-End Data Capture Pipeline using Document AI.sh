# Build an End-to-End Data Capture Pipeline using Document AI
# 1 hour
# 1 Credit
# GSP927
# Google Cloud self-paced labs logo

# Overview
# The Document AI API is a document understanding solution that takes unstructured data, such as documents and emails, and makes the data easier to understand, analyze, and consume.

# In this lab, you will create a document processing pipeline that will automatically process documents that are uploaded to Cloud Storage. The pipeline consists of a primary Cloud Function that processes new files that are uploaded to Cloud Storage using a Document AI form processor and then saves form data detected in those files to BigQuery. If the form data includes any address fields the address data is then written to a Pub/Sub topic that in turn triggers a second Cloud Function that uses to Geocoding API to provide geographic coordinate data for the address that is also written to BigQuery.

# This is a simple pipeline that uses a general form processor that will detect basic form data, such as a labelled field containing address information. Document AI processors that use one of the specialized parsers that are beyond the scope of this lab provide enhanced entity information for specific document types even when those documents do not include labelled fields. For example, a Document AI Invoice parser can provide detailed address and supplier information, from an unlabelled invoice document because it understands the layout of invoices.

# The overall architecture that you will create looks like the following:

# The Document AI Asynchronous Solution Architecture

# Upload forms with address data to Cloud Storage.
# Upload triggers Cloud Function call to process forms.
# Document AI called from Cloud Function.
# Document AI JSON data saved back to Cloud Storage.
# Form Data written to BigQuery by Cloud Function.
# Cloud Function sends addresses to a Pub/Sub topic.
# Pub/Sub message triggers Cloud Function for GeoCode processing.
# Geocoding API called from Cloud Function.
# Geocoding data written to BigQuery by Cloud Function.
# This example architecture uses Cloud Functions to implement a simple pipeline, but Cloud Functions are not recommended for production environments as the Document AI API calls can exceed the timeouts supported by Cloud Functions. Cloud Tasks are recommended for a more robust serverless solution.

# Objectives
# In this lab, you will learn how to:

# Enable the Document AI API.

# Deploy Cloud Functions that use the Document AI, BigQuery, Cloud Storage, and Pub/Sub APIs.

# Configure a Cloud Function to trigger when documents are uploaded to Cloud Storage.

# Configure a Cloud Function to use the Document AI client library for Python.

# Configure a Cloud Function to trigger when a Pub/Sub message is created.

# Setup and requirements
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Activate Cloud Shell
# Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

# Click Activate Cloud Shell Activate Cloud Shell icon at the top of the Google Cloud console.
# When you are connected, you are already authenticated, and the project is set to your PROJECT_ID. The output contains a line that declares the PROJECT_ID for this session:

# Your Cloud Platform project in this session is set to YOUR_PROJECT_ID
# gcloud is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

# (Optional) You can list the active account name with this command:

# gcloud auth list
# Copied!
# Click Authorize.

# Your output should now look like this:

# Output:

# ACTIVE: *
# ACCOUNT: student-01-xxxxxxxxxxxx@qwiklabs.net
# To set the active account, run:
#     $ gcloud config set account `ACCOUNT`
# (Optional) You can list the project ID with this command:

# gcloud config list project
# Copied!
# Output:

# [core]
# project = <project_ID>
# Example output:

# [core]
# project = qwiklabs-gcp-44776a13dea667a6
# Note: For full documentation of gcloud, in Google Cloud, refer to the gcloud CLI overview guide.
# Task 1. Enable the APIs required for the lab
# You must enable the APIs for Document AI, Cloud Functions, Cloud Build, and Geocoding for this lab and then create the API key that is required by the Geocoding Cloud Function.

# In Cloud Shell, enter the following commands to enable the APIs required by the lab:

# gcloud services enable documentai.googleapis.com      
# gcloud services enable cloudfunctions.googleapis.com  
# gcloud services enable cloudbuild.googleapis.com    
# gcloud services enable geocoding-backend.googleapis.com   
# Copied!
# In the Cloud Console, in the Navigation menu (Navigation menu icon), click APIs & services > Credentials.

# Select Create credentials, then select API key from the dropdown menu.

# The API key created dialog box displays your newly created key. An API key is a long string containing upper and lower case letters, numbers, and dashes. For example, a4db08b757294ea94c08f2df493465a1.

# Click Edit API key in the dialog box.

# Select Restrict key in the API restrictions section to add API restrictions for your new API key.

# Click in the filter box and type Geocoding API.

# Select Geocoding API and click OK.

# Click the Save button.

# Note: If you cannot find the Geocoding API in the Restrict key dropdown list, refresh the page to refresh the list of available APIs.
# Check that all the required APIs have been enabled.
# Task 2. Copy the lab source files into your Cloud Shell
# In this task, you copy the source files into your Cloud Shell. These files include the source code for the Cloud Functions and the schemas for the BigQuery tables that you will create in the lab.

# In Cloud Shell, enter the following command to clone the source repository for the lab:
#   mkdir ./documentai-pipeline-demo
#   gsutil -m cp -r \
#     gs://sureskills-lab-dev/gsp927/documentai-pipeline-demo/* \
#     ~/documentai-pipeline-demo/
# Copied!
# Task 3. Create a form processor
# Create an instance of the generic form processor to use in the Document AI Platform using the Document AI Form Parser specialized parser. The generic form processor will process any type of document and extract all the text content it can identify in the document. It is not limited to printed text, it can handle handwritten text and text in any orientation, supports a number of languages, and understands how form data elements are related to each other so that you can extract key:value pairs for form fields that have text labels.

# In the console, open the navigation menu and select Document AI > Overview.

# Click Explore Processor and select Form Parser.

# Specify the processor name as form-processor and select the region US (United States) from the list.

# Click Create to create your processor.

# You will configure a Cloud Function later in this lab with the processor ID and location of this processor so that the Cloud Function will use this specific processor to process sample invoices.

# Task 4. Create Cloud Storage buckets and a BigQuery dataset
# Prepare your environment by creating the Google Cloud resources that are required for your document processing pipeline.

# Create input, output, and archive Cloud Storage buckets
# Create input, output, and archive Cloud Storage buckets for your document processing pipeline.

# In Cloud Shell, enter the following command to create the Cloud Storage buckets for the lab:
#   export PROJECT_ID=$(gcloud config get-value core/project)
#   export BUCKET_LOCATION=us-central1
#   gsutil mb -c standard -l ${BUCKET_LOCATION} -b on \
#     gs://${PROJECT_ID}-input-invoices
#   gsutil mb -c standard -l ${BUCKET_LOCATION} -b on \
#     gs://${PROJECT_ID}-output-invoices
#   gsutil mb -c standard -l ${BUCKET_LOCATION} -b on \
#     gs://${PROJECT_ID}-archived-invoices
# Copied!
# Create a BigQuery dataset and tables
# Create a BigQuery dataset and the three output tables required for your data processing pipeline.

# In Cloud Shell, enter the following command to create the BigQuery tables for the lab:
#   bq --location=US mk  -d \
#      --description "Form Parser Results" \
#      ${PROJECT_ID}:invoice_parser_results
#   cd ~/documentai-pipeline-demo/scripts/table-schema/
#   bq mk --table \
#     invoice_parser_results.doc_ai_extracted_entities \
#     doc_ai_extracted_entities.json
#   bq mk --table \
#     invoice_parser_results.geocode_details \
#     geocode_details.json
# Copied!
# You can navigate to BigQuery in the Cloud Console and inspect the schemas for the tables in the invoice_parser_results dataset using the BigQuery SQL workspace.

# Create a Pub/Sub topic
# Initialize the Pub/Sub topic used to trigger the Geocoding API data enrichment operations in the processing pipeline.

# In Cloud Shell, enter the following command to create the Pub/Sub topics for the lab:
#   export GEO_CODE_REQUEST_PUBSUB_TOPIC=geocode_request
#   gcloud pubsub topics \
#     create ${GEO_CODE_REQUEST_PUBSUB_TOPIC}
# Copied!
# Check that the BigQuery Dataset, Cloud Storage buckets, and Pub/Sub topic have been created.
# Task 5. Create Cloud Functions
# Create the two Cloud Functions that your data processing pipeline uses to process invoices uploaded to Cloud Storage. These functions use the Document AI API to extract form data from the raw documents, then use the GeoCode API to retrieve geolocation data about the address information extracted from the documents.

# You can examine the source code for the two Cloud Functions using the Code Editor or any other editor of your choice. The Cloud Functions are stored in the following folders in Cloud Shell:

# Process Invoices - scripts/cloud-functions/process-invoices
# Geocode Addresses - scripts/cloud-functions/geocode-addresses
# The main Cloud Function, process-invoices, is triggered when files are uploaded to the input files storage bucket you created earlier.

# The function folder scripts/cloud-functions/process-invoices contains the two files that are used to create the process-invoices Cloud Function.

# The requirements.txt file specifies the Python libraries required by the function. This includes the Document AI client library as well as the other Google Cloud libraries required by the Python code to read the files from Cloud Storage, save data to BigQuery, and write messages to Pub/Sub that will trigger the remaining functions in the solution pipeline.

# The main.py Python file contains the the Cloud Function code that creates the Document-AI, BigQuery, and Pub/Sub API clients and the following internal functions to process the documents:

# write_to_bq - Writes dictionary object to the BigQuery table. Note you must ensure the schema is valid before calling this function.
# get_text - Maps form name and value text anchors to the scanned text in the document. This allows the function to identify specific forms elements, such as the Supplier name and Address, and extract the relevant value. A specialized Document AI processor provides that contextual information directly in the entities property.
# process_invoice - Uses the asynchronous Document-AI client API to read and process files from Cloud Storage as follows:
# Creates an asynchronous request to process the file(s) that triggered the Cloud Function call.
# Processes form data to extract invoice fields, storing only specific fields in a dictionary that are part of the predefined schema.
# Publishes Pub/Sub messages to trigger the Geocoding Cloud Function using address form data extracted from the document.
# Writes form data to a BigQuery table.
# Deletes intermediate (output) files asynchronous Document AI API call.
# Copies input files to the archive bucket.
# Deletes processed input files.
# The process_invoices Cloud Function only processes form data that has been detected with the following form field names:

# input_file_name
# address
# supplier
# invoice_number
# purchase_order
# date
# due_date
# subtotal
# tax
# total
# The other Cloud Function, geocode-addresses, is triggered when a new message arrives on a Pub/Sub topic and it extracts its parameter data from the Pub/Sub message.

# Create the Cloud Function to process documents uploaded to Cloud Storage
# Create a Cloud Function that uses a Document AI form processor to parse form documents that have been uploaded to a Cloud Storage bucket.

# Create the Invoice Processor Cloud Function:
#   cd ~/documentai-pipeline-demo/scripts
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
# Create the Cloud Function to lookup geocode data from an address
# Create the Cloud Function that accepts address data from a Pub/Sub message and uses the Geocoding API to precisely locate the address.

# Create the Geocoding Cloud Function:
#   cd ~/documentai-pipeline-demo/scripts
#   gcloud functions deploy geocode-addresses \
#   --region=${CLOUD_FUNCTION_LOCATION} \
#   --entry-point=process_address \
#   --runtime=python38 \
#   --service-account=${PROJECT_ID}@appspot.gserviceaccount.com \
#   --source=cloud-functions/geocode-addresses \
#   --timeout=60 \
#   --env-vars-file=cloud-functions/geocode-addresses/.env.yaml \
#   --trigger-topic=${GEO_CODE_REQUEST_PUBSUB_TOPIC}
# Copied!
# Task 6. Edit environment variables for Cloud Functions
# In this task, you finalize the configuration of the Cloud Functions by editing the environment variables for each function to reflect your lab specific parameters via the Cloud Console.

# Edit environment variables for the process-invoices Cloud Function
# Set the Cloud Function environment variables for the process-invoices function.

# In the Cloud Console, in the Navigation menu (Navigation menu icon), click Cloud Functions.
# Click the Cloud Function process-invoices to open its management page.
# Click Edit.
# Click Runtime, build, connections and security settings to expand that section.
# Under Runtime environment variables, update the PROCESSOR_ID value to match the Invoice processor ID you created earlier.
# Under Runtime environment variables, update the PARSER_LOCATION value to match the region of the Invoice processor you created earlier. This will be us if you accepted the default location, otherwise eu. This parameter must be lowercase.
# Click Next and select .env.yaml and then update the PROCESSOR_ID and PARSER_LOCATION values again for your invoice processor.
# Click Deploy.
# Check that the Process Invoices Cloud Function has been deployed.
# Edit environment variables for the geocode-addresses Cloud Function
# Set the Cloud Function environment variables for the GeoCode data enrichment function.

# Click the Cloud Function geocode-addresses to open its management page.
# Click Edit.
# Click Runtime, build, connections and security settings to expand that section.
# Under Runtime environment variables, update the API_key value to match to the API Key value created in Task 1.
# Click Next and select .env.yaml and then update the API_key value to match the API Key value you set in the previous step.
# Click Deploy.
# Check that the Geocode Addresses Cloud Function has been deployed.
# Task 7. Test and validate the end-to-end solution
# Upload test data to Cloud Storage and monitor the progress of the pipeline as the documents are processed and the extracted data is enhanced.

# In Cloud Shell, enter the following command to upload sample forms to the Cloud Storage bucket that will trigger the process-invoices Cloud Function:
#   export PROJECT_ID=$(gcloud config get-value core/project)
#   gsutil cp gs://sureskills-lab-dev/gsp927/documentai-pipeline-demo/sample-files/* gs://${PROJECT_ID}-input-invoices/
# Copied!
# In the Cloud Console, on the Navigation menu (Navigation menu icon), click Cloud Functions.
# Click the Cloud Function process-invoices to open its management page.
# Click Logs.
# You will see events related to the creation of the function and the updates made to configure the environment variables followed by events showing details about the file being processed, and the data detected by Document AI.

# Document AI Cloud Function Events in the Logs section of the Function details page

# Watch the events until you see a final event indicating that the function execution finished with a status of OK. If errors are reported double check that the parameters set in the .env.yaml file in the previous section are correct. In particular make sure the Processor ID and location are valid. The event list does not automatically refresh.

# At the end of the processing, your BigQuery tables will be populated with the Document AI extracted entities as well as enriched data provided by the Geocoding API if the Document AI Processor has detected address data in the uploaded document.

# In the Cloud Console, on the Navigation menu (Navigation menu icon), click BigQuery.

# Expand your Project ID in the Explorer.

# Expand invoice_parser_results.

# Select doc_ai_extracted_entities and click Preview. You will see the form information extracted from the invoices by the invoice processor. You can see that address information and the supplier name has been detected.

# Select geocode_details and click Preview. You will see the formatted address, latitude, and longitude for each invoice that has been processed that contained address data that Document AI was able to extract.

# Check that the end-to-end pipeline has processed form and address data.
# Congratulations
# You've successfully used the Document AI API and other Google Cloud services to build an end-to-end invoice processing pipeline. In this lab, you enabled the Document AI API, deployed Cloud Functions that use the Document AI, BigQuery, Cloud Storage, and Pub/Sub APIs, and configured a Cloud Function to trigger when documents are uploaded to Cloud Storage. You also configured a Cloud Function to use the Document AI client library for Python and to trigger when a Pub/Sub message was created.

# Finish your quest
# This self-paced lab is part of the Detect Manufacturing Defects using Visual Inspection AI skill badge quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge. You can make your badge public and link to it in your online resume or social media account. Enroll in any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# Next steps / Learn more
# To read more about this form authentication, see the guide.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated February 24, 2023

# Lab Last Tested February 24, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.