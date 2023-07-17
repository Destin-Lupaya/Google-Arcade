# Create and Manage Cloud Spanner Databases: Challenge Lab
# 1 hour 30 minutes
# 1 Credit
# GSP381
# Google Cloud self-paced labs logo

# Overview
# In this challenge lab, lab you are given a set number of tasks to perform. These have all been covered in the quest Create and Manage Cloud Spanner Databases. You will not be given step-by-step instructions, but you will be given certain directives which you must follow, such as the naming of certain resources, or some guidelines about how you should solve the problems.

# Scenario
# In your role as the corporate Database Administrator you have been tasked with standing up a new Cloud Spanner database for your company's Banking Operations group. You have been provided a list specifcations for this database related to tables datasets to load.

# Objectives
# In this challenge lab, you are required to perform the following tasks:

# Create a Cloud Spanner instance.

# Create a Cloud Spanner database.

# Create a tables in your database.

# Load simple datasets into tables

# Load a complex dataset.

# Add a new column to an existing table.

# Target Audience
# The content of this challenge lab will be most applicable to Cloud Spanner DBAs. This lab is designed to test the abilities of students who have completed the Create and Manage Cloud Spanner Databases quest.

# Setup and Requirements
# Qwiklabs setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Cloud Console
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
# Task 1. Create a Cloud Spanner instance
# Your first task is to create an instance.

# You may complete this step using the Cloud Console or the gcloud CLI.

# Your instance must have following attributes:

# Item	Value
# Name	banking-ops-instance
# Region	us-central1
# Allocate Compute Capacity	Unit - Nodes // Quantity - 1



# An example gcloud CLI command to create an instance is as follows:

# gcloud spanner instances create my-sample-instance \
# --config=regional-us-central1  \
# --description="Sample Instance" \
# --nodes=1
# Click Check my progress to verify the objective.
# Create an instance
# Task 2. Create a Cloud Spanner database
# Your next task is to create a database.

# You may complete this step using the Cloud Console or the gcloud CLI.

# Your database must have following attribute:

# Item	Value
# Name	banking-ops-db



# An example gcloud CLI command to create a database is as follows:

# gcloud spanner databases create my-sample-db \
# --instance=my-sample-instance
# Click Check my progress to verify the objective.
# Create a database
# Task 3. Create tables in your database
# Your database must have a total of four (4) tables - Portfolio, Category, Product, and Customer.

# The tables must be defined as listed below.

# An example DDL command to create a table is as follows:

# CREATE TABLE Sample (
#   SampleId INT64 NOT NULL,
#   SampleName STRING(MAX)
# ) PRIMARY KEY (SampleId); 
# Table: Portfolio

# Primary Key: PortfolioId

# Column	Datatype
# PortfolioId	INT64 NOT NULL
# Name	STRING(MAX)
# ShortName	STRING(MAX)
# PortfolioInfo	STRING(MAX)



# Table: Category

# Primary Key: CategoryId

# Column	Datatype
# CategoryId	INT64 NOT NULL
# PortfolioId	INT64 NOT NULL
# CategoryName	STRING(MAX)
# PortfolioInfo	STRING(MAX)



# Table: Product

# Primary Key: ProductId

# Column	Datatype
# ProductId	INT64 NOT NULL
# CategoryId	INT64 NOT NULL
# PortfolioId	INT64 NOT NULL
# ProductName	STRING(MAX)
# ProductAssetCode	STRING(25)
# ProductClass	STRING(25)



# Table: Customer

# Primary Key: CustomerId

# Column	Datatype
# CustomerId	STRING(36) NOT NULL
# Name	STRING(MAX) NOT NULL
# Location	STRING(MAX) NOT NULL



# Task 4. Load simple datasets into tables
# Three of your tables, Portfolio, Category, and Product, will be loaded with simple, low-volume datasets.

# You may employ any method to load these tables.

# Note: The data elements provided are ordered to match the order of the columns of the corresponding table.
# An example DML command to load a single row into a table is as follows:

# INSERT INTO
#   Sample (SampleId, SampleName)
# VALUES 
#   (1, "Banking"); 
# Table: Portfolio

# 1, "Banking", "Bnkg", "All Banking Business"
# 2, "Asset Growth", "AsstGrwth", "All Asset Focused Products"
# 3, "Insurance", "Insurance", "All Insurance Focused Products"
# Copied!
# Table: Category

