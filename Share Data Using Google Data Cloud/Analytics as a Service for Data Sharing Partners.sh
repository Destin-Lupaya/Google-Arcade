# Analytics as a Service for Data Sharing Partners
# 30 minutes
# 1 Credit
# GSP1042
# Google Cloud self-paced labs logo

# Overview
# A common scenario is where a Google Cloud Data Sharing Partner has proprietary datasets that customers can use for their analytics use cases. Customers need to subscribe to this data, query it within their own platform, then augment it with their own datasets and use their visualization tools for their customer facing dashboards. This enables Data Sharing Partners to simplify and accelerate how they build and deliver value from data-driven solutions.

# overview diagram

# Through integration with Google Cloud IAM, you can set permissions on BigQuery objects to enable access by users inside or outside of organizations. In this lab, you will learn how both Data Sharing Partners and their customers can use BigQuery data stored in a partner project in the form of customer facing dashboards for analytics as a managed service. You will be given three projects: the Data Sharing Partner project which owns the dataset and two separate and distinct customers who can access a subset of the dataset from their respective projects. Customers will list customer information specific to their geographical region.

# Objectives
# In this lab, you will:

# Copy a public dataset into a Data Sharing Partner Project

# Create distinct authorized views for each customer

# Consume the authorized views to create customer-specific dashboards

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
# Create authorized views
# In the first project, you will take on the role of an Data Sharing Partner creating and sharing a dataset using an authorized view.

# Create Authorized View A
# From the lab pane. open the Data Sharing Partner Project Console and log in with the associated credentials.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Run the following query to create an authorized view for Customer A, based on a public geographical dataset.

# SELECT * FROM `bigquery-public-data.geo_us_boundaries.zip_codes`
# WHERE state_code="TX"
# LIMIT 4000
# Copied!
# From the toolbar, click Save > Save View.

# Keep the project as default and for the Dataset select demo_dataset.

# For Table type authorized_view_a.

# Click Save.

# Create Authorized View B
# In the query editor, remove the previous query you just ran.

# Run the following query to create an authorized view for Customer B, based on a public geographical dataset.

# SELECT * FROM `bigquery-public-data.geo_us_boundaries.zip_codes`
# WHERE state_code="CA"
# LIMIT 4000
# Copied!
# From the toolbar, click Save > Save View as.

# Keep the project as default and for the Dataset select demo_dataset.

# For Table type authorized_view_b.

# Click Save.

# Your authorized views should resemble the following:

# authorized views

# Click Check my progress to verify your performed task.

# Created Authorized Views
# Assign IAM permissions to both the views
# From the BigQuery Explorer pane, open the demo_dataset and click + Sharing > Authorize Views.
# authorize views

# Add Authorized View A that needs to be authorized to share: Data Sharing Partner Project ID.demo_dataset.authorized_view_a.

# Click Add Authorization.

# Add Authorized View B that needs to be authorized to share: Data Sharing Partner Project ID.demo_dataset.authorized_view_b.

# Click Add Authorization. Your authorized views should resemble the following:

# authorized views

# Click Close.
# Click Check my progress to verify your performed task.

# Assign IAM permissions to both the views
# Grant permissions to the users to access the views
# In this section, you will assign permissions for each customer user and their associated authorized views.

# Assign IAM permissions for Customer A
# Under your project, inside of demo_dataset, open the authorized_view_a view.

# Click Share.

# Click on Add Principal and add the Customer A user:

# Customer A username
# Select the BigQuery Data Viewer role.

# add bigquery data viewer principal

# Click Save.

# Assign IAM permissions for Customer B
# Under your project, inside of demo_dataset, open the authorized_view_b view.

# Click Share.

# Click on Add Principal and add the Customer B user:

# Customer B username
# Select the BigQuery Data Viewer role.

# add bigquery data viewer principal

# Click Save.
# Click Check my progress to verify your performed task.

# Grant permissions to the users to access the views
# Display insights for View A
# In this section, you will verify that the authorized views were shared for each customer user correctly.

# Verify authorized view sharing for Customer A
# Close the Data Sharing Partner Project Console and from the lab pane open the Customer Project A Console. Log in with the associated credentials.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Now you will join the data from Customer A's authorized view to the customer specific dataset to generate new insights.

# Run the following query to find all customers in a State. Since the authorized view available to Customer A is filtered on the state of Texas, the query should return only customers in that state.
# SELECT geos.zip_code, geos.city, cust.last_name, cust.first_name
# FROM `Customer A Project ID.customer_a_dataset.customer_info` as cust
# JOIN `Partner Project ID.demo_dataset.authorized_view_a` as geos
# ON geos.zip_code = cust.postal_code;
# Copied!
# Your results should resemble the following:

# customer a query

# On the query toolbar, select Save > Save View.

# Click in the Dataset field and select customer_a_dataset.

# In the Table field, type customer_a_table.

# Click Save. You should now be able to see the dataset and table, as well as query it.

