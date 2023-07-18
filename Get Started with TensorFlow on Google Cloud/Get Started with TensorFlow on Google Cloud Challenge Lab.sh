# Get Started with TensorFlow on Google Cloud: Challenge Lab
# 1 hour 30 minutes
# 1 Credit
# GSP398
# Google Cloud self-paced labs logo

# Overview
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students who have enrolled in the Get Started with TensorFlow on Google Cloud quest. Are you ready for the challenge?

# Topics tested:
# Write a script to train a CNN for image classification and saves the trained model to the specified directory.

# Run your training script using Vertex AI custom training job.

# Deploy your trained model to a Vertex Online Prediction Endpoint for serving predictions.

# Request an online prediction and see the response.

# Setup and requirements
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# How to start your lab and sign in to the Google Cloud Console
# Click the Start Lab button. If you need to pay for the lab, a pop-up opens for you to select your payment method. On the left is the Lab Details panel with the following:

# The Open Google Console button
# Time remaining
# The temporary credentials that you must use for this lab
# Other information, if needed, to step through this lab
# Click Open Google Console. The lab spins up resources, and then opens another tab that shows the Sign in page.

# Tip: Arrange the tabs in separate windows, side-by-side.

# Note: If you see the Choose an account dialog, click Use Another Account.
# If necessary, copy the Username from the Lab Details panel and paste it into the Sign in dialog. Click Next.

# Copy the Password from the Lab Details panel and paste it into the Welcome dialog. Click Next.

# Important: You must use the credentials from the left panel. Do not use your Google Cloud Skills Boost credentials.
# Note: Using your own Google Cloud account for this lab may incur extra charges.
# Click through the subsequent pages:

# Accept the terms and conditions.
# Do not add recovery options or two-factor authentication (because this is a temporary account).
# Do not sign up for free trials.
# After a few moments, the Cloud Console opens in this tab.

# Note: You can view the menu with a list of Google Cloud Products and Services by clicking the Navigation menu at the top-left. Navigation menu icon
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
# Enable Google Cloud services
# In Cloud Shell, use gcloud to enable the services used in the lab

# gcloud services enable \
#   compute.googleapis.com \
#   monitoring.googleapis.com \
#   logging.googleapis.com \
#   notebooks.googleapis.com \
#   aiplatform.googleapis.com \
#   artifactregistry.googleapis.com \
#   container.googleapis.com
# Copied!
# This will allow access to running model training, deployment, and explanation jobs with Vertex AI.

# Click Check my progress to verify the objective.
# Enable Google Cloud services

# Challenge scenario
# You were recently hired as a Machine Learning Engineer for an Optical Character Recognition app development team. Your manager has tasked you with building a machine learning model to recognize Hiragana alphabets. The challenge: your business requirements are that you have just 6 weeks to produce a model that achieves greater than 90% accuracy to improve upon an existing bootstrapped solution. Furthermore, after doing some exploratory analysis in your startup's data warehouse, you found that you only have a small dataset of 60k images of alphabets to build a higher-performing solution.

# To build and deploy a high-performance machine learning model with limited data quickly, you will walk through training and deploying a CNN classifier for online predictions on Google Cloud's Vertex AI platform. Vertex AI is Google Cloud's next-generation machine learning development platform where you can leverage the latest ML pre-built components to significantly enhance your development productivity, scale your workflow and decision-making with your data, and accelerate time to value.

# cnn-challenge-lab.png

# First, you will progress through a typical experimentation workflow where you will write a script that trains your custom CNN model using tf.keras classification layers. You will then send the model code to a custom training job and run the custom training job using pre-built Docker containers provided by Vertex AI to run training and prediction. Lastly, you will deploy the model to an endpoint so that you can use your model for predictions.

# Create a Vertex Notebooks instance
# Navigate to Vertex AI > Workbench > User-Managed Notebooks.

# Create a Notebook instance. Select TensorFlow Enterprise 2.11 Without GPUs. Name your notebook cnn-challenge and leave the default configurations.

# Click OPEN JUPYTERLAB next to the name of your pre-provisioned Vertex Notebook instance. It may take a few minutes for the OPEN JUPYTERLAB option to appear.

# Click Check my progress to verify the objective.
# Create the vertex AI notebook instance

# Download the Challenge Notebook
# In your notebook, click the terminal.

# Clone the repo:

# git clone https://github.com/GoogleCloudPlatform/training-data-analyst
# Copied!
# Click Check my progress to verify the objective.
# Download the challenge Notebook

# Go to the enclosing folder: training-data-analyst/self-paced-labs/learning-tensorflow/cnn-challenge-lab/.

# Open the notebook file cnn-challenge-lab.ipynb.

# In the Setup section, define your PROJECT_ID and GCS_BUCKET variables.

# Click Check my progress to verify the objective.
# Create a Cloud Storage Bucket

# Create a training script
# In this section, you will complete the training script task.py using TensorFlow.

# Write a TensorFlow CNN classifier
# Fill out the #TODO section to add the last layer for the model creation.

# Fill out the #TODO section to save your model. You should save it to the AIP_MODEL_DIR environment variable.

# Click Check my progress to verify the objective.
# Create training script

# Train the model
# Define custom training job on Vertex AI
# Fill out the #TODO section to create a custom training job on vertex ai. You can find the documentation here.
# Hint: Make sure that you specify the script_path, container_uri, and model_serving_container_image_uri parameters.
# Train the model using Vertex AI pipelines
# Fill out the #TODO section and run the custom training job function you defined above. You can find the documentation here.
# Hint: Make sure that you specify the args and machine_type parameters.
# Note: It can take around 8-10 minutes to train the model.
# Click Check my progress to verify the objective.
# Train the Model on Vertex AI

# Deploy the model to a Vertex Online Prediction Endpoint
# Fill out the #TODO section deploy the model to an endpoint. You can find the documentation here.
# Hint: Make sure that you specify the traffic_split, machine_type, min_replica_count and max_replica_count parameters.
# Note: It can take around 10-15 minutes to deploy the model.
# Click Check my progress to verify the objective.
# Deploy the model

# Query deployed model on Vertex Online Prediction Endpoint
# Fill out the #TODO section to generate online predictions using your Vertex Endpoint. You can find the documentation here.
# Endpoint queried successfully
# Congratulations!
# You walked through a workflow that trains and deploys a model on GCP using Vertex AI. First, you wrote a script to build, train, and evaluate a Convolutional Neural Network for image classification in a Vertex Notebook. You then used your script to train the model using a custom training job on Google Cloud's Vertex AI. Lastly, you deployed your model container to a Vertex Endpoint that you queried for online predictions.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated June 6, 2023
# Lab Last Tested June 6, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.