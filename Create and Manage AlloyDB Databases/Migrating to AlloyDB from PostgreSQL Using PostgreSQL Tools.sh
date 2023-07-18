# Migrating to AlloyDB from PostgreSQL Using PostgreSQL Tools
# 1 hour 30 minutes
# 5 Credits
# GSP1085
# Google Cloud Self-Paced Labs logo

# Overview
# AlloyDB for PostgreSQL is a fully managed PostgreSQL-compatible database service for your most demanding enterprise database workloads. AlloyDB combines the best of Google with one of the most popular open-source database engines, PostgreSQL, for superior performance, scale, and availability.

# In this lab, you migrate a stand-alone PostgreSQL database (running on a virtual machine) to AlloyDB for PostgreSQL using native PostgreSQL tools. One of the database migration options supported by AlloyDB is the import of a DMP file. The DMP file must be created using the pg_dump tool with the custom or directory format setting. The DMP must be imported using the pg_restore tool.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Verify Data in Source Instance for Migration

# Create a database DMP file using pg_dump

# Import DMP file using pg_restore

# Setup and requirements
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
# Task 1. Verify Data in Source Instance for Migration
# On the Navigation menu (console_nav_small.png), under Compute Engine click VM instances.

# For the instance named pg14-source, in the Connect column, click SSH to open a terminal window.

# Use the following command to launch the PostgreSQL (psql) client.

# sudo -u postgres psql
# Copied!
# You will be presented the psql terminal prompt similar to as shown below.
# psql (14.5 (Debian 14.5-1.pgdg110+1))
# Type "help" for help.
# Input and run the following SQL command to see the HR related tables in the postgres database.

# \dt
# Copied!
#            List of relations
#  Schema |    Name     | Type  |  Owner   
# --------+-------------+-------+----------
#  public | countries   | table | postgres
#  public | departments | table | postgres
#  public | employees   | table | postgres
#  public | jobs        | table | postgres
#  public | locations   | table | postgres
#  public | regions     | table | postgres
# (6 rows)
# Run the following queries to determine the row counts for each table.

# select count (*) as countries_row_count from countries;
# select count (*) as departments_row_count from departments;
# select count (*) as employees_row_count from employees;
# select count (*) as jobs_row_count from jobs;
# select count (*) as locations_row_count from locations;
# select count (*) as regions_row_count from regions;
# Copied!
# The source table rows counts are as follows.
# Name	Rows
# countries	25
# departments	27
# employees	107
# jobs	19
# locations	23
# regions	4



# Type \q to exit the psql client.

# Task 2. Create a database DMP file using pg_dump
# The pg_dump tool is installed by default with every PostgreSQL installation. In the pg14-source terminal, create a DMP file of the postgres database containing the HR tables you examined earlier. Run the the following command at the shell prompt. Note: the '-Fc' flag designates a custom format DMP file.

# sudo -u postgres pg_dump -Fc postgres > pg14_source.DMP
# Copied!
# Browse the directory to confirm the size and other details of the DMP file.

# ls -l -h pg14_source.DMP
# Copied!
# -rw-r--r-- 1 student-03-171e0d8475af google-sudoers 13K Aug 27 21:19 pg14_source.DMP
# To simulate a routine database export/import, migrate the DMP file to a Cloud Storage bucket. A bucket named after your Qwiklabs Project ID was created at lab startup.
# gsutil cp pg14_source.DMP gs://Project ID/pg14_source.DMP
# Copied!
# Click Check my progress to verify the objective.
# Upload database DMP file to Cloud Storage
# Task 3. Import DMP file using pg_restore
# An AlloyDB cluster and instance were provisioned when you started the lab. On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters to examine the cluster's details.

# The cluster is named lab-cluster and the instance is named lab-instance.

# Please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step. The instance takes a while to be fully created and initialized. Please wait until you see a Status of Ready to proceed to the next step.

# A VM named, alloydb-client, containing the PostgreSQL client was provisioned for you at the start of the lab. This installation includes the database restore tool pg_restore.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the following environment variable, replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance.

# export ALLOYDB=ALLOYDB_ADDRESS
# Copied!
# Run the following command to store the Private IP address of the AlloyDB instance on the AlloyDB client VM so that it will persist throughout the lab.

# echo $ALLOYDB  > alloydbip.txt 
# Copied!
# Use the following command to launch the PostgreSQL (psql) client. You will be prompted to provide the postgres user's password (Change3Me) which was specified when the cluster was created.

# psql -h $ALLOYDB -U postgres
# Copied!
# Run the follwoing command to confirm that the postgres database is currently empty.

# \dt
# Copied!
# Did not find any relations.
# Type \q to exit the psql client.

# Download the DMP file from the Cloud Storage bucket to the local directory.

# gsutil cp  gs://Project ID/pg14_source.DMP pg14_source.DMP
# Copied!
# Run the following command to create a TOC file that comments out all extension statements.

# pg_restore -l  pg14_source.DMP | sed -E 's/(.* EXTENSION )/; \1/g' >  pg14_source_toc.toc
# Copied!
# Now run the restore command to load the HR tables. You will be prompted for the postgres user's password - Change3Me.

# pg_restore -h $ALLOYDB -U postgres \
#   -d postgres \
#   -L pg14_source_toc.toc \
#   pg14_source.DMP
# Copied!
# Launch the PostgreSQL (psql) client again. You will be prompted for the postgres user's password - Change3Me.

# psql -h $ALLOYDB -U postgres
# Copied!
# Run the following command to confirm that the tables were loaded.

# \dt
# Copied!
#             List of relations
#  Schema |    Name     | Type  |  Owner   
# --------+-------------+-------+----------
#  public | countries   | table | postgres
#  public | departments | table | postgres
#  public | employees   | table | postgres
#  public | jobs        | table | postgres
#  public | locations   | table | postgres
#  public | regions     | table | postgres
# (6 rows)
# Run the following queries to determine the row counts for the migrated tables. The values will match the query outputs on the source instance.

# select count (*) as countries_row_count from countries;
# select count (*) as departments_row_count from departments;
# select count (*) as employees_row_count from employees;
# select count (*) as jobs_row_count from jobs;
# select count (*) as locations_row_count from locations;
# select count (*) as regions_row_count from regions;
# Copied!
# Click Check my progress to verify the objective.
# Verify import of database DMP file
# Congratulations!
# You have now successfully migrated a stand-alone PostgreSQL database (running on a virtual machine) to AlloyDB for PostgreSQL using native PostgreSQL tools.

# Finish your quest
# This self-paced lab is part of the Create and Manage AlloyDB Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

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