# Connect BigQuery to Data Studio
# Open Google Data Studio.

# On the Reports page, in the Start with a Template section, click the Blank Report template. This creates a new untitled report.

# If prompted, complete the Marketing Preferences and the Account and Privacy settings and then click Save. You may need to click the Blank template again after saving your settings.
# In the Add data to report window, in the search box, enter BigQuery.
# add bigquery data

# Click the BigQuery Connector.

# For Authorization, click Authorize. This action lets Google Data Studio access to your Google Cloud project.

# In the Request for permission dialog, click Allow to give Google Data Studio the ability to view data in BigQuery.
# Select Recent Projects from the left pane, select Customer A Project ID > customer_a_dataset > customer_a_table.
# connect customer a table

# Click Add.

# When prompted, click Add to Report.

# add data to report

# Create a visualization in Data Studio
# At the top of the page, click Untitled Report to change the report name. Type Customer A Vizualization.

# After the report editor loads, click Insert > Pie chart.

# On the Pie Chart Data tab, notice the value for Data Source (customer_a_table) and the default values for Dimension and Metric: zip_code and Record Count.

# Drag city from Available Fields onto the zip_code dimension to replace it.

# The visualization should resemble the following:

# customer a visualization

# Verify Analytics security
# From the toolbar, expand + Share > Get report link.
# get report link

# In the pop-up dialogue, click Copy Link and save it somewhere. Exit out of the window.

# Click the student profile in the top right and click Sign out.

# sign out

# Select Use another account.
# use another account

# Log in with the Customer B user credentials.

# You will be taken to your Google Account home page.

# Open a new tab and navigate to the Data Studio link you copied earlier.

# cant access report

# Upon logging in as Customer B, you should not be able to access the Analytics Dashboard of Customer A since you are not authorized.

# Click Check my progress to verify your performed task.

# Display insights for View A
# Display insights for View B
# Verify authorized view sharing for Customer B
# Close the Customer Project A Console and from the lab pane open the Customer Project B Console. Log in with the associated credentials.

# From the Navigation Menu, go to BigQuery > SQL Workspace.

# Now you will join the data from Customer B's authorized view to the customer specific dataset to generate new insights.

# Run the following query to find all customers in a State. Since the authorized view available to Customer A is filtered on the state of California, the query should return only customers in that state.
# SELECT geos.zip_code, geos.city, cust.last_name, cust.first_name
# FROM `Customer B Project ID.customer_b_dataset.customer_info` as cust
# JOIN `Partner Project ID.demo_dataset.authorized_view_b` as geos
# ON geos.zip_code = cust.postal_code;
# Copied!
# Your results should resemble the following:

# customer b query

# On the query toolbar, select Save > Save View.

# Click in the Dataset field and select customer_b_dataset.

# In the Table field, type customer_b_table.

# Click Save. You should now be able to see the dataset and table, as well as query it.

# Connect BigQuery to Data Studio
# Open Google Data Studio.

# On the Reports page, in the Start with a Template section, click the Blank Report template. This creates a new untitled report.

# If prompted, complete the Marketing Preferences and the Account and Privacy settings and then click Continue. You may need to click the Blank template again after saving your settings.
# In the Add data to report window, in the search box, enter BigQuery.
# add bigquery data

# Click the BigQuery Connector.

# For Authorization, click Authorize. This action lets Google Data Studio access to your Google Cloud project.

# In the Request for permission dialog, click Allow to give Google Data Studio the ability to view data in BigQuery.
# Select Recent Projects from the left pane, select Customer B Project ID > customer_b_dataset > customer_b_table.
# connect customer b table

# Click Add.

# When prompted, click Add to Report.

# add data to report

# Create a visualization in Data Studio
# At the top of the page, click Untitled Report to change the report name. Type Customer B Vizualization.

# After the report editor loads, click Insert > Pie chart.

# On the Pie Chart Data tab, notice the value for Data Source (customer_b_table) and the default values for Dimension and Metric: zip_code and Record Count.

# Drag city from Available Fields onto the zip_code dimension to replace it.

# The visualization should resemble the following:

# customer b visualization

# Verify Analytics security
# From the toolbar, expand + Share > Get report link.
# get report link

# In the pop-up dialogue, click Copy Link and save it somewhere. Exit out of the window.

# Click the student profile in the top right and click Sign out.

# sign out

# Select Use another account.
# use another account

# Log in with the Customer A user credentials.

# You will be taken to your Google Account home page.

# Open a new tab and navigate to the Data Studio link you copied earlier.

# cant access report

# Upon logging in as Customer A, you should not be able to access the Analytics Dashboard of Customer B since you are not authorized.

# Click Check my progress to verify your performed task.

# Display insights for View B
# Congratulations!
# In this lab, you learned how to copy datasets from a Data Sharing Partner to a customer's BigQuery project, create distinct authorized views for each customer, and consume the authorized views to create customer-specific dashboards.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated January 25, 2023

# Lab Last Tested January 25, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.