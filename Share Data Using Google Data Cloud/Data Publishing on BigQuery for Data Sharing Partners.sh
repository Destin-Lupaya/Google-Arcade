# Data Publishing on BigQuery for Data Sharing Partners
# 45 minutes
# 1 Credit
# GSP1032
# Google Cloud self-paced labs logo

# Overview
# A common scenario is where a Google Cloud Data Sharing Partner has proprietary datasets that customers can use for their analytics use cases. Customers need to subscribe to this data, query it within their own platform, then augment it with their own datasets and use their visualization tools for their customer facing dashboards. This enables Data Sharing Partners to simplify and accelerate how they build and deliver value from data-driven solutions.

# data sharing partner publishing diagram

# Through integration with Google Cloud IAM, you can set permissions on BigQuery objects to enable access by users inside or outside of organizations. In this lab, you will learn how to create datasets in BigQuery to share externally. You will be given three projects: the Data Sharing Partner project and two customer projects. You will create and share the dataset inside of the Data Sharing Partner project, and then test the sharing capabilities from the other two customer projects.

# Objectives
# In this lab, you will:

# Grant permissions via IAM for data access

# Create a new dataset within an existing project

# Copying an existing table to newly created dataset

# Grant permission to the users to access a table

# Authorize and grant permissions to a dataset

# Verify dataset sharing capabilities for customer projects

# Setup and Requirements
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
# Grant permissions via IAM for data access
# Open the Data Sharing Partner Project Console. Log in with the associated credentials.

# From the Navigation Menu, go to IAM & Admin > IAM.

# Click + GRANT ACCESS at the top to assign a role to principals who needs to access the data.

# In the New principals field, enter the customer service account IDs:

# Customer 1 username
# Customer 2 username
# In the Select a role field, select the BigQuery User role.

# add bigquery user role to service account

# Click Save.
# Note: You could also add the BigQuery Job User role so that a service account can run scheduled jobs.
# Click Check my progress to verify the objective.
# Grant permissions via IAM for data access

# Create a new dataset within an existing project
# From the Navigation Menu, go to BigQuery > SQL Workspace.

# In the Explorer panel, select the project where you want to create the dataset. Expand the three dots Actions option and click Create dataset.

# create dataset

# For Dataset ID, enter demo_dataset.

# For Location type choose Multi-region and select US (multiple regions in United States) from dropdown.

# Click Create Dataset.

# Copy an existing table to newly created dataset
# For the purposes of this lab, you will use a public dataset that you will then copy into a table inside of your project.

# Click + Add data.
# The Add data window opens.

# Click Public Datasets under Additional sources.

# In the search bar, type Google Trends.

# Select the Google Trends dataset. Make sure it is not the international dataset.

# Click View dataset. The dataset information page should show up.

# trends dataset info

# Click Copy.

# For the Destination dataset, click in the box and select Data Sharing Partner Project ID.demo_dataset.

# For Location select us (multiple regions in United States).

# Click Copy.

# A popup window asking to authorize the BigQuery Data Transfer Service should appear. Select the student account and click Allow.
# enable data transfer service

# Click Check my progress to verify the objective.
# Create a new dataset within an existing project and Copy an existing table

# Grant permission to the users to access the table
# For the purposes of this lab, a dataset and table have been provided for you in BigQuery.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Under your project, inside of demo_dataset, open the top_terms table.

# top-terms-table

# Click Share.

# Click on Add Principal and add the two customer users:

# Customer 1 username
# Customer 2 username
# Select the BigQuery Data Viewer role.

# add bigquery data viewer principal

# Click Save.
# Click Check my progress to verify the objective.
# Grant permission to the users to access the table

# Authorize a dataset and grant permission to the users
# Open the demo_dataset and click + Sharing > Authorize Datasets.
# authorize datasets

# Select the Dataset ID that needs to be authorized to share: Data Sharing Partner Project ID.demo_dataset.
# select dataset ID

# Click Add Authorization.

# Click on Sharing > Permissions > Add Principal and add the two customer users:

# Customer 1 username
# Customer 2 username
# Select the BigQuery User role.

# add principals to shared dataset

# Click Save.
# Great! You have successfully shared the dataset and table with the two customer users.

# Click Check my progress to verify the objective.
# Authorize a dataset and grant permission to the users

# Verify dataset sharing for customer projects
# In this section, you will verify the datasets and tables were shared for each customer user.

# Verify dataset sharing for customer 1
# Close the Data Sharing Partner Project Console and open the Customer Project 1 Console. Log in with the associated credentials.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Run the following query, which selects all columns from the demo_dataset.top_terms table from the Data Sharing Partner project:

# SELECT * FROM `Project ID.demo_dataset.top_terms`
# Copied!
# You should now see the results populated.

# On the query toolbar, select Save > Save View.

# Click in the Dataset field and select Create New Dataset.

# For the Dataset ID, type customer_1_dataset
# For Location type choose Multi-region and select US (multiple regions in United States) from dropdown.
# Click Create Dataset.

# In the Table field, type customer_1_table.

# save consumer 1 view

# Click Save.

# Refresh your window.

# You should now be able to see the dataset and table, as well as query it.

# Verify dataset sharing for customer 2
# Close the Customer Project 1 Console and open the Customer Project 2 Console. Log in with the associated credentials.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Run the following query, which selects all columns from the demo_dataset.top_terms table from the Data Sharing Partner project:

# SELECT * FROM `Project ID.demo_dataset.top_terms`
# Copied!
# You should now see the results populated.

# On the query toolbar, select Save > Save View.

# Click in the Dataset field and select Create New Dataset.

# For the Dataset ID, type customer_2_dataset
# For Location type choose Multi-region and select US (multiple regions in United States) from dropdown.
# Click Create Dataset.

# In the Table field, type customer_2_table.

# save customer 1 view

# Click Save.

# Refresh your window.

# You should now be able to see the dataset and table, as well as query it.

# Click Check my progress to verify the objective.
# Verify dataset sharing for customer projects

# Congratulations!
# In this lab, you learned how to use BigQuery to publish datasets to share externally. You first granted permissions via IAM for data access, copied an existing table to a newly created dataset, then authorized a dataset and granted permissions to the users to access a table. Lastly, you verified the dataset and table were shared properly for both of the customer projects.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated February 13, 2023

# Lab Last Tested February 13, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.