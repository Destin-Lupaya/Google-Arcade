# Deploy a Modern Web App connected to a Cloud Spanner Instance
# 1 hour 30 minutes
# 1 Credit
# GSP1051
# Google Cloud self-paced labs logo

# Overview
# Cloud Spanner is Google’s fully managed, horizontally scalable relational database service. Customers in financial services, gaming, retail and many other industries trust it to run their most demanding workloads, where consistency and availability at scale are critical.

# In this lab you build and deploy a Node.js application connected to a Cloud Spanner instance. The Node.js application is a stock price visualization tool named OmegaTrade. The OmegaTrade application stores stock prices in Cloud Spanner and renders visualizations using Google Charts.

# The backend service uses the Node.js Express framework and connects to Cloud Spanner with default connection pooling, session, and timeout capabilities.

# Objectives
# In this lab, you will deploy a Modern Web App connected to a Cloud Spanner instance.

# Configure the Project Environment

# Download and inspect the application code

# Deploy Backend application component

# Import sample stock trade data to the database

# Deploy Frontend application component

# Perform operations in the OmegaTrade Application

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
# Cloud Spanner instance
# In order to allow you to move more quickly through this lab the Cloud Spanner instance, database, and tables required for the OmegaTrade application were automatically created for you.

# Here are some details for your reference:

# Item	Name	Details
# Cloud Spanner Instance	omegatrade-instance	This is the project-level instance
# Cloud Spanner Database	omegatrade-db	This is the instance specific database
# Table	Users	Contains user acccounts
# Table	Companies	Contains company name and stock symbol
# Table	CompanyStocks	Contains stock values
# Table	Simulations	Tracks the state of each simulation
# Task 1. Enable required Google Cloud APIs
# First enable the Google Cloud APIs for Cloud Spanner, Container Registry, and Cloud Run.

# In the Cloud Shell enter the following commands:

# gcloud services enable spanner.googleapis.com
# gcloud services enable containerregistry.googleapis.com
# gcloud services enable run.googleapis.com
# Copied!
# Task 2. Download and inspect the application code
# Download the code repository for use in this lab. In the Cloud Shell enter the following:

# git clone https://github.com/GoogleCloudPlatform/training-data-analyst
# Copied!
# Navigate to the folder containing the application code.

# cd training-data-analyst/courses/cloud-spanner/omegatrade/
# Copied!
# The code is divided primarily into two parts, backend and frontend. The application architecture is depicted in the diagram below:
# AppArch.png

# The application relies on a deployment-specific file named .env to successfully communicate with the Cloud Spanner instance. You will create this file in the next task.

# With respect to the backend, some of the bindings and interactions with the Cloud Spanner tables are managed by Node.js models - three of these company.model.js, simulation.model.js, and user.model.js - reside in the models folder. Issue the following command to navigate to the models folder:

# cd backend/app/models
# Copied!
# Issue the following command to inspect the company.model.js file. This file contains database operations to interact with the companies table.

# more company.model.js
# Copied!
# Press the spacebar to advance through the file until its end. If you wish to close the file early, type q to close the more command.

# Some of the frontend interactions with these models and other structures in the Node.js backend occur through Angular components located in the components folder. Issue the following command to navigate to the components folder:

# cd ../../../frontend/src/app/components
# Copied!
# For instance, the company component contains the base application code to manage and update company information.

# Issue the following command to inspect the manage-company.component.ts TypeScript configuration file. This file contains methods for deleting or editing a company, among other actions.

# more company/manage-company/manage-company.component.ts
# Copied!
# Press the spacebar to advance through the file until its end. If you wish to close the file early, type q to close the more command.

# Task 3. Build and deploy the backend component
# Navigate to the folder containing the code required to build and deploy the backend.

# cd ../../../../backend
# Copied!
# Create the .env file. As mentioned earlier, this file contains project specific information so that the application's backend component can communicate with the Cloud Spanner instance.
# In the cloud shell enter the following command to invoke the Nano text editor and create a new .env file.

