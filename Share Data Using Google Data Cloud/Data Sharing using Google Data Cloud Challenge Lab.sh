# Data Sharing using Google Data Cloud: Challenge Lab
# 1 hour
# 5 Credits
# GSP375
# Google Cloud self-paced labs logo

# Overview
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students who have enrolled in the Data Sharing using Google Data Cloud quest. Are you ready for the challenge?

# Topics tested:
# Share BigQuery datasets across Google Cloud projects

# Enrich datasets based on a curated data

# Enable bi-directional data exchange

# Create a visualization in Data Studio

# Setup and requirements
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Challenge scenario
# You are a Google Cloud Data Sharing Partner hosting an application for multiple customers, storing data, and providing analytics as a service. The application caters to a customer that depends on your data data to enrich their application data. In turn, the customer then shares high-level metrics with the Data Sharing Partner to better understand the customer footprint.

# In this lab, you will be required to act as both the Data Sharing Partner and the customer by enabling bi-directional data exchange in BigQuery, as well as creating a visualization in Data Studio.

# lab architectural diagram

# Task 1. Create the partner authorized view
# Your first task as a Data Sharing Partner is to copy a BigQuery public dataset into your project. The dataset contains details of each zip code across the US. In this section, you will need to expose the loaded dataset as an authorized view and grant access to a specific customer user.

# For this task, you will need to be logged into the Data Sharing Partner Project Console with the associated credentials.
# Create an authorized view named Partner authorized view name based off of the following query. Save it inside demo_dataset.

# SELECT
#  *
# FROM
#  `bigquery-public-data.geo_us_boundaries.zip_codes`;
# Copied!
# Click Check my progress to verify the objective.
# Create the partner authorized view

# Authorize the view
# Next, you will need to assign IAM permissions by authorizing the view in the dataset.

# Authorize the Partner authorized view name view you just created.

# Assign IAM permissions for the customer user
# Next, you will need to grant the Customer user the BigQuery Data Viewer role on the authorized view you created.

# Grant the customer user access to the Partner authorized view name view.
# Their username is: Customer username
# Grant them the BigQuery Data Viewer role
# Click Check my progress to verify the objective.
# Authorize the view and Assign IAM permissions for the customer user

# Task 2. Update the customer data table
# In this task, you will be acting as the customer. Your next step is to run a query to update the customer table inside of your project.

# For this task, you will need to be logged into the Customer Project Console with the associated credentials.
# Execute the query below to update the county value in the customer table.
# UPDATE
#  `Customer A Project ID.customer_dataset.customer_info` cust
# SET
# cust.county=vw.county
# FROM
# `Partner Project ID.demo_dataset.Partner authorized view` vw
# WHERE
# vw.zip_code=cust.postal_code;
# Copied!
# You should see the following result:

# This statement modified 14 rows in customer_info.
# Task 3. Create the customer authorized view
# In this section, you will need to create a customer authorized view and grant access to a specific Data Sharing Partner user.

# For this task, you will need to be logged into the Customer Project Console with the associated credentials.
# Create an authorized view named Customer authorized table name based off of the following query that lists the counties and number of customers in the listed counties. Save it inside customer_dataset.
# SELECT
#   county,
# COUNT(1) AS Count
# FROM
#  `Customer A Project ID.customer_dataset.customer_info` cust
# GROUP BY
#  county
# HAVING county is not null
# Copied!
# Click Check my progress to verify the objective.
# Create the customer authorized view

# Authorize the view
# Next, you will need to assign IAM permissions by authorizing the customer view in the dataset.

# Authorize theCustomer authorized table name view you just created.

# Assign IAM permissions for the partner user
# Next, you will need to grant the Data Sharing Partner user the BigQuery Data Viewer role on the customer authorized view you created.

# Grant the Data Sharing Partner user access to theCustomer authorized table name view.
# Their username is: Partner username
# Grant them the BigQuery Data Viewer role
# Click Check my progress to verify the objective.
# Authorize the view and Assign IAM permissions for the partner user

# Task 4. Use the customer authorized view to create a visualization
# Your fourth task is to consume the customer’s authorized view in the Data Sharing Partner project and create a column chart visualization that shows the distribution of the customers and counties.

# For this task, you will need to be logged into the Data Sharing Partner Project Console with the associated credentials.
# Connect BigQuery to Data Studio
# Open Google Data Studio and create a Blank Report.

# Connect BigQuery and authorize to Data Studio.

# From My Projects on the left pane, navigate to the customer project and select Customer authorized table name. Add the table to the blank report.

# Click Check my progress to verify the objective.
# Connect BigQuery to Data Studio

# Create a visualization in Data Studio
# Create a visualization with the following requirements:
# Report name: Data Sharing Partner Vizualization
# For the visualization, insert a Column Chart
# For the Column Chart, set county as the Dimension and Count as the Breakdown Dimension and Metric.
# The visualization should resemble the following:

# visualization of report

# Congratulations!
# In this lab, you shared BigQuery datasets across Google Cloud projects, enriched datasets based on curated data, enabled bi-directional data exchange, and created a visualization.

# Share Data Using Google Data Cloud skill badge

# Earn Your Next Skill Badge
# This self-paced lab is part of the Share Data Using Google Data Cloud skill badge quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge. Search the catalog for 20+ other skill badge quests in which you can enroll.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: June 17, 2022

# Lab Last Tested: June 08, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.