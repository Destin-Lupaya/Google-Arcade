# Create and Manage AlloyDB Databases - Challenge Lab
# 1 hour 30 minutes
# 5 Credits
# GSP395
# Google Cloud Self-Paced Labs logo

# Overview
# In this challenge lab, lab you are given a set number of tasks to perform. These have all been covered in the quest Create and Manage AlloyDB Databases. You will not be given step-by-step instructions, but you will be given certain directives which you must follow, such as the naming of certain resources, or some guidelines about how you should solve the problems.

# Scenario
# In your role as the corporate Database Administrator you have been tasked with standing up a new AlloyDB for PostgreSQL database for your company's HR Operations group. You have been provided a list specifcations for this database related to tables to create and data to load.

# Objectives
# In this challenge lab, you are required to perform the following tasks:

# Create a cluster and instance

# Create tables in your instance

# Load simple datasets into tables

# Create a Read Pool instance

# Create a backup

# Target Audience
# The content of this challenge lab will be most applicable to AlloyDB for PostgreSQL DBAs. This lab is designed to test the abilities of students who have completed the Create and Manage AlloyDB Databases quest.

# Setup and Requirements
# Qwiklabs setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# What you need
# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Time to complete the lab.
# Note: If you have a personal Google Cloud account or project, do not use it for this lab.
# Note: If you are using a Pixelbook, open an Incognito window to run this lab.
# Cloud Console
# Log in to Google Cloud Console
# Using the browser tab or window you are using for this lab session, copy the Username from the Connection Details panel and click the Open Google Console button.
# Note: If you are asked to choose an account, click Use another account.
# Paste in the Username, and then the Password as prompted.
# Click Next.
# Accept the terms and conditions.
# Since this is a temporary account, which will last only as long as this lab:

# Do not add recovery options

# Do not sign up for free trials

# Once the console opens, view the list of services by clicking the Navigation menu (Navigation menu icon) at the top-left.
# Navigation menu

# Activate Cloud Shell
# Cloud Shell is a virtual machine that contains development tools. It offers a persistent 5-GB home directory and runs on Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources. gcloud is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab completion.

# Click the Activate Cloud Shell button (Activate Cloud Shell icon) at the top right of the console.

# Click Continue.
# It takes a few moments to provision and connect to the environment. When you are connected, you are also authenticated, and the project is set to your PROJECT_ID.

# Sample commands
# List the active account name:

# gcloud auth list
# Copied!
# (Output)

# Credentialed accounts:
#  - <myaccount>@<mydomain>.com (active)
# (Example output)

# Credentialed accounts:
#  - google1623327_student@qwiklabs.net
# List the project ID:

# gcloud config list project
# Copied!
# (Output)

# [core]
# project = <project_ID>
# (Example output)

# [core]
# project = qwiklabs-gcp-44776a13dea667a6
# Note: Full documentation of gcloud is available in the gcloud CLI overview guide.
# Task 1. Create a cluster and instance
# Your first task is to create a cluster.

# You may complete this step using the Cloud Console or the gcloud CLI. If you use the glcoud CLI you must refer to and use the GCP Region value that is provided on your lab launch page.

# Your cluster must have following attributes. You can keep the default values for all other settings:

# Item	Value
# Cluster ID	lab-cluster
# Password	Change3Me
# Network	peering-network



# Note: The private services access connection option was configured for this project when you started the lab. This step was required to allow access to the AlloyDB cluster.
# If you are using the gcloud CLI, an example command to create a cluster is as follows.

# Note: You must substitute the required values or your configuration will be invalid and you will not pass this challenge lab.
# gcloud beta alloydb clusters create SAMPLE-CLUSTER-ID \
#     --password=SAMPLE_PASSWORD \
#     --network=SAMPLE_NETWORK \
#     --region=GCP_REGION_VALUE \
#     --project=QWIKLABS_PROJECT_ID
# Next you must create an instance. If you following the Cloud Console wizard, your cluster's instance must have following attributes:
# Item	Value
# Instance ID	lab-instance
# Machine Type	2 vCPU, 16 GB



# If you are using the gcloud CLI, an example command to create an instance is as follows.

# Note: You must substitute the required values or your configuration will be invalid and you will not pass this challenge lab.
# gcloud beta alloydb instances create SAMPLE-INSTANCE-ID \
#     --instance-type=PRIMARY \
#     --cpu-count=2 \
#     --region=GCP_REGION_VALUE  \
#     --cluster=SAMPLE-CLUSTER-ID  \
#     --project=QWIKLABS_PROJECT_ID
# When you are on the Overview page for the new cluster you created, please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step.

# Click Check my progress to verify the objective.

# Create a cluster and instance
# Task 2. Create tables in your instance
# Next you must create tables in your AlloyDB instance. A VM named, alloydb-client, containing the PostgreSQL client was provisioned for you at the start of the lab.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the following environment variable, replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance from the previous task.

# export ALLOYDB=ALLOYDB_ADDRESS
# Copied!
# Run the following command to store the Private IP address of the AlloyDB instance on the AlloyDB client VM so that it will persist throughout the challenge lab.

# echo $ALLOYDB  > alloydbip.txt 
# Copied!
# Use the following command to launch the PostgreSQL (psql) client. You will be prompted to provide the postgres user's password (Change3Me) which you entered when you created the cluster.