# nano .env
# Copied!
# Paste the code block listed below.

# PROJECTID = Project ID
# INSTANCE = omegatrade-instance
# DATABASE = omegatrade-db
# JWT_KEY = w54p3Y?4dj%8Xqa2jjVC84narhe5Pk
# EXPIRE_IN = 30d
# Copied!
# Press Ctrl+X to exit Nano, Y to confirm the update, and press Enter to save your changes.

# Before you proceed further you must install updated components for npm so that the backend can be properly compiled. npm is a package manager for JavaScript. npm is the default package manager for the JavaScript runtime environment Node.js.

# npm install npm -g
# npm install --loglevel=error
# Copied!
# Next build the backend application using a reference dockerfile that exists in the repository folder.
# docker build -t gcr.io/Project ID/omega-trade/backend:v1 -f dockerfile.prod .
# Copied!
# Note: You may safely ignore any npm notice... messages that appear during the build process
# Push the newly created application package to the Container Repository for your project.
# docker push gcr.io/Project ID/omega-trade/backend:v1
# Copied!
# Finally deploy the backend application using Cloud Run. Cloud Run is a serverless deployment framework which abstracts away infrastructure management and scales up or down automatically almost instantaneously depending on traffic.
# gcloud run deploy omegatrade-backend --platform managed --region us-west1 --image gcr.io/Project ID/omega-trade/backend:v1 --memory 512Mi --allow-unauthenticated
# Copied!
# Copy the URL provided at the end of the deployment. Preserve the URL in notepad, a text file, or other readily accessible location. This URL will be supplied to the frontend application to ensure the user interface can properly communicate with the Cloud Spanner database via the backend.
# The backend Service URL will appear in the following format:

# https://omegatrade-backend-zzzyyyxx1x-uw.a.run.app
# Click Check my progress to verify the objective.
# Build and deploy the backend component
# Task 4. Import sample stock trade data to the database
# To import sample company and stock data, run the following command in the current (main backend) folder.

# unset SPANNER_EMULATOR_HOST
# node seed-data.js
# Copied!
# You will receive confirmation that the tables were loaded successfully.

# Inserting Companies...
# done
# Inserting Simulations...
# done
# Inserting Stocks...
# done
# Data Loaded successfully
# Click Check my progress to verify the objective.
# Import sample stock trade data to the database
# Task 5. Build and deploy the frontend component
# Navigate to the directory containing the frontend code. Specifically navigate to the environments folder to update the configuration file to point to your backend component.

# cd ../frontend/src/environments
# Copied!
# In the cloud shell enter the following command to invoke the Nano text editor and open the environment.ts file.

# nano environment.ts
# Copied!
# Carefully delete the string http://localhost:3000 and replace it with your backend URL.
# Note: Be certain to retain the /api/v1/ portion of the URL
# Press Ctrl+X to exit Nano, Y to confirm the update, and press Enter to save your changes.

# Your updated environment.ts file should appear like the example below.

# export const environment = {
#   production: false,
#   name: "dev",
#   // change baseUrl according to backend URL
#   baseUrl:"https://omegatrade-backend-zzzyyyxx1x-uw.a.run.app/api/v1/",
#   // change clientId to actual value you have received from Oauth console
#   clientId: ""
# };
# Navigate to the main frontend folder.

# cd ../..
# Copied!
# Install updated components for npm so that the frontend can be properly compiled.

# npm install npm -g
# npm install --loglevel=error
# Copied!
# Note: You may safely ignore any npm WARN config... messages that appear during the installation process
# Next build the frontend application using a reference dockerfile that exists in the repository folder. The frontend build may take 5 to 10 minutes to complete.
# docker build -t gcr.io/Project ID/omegatrade/frontend:v1 -f dockerfile .
# Copied!
# Note: You may safely ignore any npm notice... messages that appear during the build process
# Push the newly created application package to the Container Repository for your project.
# docker push gcr.io/Project ID/omegatrade/frontend:v1
# Copied!
# Finally deploy the frontend application using Cloud Run.
# gcloud run deploy omegatrade-frontend --platform managed --region us-west1 --image gcr.io/Project ID/omegatrade/frontend:v1 --allow-unauthenticated
# Copied!
# The frontend Service URL will appear in the following format. You may click the URL directly to open it or copy the URL and paste it into a new tab.

