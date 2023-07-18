# Identify Horses or Humans with TensorFlow and Vertex AI
# 1 hour 30 minutes
# 1 Credit
# GSP634
# Google Cloud self-paced labs logo

# Overview
# In other labs the Fashion MNIST dataset is used to train an image classifier. In this case you had images that were 28x28 where the subject was centered. In this lab you'll take this to the next level, training to recognize features in an image where the subject can be anywhere in the image!

# You'll do this by building a horses-or-humans classifier that will tell you if a given image contains a horse or a human, where the network is trained to recognize features that determine which is which.

# What you'll do
# Look at the the starting model

# Add convolutions, gather the data, and define the model

# Compile and train the model

# Visualize the Convolutions and pooling

# Prerequisite
# Although this is a self-standing lab, to maximize your learning, consider taking the lab, Classify Images with TensorFlow Convolutional Neural Networks.

# Setup
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

# Deploy Vertex Notebook instance
# For this lab, a Vertex Notebook instance configured with JupyterLab and many machine learning frameworks has been pre-provisioned for you.

# Navigate to it and and open it:

# In the Cloud Console, navigate to Vertex AI > Workbench.

# Click OPEN JUPYTERLAB next to the name of your pre-provisioned Vertex Notebook instance. It may take a few minutes for the OPEN JUPYTERLAB option to appear.

# Clone the lab repository
# To clone the training-data-analyst repository in your JupyterLab instance:

# In JupyterLab, click the Terminal icon to open a new terminal.
# Open Terminal

# At the command-line prompt, type the following command and press ENTER:

# git clone https://github.com/GoogleCloudPlatform/training-data-analyst
# Copied!
# To confirm that you have cloned the repository, in the left panel, double click the training-data-analyst folder to see its contents.
# Files in the training-data-analyst directory

# Click Check my progress to verify the objective.
# Clone the lab repository

# Navigate to lab notebook
# In your Vertex Notebook, navigate to the following directory:
# training-data-analyst/self-paced-labs/learning-tensorflow/convolutions-with-complex-images/

# Open CLS_Vertex_AI_CNN_horse_or_human.ipynb
# f639ae583bb66744.png
# Continue the lab in the notebook, and run each cell by clicking the Run ( run-button.png) icon at the top of the screen. Alternatively, you can execute the code in a cell with SHIFT + ENTER.
# Read the narrative and make sure you understand what's happening in each cell.

# In order to view the status of training and deployment on Vertex AI, you can follow the instructions in the notebook containing illustrations.

# Check your progress on notebook
# Create a Cloud Storage Bucket
# Click Check my progress to verify whether the bucket is created.
# Create a Cloud Storage Bucket

# Train the Model on Vertex AI
# Click Check my progress to verify the objective.
# Train the Model on Vertex AI

# Copy the Batch Prediction Results
# Click Check my progress to verify the objective.
# Copy the Batch Prediction Results

# Congratulations!
# In this lab, you used convolution to identify features in an image where the subject could be anywhere in the image!

# Next steps / learn more
# Check out Cloud ML Engine with Keras Tutorial and Training Keras with GPUs & Serving Predictions with Cloud ML Engine (Google Cloud AI Huddle).
# Read about Writing Custom Keras Generators.
# Learn more about the at Keras DataGenerator.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated November 18, 2022
# Lab Last Tested November 18, 2022
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