# psql -h $ALLOYDB -U postgres
# Copied!
# Your database must have a total of three (3) tables - regions, countries, and departments.

# The tables must be defined as listed below.

# An example DDL command to create an AlloyDB table is as follows:

# CREATE TABLE sample (
#     sample_id bigint NOT NULL,
#     sample_name varchar(25)
# ) ;
# ALTER TABLE sample ADD PRIMARY KEY (sample_id);
# Table: regions

# Primary Key: region_id

# Column	Datatype
# region_id	bigint NOT NULL
# region_name	varchar(25)



# Table: countries

# Primary Key: country_id

# Column	Datatype
# country_id	char(2) NOT NULL
# country_name	varchar(40)
# region_id	bigint



# Table: departments

# Primary Key: department_id

# Column	Datatype
# department_id	smallint NOT NULL
# department_name	varchar(30)
# manager_id	integer
# location_id	smallint



# Task 3. Load simple datasets into tables
# Next load the tables you just created with the following simple, low-volume datasets.

# You must use the psql client to load these tables. Use the alloydb-client VM as outlined in the previous task to access the psql client.

# Note: The data elements provided are written in the order of the columns of the corresponding table.
# An example DML command to load a single row into an AlloyDB table is as follows.

# INSERT INTO Sample
# VALUES 
#   (1, 'Sample Value'); 



# Table: regions

# 1, 'Europe'
# 2, 'Americas'
# 3, 'Asia'
# 4, 'Middle East and Africa'
# Copied!
# Table: countries

# 'IT', 'Italy', 1 
# 'JP', 'Japan', 3 
# 'US', 'United States of America', 2 
# 'CA', 'Canada', 2 
# 'CN', 'China', 3 
# 'IN', 'India', 3 
# 'AU', 'Australia', 3 
# 'ZW', 'Zimbabwe', 4 
# 'SG', 'Singapore', 3 
# Copied!
# Table: departments

# 10, 'Administration', 200, 1700
# 20, 'Marketing', 201, 1800
# 30, 'Purchasing', 114, 1700
# 40, 'Human Resources', 203, 2400
# 50, 'Shipping', 121, 1500
# 60, 'IT', 103, 1400
# Copied!
# Click each Check my progress to verify the objectives.
# Create and Load Tables
# Task 4. Create a Read Pool instance
# Next create a Read Pool instance for your cluster. You may create the Read Pool instance using the Cloud Console or the gcloud CLI. If you use the glcoud CLI you must refer to and use the GCP Region value that is provided on your lab launch page.

# Your Read Pool instance must have following attributes. You can keep the default values for all other settings:

# Item	Value
# Read pool instance ID	lab-instance-rp1
# Node count	2
# Machine Type	2 vCPU, 16 GB



# If you are using the gcloud CLI, an example command to create a Read Pool instance is as follows.

# Note: You must substitute the required values or your configuration will be invalid and you will not pass this challenge lab.
#     gcloud beta alloydb instances create SAMPLE-READ-POOL-INSTANCE-ID \
#     --instance-type=READ_POOL \
#     --cpu-count=2 \
#     --read-pool-node-count=2 \
#     --region=GCP_REGION_VALUE  \
#     --cluster=SAMPLE-CLUSTER-ID  \
#     --project=QWIKLABS_PROJECT_ID
# Click Check my progress to verify the objective.
# Create a read pool instance
# Task 5. Create a backup
# Next create an on-demand backup of your instance. You may create the backup using the Cloud Console or the gcloud CLI. If you use the glcoud CLI you must refer to and use the GCP Region value that is provided on your lab launch page.

# On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Backups to launch the Backups page.

# Your backup must be named lab-backup.

# If you are using the gcloud CLI, an example command to create a backup is as follows.

# Note: You must substitute the required values or your configuration will be invalid and you will not pass this challenge lab.
#     gcloud beta alloydb backups create SAMPLE-BACKUP_ID \
#     --cluster=SAMPLE-CLUSTER-ID \
#     --region=GCP_REGION_VALUE \
#     --project=QWIKLABS_PROJECT_ID
# Click Check my progress to verify the objective.
# Create a backup
# Congratulations!
# You have completed the Create and Manage AlloyDB Databases: Challenge Lab! In this lab, you created a Cloud Spanner instance and database, created tables, loaded data, and performed DDL operations on a table. You have earned the following skill badge.

# QST_CMADB_BDG_S_EN.png

# Earn Your Next Skill Badge
# This self-paced lab is part of the Create and Manage AlloyDB Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab.

# Search for other available quests in the Cloud Skills Boost catalog.

# End your lab
# When you have completed your lab, click End Lab. Qwiklabs removes the resources you’ve used and cleans the account for you.

# You will be given an opportunity to rate the lab experience. Select the applicable number of stars, type a comment, and then click Submit.

# The number of stars indicates the following:

# 1 star = Very dissatisfied
# 2 stars = Dissatisfied
# 3 stars = Neutral
# 4 stars = Satisfied
# 5 stars = Very satisfied
# You can close the dialog box if you don't want to provide feedback.

# For feedback, suggestions, or corrections, please use the Support tab.

# Copyright 2022 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.