# 1,1,"Cash"
# 2,2,"Investments - Short Return"
# 3,2,"Annuities"
# 4,3,"Life Insurance"
# Copied!
# Table: Product

#  1,1,1,"Checking Account","ChkAcct","Banking LOB"
#  2,2,2,"Mutual Fund Consumer Goods","MFundCG","Investment LOB"
#  3,3,2,"Annuity Early Retirement","AnnuFixed","Investment LOB"
#  4,4,3,"Term Life Insurance","TermLife","Insurance LOB"
#  5,1,1,"Savings Account","SavAcct","Banking LOB"
#  6,1,1,"Personal Loan","PersLn","Banking LOB"
#  7,1,1,"Auto Loan","AutLn","Banking LOB"
#  8,4,3,"Permanent Life Insurance","PermLife","Insurance LOB"
#  9,2,2,"US Savings Bonds","USSavBond","Investment LOB"
# Copied!
# Click each Check my progress to verify the objectives.
# Create and Load Tables
# Task 5. Load a complex dataset
# You will load the Customer table with a much larger set of data.

# A file named Customer_List_500.csv contains 500 rows of data and is located in the following public Cloud Storage bucket. You may reference or download it as necessary.

# gsutil URI

# gs://cloud-training/OCBL375/Customer_List_500.csv
# Copied!
# HTTP URL

# https://storage.googleapis.com/cloud-training/OCBL375/Customer_List_500.csv
# Copied!
# You may recall from the lab Cloud Spanner - Loading Data and Performing Backups that a few options exist to load larger datasets. These include using Dataflow or a client library in Batch mode. You may choose to create simple insert statements. The decision is yours but you must load all 500 rows.

# Utilize any method that you prefer to load the 500 row datafile. Some methods will require edits to the datafile which will require downloading it to your local machine. Please be sure to make a backup file if you choose that option.

# Note: if you use Dataflow should ensure that you specify the us-west1 Regional Endpoint and reset the Dataflow API via the following gcloud command:

# gcloud services disable dataflow.googleapis.com --force
# gcloud services enable dataflow.googleapis.com
# Copied!
# Also if you use a Dataflow template you will be required to provide a Mainfest file named manifest.json. Below is a sample manifest.json that you can use to guide creation of a file appropriate for loading the Customer table.
# Note: This sample cannot be used as is, you must update it accordingly.
# Note:

# {
#     "tables": [
#         {
#             "table_name": "TABLE_NAME",
#             "file_patterns": [
#                 "gs://BUCKET/FOLDER/FILENAME.SUFFIX"
#             ],
#             "columns": [
#                 {"column_name" : "UPDATE_COLUMN1", "type_name" : "UPDATE_DATATYPE" },
#                 {"column_name" : "UPDATE_COLUMN2", "type_name" : "UPDATE_DATATYPE" },
#                 {"column_name" : "UPDATE_COLUMN3", "type_name" : "UPDATE_DATATYPE" }
#             ]
#         }
#     ]
# }
# Copied!
# Click Check my progress to verify the objective.
# Load Customer table
# Task 6. Add a new column to an existing table
# As part of your DBA responsibilities you are required to add a new column called MarketingBudget to the Category table.

# The column MarketingBudget must have a datatype of INT64.

# Adding a new column is accomplished by a DDL command. You may issue the DDL via a gcloud command, the Cloud Console, or client library call.

# An example gcloud CLI command to add a column to a table is as follows:

# gcloud spanner databases ddl update my-sample-db \
# --instance=my-sample-instance \
# --ddl='ALTER TABLE Sample ADD COLUMN SampleValue INT64;'
# Click Check my progress to verify the objective.
# Add Column
# Congratulations!
# You have completed the Create and Manage Cloud Spanner Databases: Challenge Lab! In this lab, you created a Cloud Spanner instance and database, created tables, loaded data, and performed DDL operations on a table. You have earned the following skill badge.

# QST_CMCSD_BDG_S_EN_V2.png

# Earn Your Next Skill Badge
# This self-paced lab is part of the Create and Manage Cloud Spanner Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab.

# Search for other available quests in the Cloud Skills Boost catalog.

# Manual Last Updated: August 18, 2022
# Lab Last Tested: March 24, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