# https://omegatrade-frontend-zzzyyyxx1x-uw.a.run.app
# Click Check my progress to verify the objective.
# Build and deploy the frontend component
# Task 6. Perform operations in the OmegaTrade Application
# On the application launch page click the sign up link.

# Use the following details to create a new account for a fictitious company named Spanner1.

# Item	Value
# Business email	admin@spanner1.com
# Full Name	Spanner1 Admin
# Password	Spanner1
# Confirm your Password	Spanner1



# Your account will be created and you will be logged in.

# To examine the OmegaTrade application, navigate to the Dashboard and choose Foobar Inc from the selector to see the stock performance chart for Foobar Inc. You will see a range of simulated stock prices over time for Foobar Inc.

# Navigate to Manage Company and add Spanner1 as a new company.

# Click Add Company on the right side of the page. On the pop-up window, input the following values:

# Item	Value
# Company Name	Spanner1
# Short Code	SPN



# Then click Save.

# Spanner1 is now in the list of companies.

# Navigate to the Dashboard and select Spanner1 if it is not already selected. You will see that no simulation exists for Spanner1. Click the link entitled here to generate a simulation.

# Under Simulate Data, provide the following details:

# Item	Value
# Select Company	Spanner1
# Select Interval	5
# Number of Records	50



# Then click Simulate.

# Navigate to the Dashboard which will immediately update the chart for Spanner1 as the simulation progresses. It will take between 3 and 6 minutes for the simulation to complete.

# The OmegaTrade application also allows you to modify existing company information. On the Manage Company tab click the pencil icon under Action for Acme Corp.

# Update the company name to Coyote Inc. Notice that the Short Code cannot be updated in the user interface. Click Update to close and accept the change.

# The update to the company name is immediate. Navigate to the Dashboard and you will see that Acme Corp no longer appears and Coyote Inc has taken its place.

# Occasionally data changes are required that exceed the capabilities of the application code. As an empowered user you have the ability to update data used in the OmegaTrade application by making direct changes in the Cloud Spanner database.

# On the Cloud Console Navigation menu (console_nav_small.png), under Databases click Spanner.

# Accept any acknowledgement or information window that may appear.

# Click on the omegatrade-instance name and then omegatrade-db under Databases. From the list of tables on the bottom of the page, click companies.

# Click Data on the left side pane to see the table contents.

# You will update the name of the Bar Industries entity.

# Click on the checkbox for the Bar Industries row. Then click Edit from the choices listed above the table rows.

# A pre-filled SQL update query is generated. Remove the values under Set for companyShortCode and created_at. Update the string for companyName from Bar Industries to Consolidated Enterprises Inc. The rest of the query should remain unchanged.

# The first few rows of your query should appear like the following sample code:

# UPDATE
#   companies
# SET
#   companyName='Consolidated Enterprises Inc'
# WHERE
# ....
# Note: In the Cloud Spanner query window you have the ability to change the Short Code value. The application code as designed does not allow this value to be updated via the user interface.
# Click Run to process the update.

# Return to the application page, refresh your browser, and navigate to Dashboard tab. You will see that Bar Industries no longer appears and Consolidated Enterprises Inc has taken its place.

# Congratulations!
# You have now deployed a Node.js application connected to a Cloud Spanner instance and performed basic operations against the database using the application as well as editing data directly in the database.

# Finish your quest
# This self-paced lab is part of the Create and Manage Cloud Spanner Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Manual Last Updated: March 27, 2023

# Lab Last Tested: May 26, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
