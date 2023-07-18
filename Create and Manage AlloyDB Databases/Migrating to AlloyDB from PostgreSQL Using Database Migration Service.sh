# Migrating to AlloyDB from PostgreSQL Using Database Migration Service
# 1 hour 30 minutes
# 5 Credits
# GSP1084
# Google Cloud Self-Paced Labs logo

# Overview
# In this lab, you migrate a stand-alone PostgreSQL database (running on a virtual machine) to AlloyDB for PostgreSQL using a continuous Database Migration Service job with VPC peering for connectivity. AlloyDB requires the use of Private services access. This access is implemented as a VPC peering connection between your VPC network and the underlying Google Cloud VPC network where your AlloyDB resources reside.

# Migrating a database via Database Migration Service requires some preparation of the source database. Those tasks have been completed for you on the source environment with the most important being setting up the pglogical package on the source instance.

# After you create and run the migration job, you confirm that an initial copy of your database has been successfully migrated to your AlloyDB for PostgreSQL instance. You also explore how continuous migration jobs apply data updates from your source database to your AlloyDB for PostgreSQL instance.

# Objectives
# In this lab, you learn how to configure a continuous Database Migration Service job to migrate databases from a PostgreSQL instance to AlloyDB for PostgreSQL.

# Verify Data in the Source Instance for migration

# Create a profile for a source connection to a PostgreSQL instance (e.g., stand-alone PostgreSQL)

# Create and start a continuous migration job

# Confirm data load in the AlloyDB for PostgreSQL Instance

# Propagate a live update to the AlloyDB Instance

# Setup
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
# Task 1. Verify Data in the Source Instance for migration
# Verify Data in Source Instance
# In this step connect to and verify data in the postgres database on the pg14-source VM Instance.

# On the Navigation menu (console_nav_small.png), under Compute Engine click VM instances.

# For the instance named pg14-source, in the Connect column, click SSH to open a terminal window.

# Use the following command to launch the PostgreSQL (psql) client.

# sudo -u postgres psql
# Copied!
# You will be presented with the psql terminal prompt similar to as shown below.
# psql (14.5 (Debian 14.5-1.pgdg110+1))
# Type "help" for help.
# Input and run the following SQL command to see the HR related tables in the postgres database.

# \dt
# Copied!
# Run the following queries to determine the row counts for each table.

# select count (*) as countries_row_count from countries;
# select count (*) as departments_row_count from departments;
# select count (*) as employees_row_count from employees;
# select count (*) as jobs_row_count from jobs;
# select count (*) as locations_row_count from locations;
# select count (*) as regions_row_count from regions;
# Copied!
# The source table row counts are as follows.
# Name	Rows
# countries	25
# departments	27
# employees	107
# jobs	19
# locations	23
# regions	4



# Type \q to exit the psql client.

# Type exit to close the terminal window.

# Task 2. Create a Database Migration Service connection profile for a stand-alone PostgreSQL database
# In this task, you will create a connection profile for the PostgreSQL source instance.

# Get the connectivity and deployment information for the PostgreSQL source instance
# In this step, you identify the internal IP address of the source database instance that you will migrate to AlloyDB.

# On the Navigation menu (console_nav_small.png), under Compute Engine click VM instances.

# Locate the line for the instance pg14-source.

# Copy the value for the Internal IP (e.g., 10.128.15.208).

# Create a new connection profile for the PostgreSQL source instance
# A connection profile stores information about the source database instance (e.g., stand-alone PostgreSQL) and is used by the Database Migration Service to migrate data from the source to your destination AlloyDB for PostgreSQL instance. After you create a connection profile, it can be reused across migration jobs.

# In this step you will create a new connection profile for the PostgreSQL source instance.

# In the Google Cloud Console, on the Navigation menu (console_nav_small.png), click Database Migration > Connection profiles.

# Click + Create Profile.

# For Source database engine, select PostgreSQL.

# For Connection profile name, enter pg14-source.

# For Hostname or IP address, enter the internal IP for the PostgreSQL source instance that you copied in the previous task (e.g., 10.128.15.208)

# For Port, enter 5432.

# For Username, enter postgres.

# For Password, enter Change3Me .

# For Region select (region).

# For all other values leave the defaults.

# Click Create.

# A new connection profile named pg14-source will appear in the Connections profile list.

# Click Check my progress to verify the objective.
# Create a connection profile for the PostgreSQL source instance

# Task 3. Create and start a continuous migration job
# When you create a new migration job, you first define the source database instance using a previously created connection profile. Then you create a new destination database instance and configure connectivity between the source and destination instances.

# In this task, you use the migration job interface to create a new AlloyDB for PostgreSQL cluster and set it as the destination for the continuous migration job from the PostgreSQL source instance.

# Create a new continuous migration job
# In this step you will create a new continuous migration job.

# In the Google Cloud Console, on the Navigation menu (console_nav_small.png), click Database Migration > Migration jobs.

# Click + Create Migration Job.

# For Migration job name, enter postgres-to-alloydb.

# For Source database engine, select PostgreSQL.

# For Destination database engine, select AlloyDB for PostgreSQL.

# For Destination region, select (region).

# At the moment, Continuous is the only option available Migration job type for PostgreSQL to AlloyDB.

# Leave the defaults for the other settings.

# Click Save & Continue.

# Define the source instance
# In this step, you will define the source instance for the migration.

# For Source connection profile, select the pg14-source connection profile you created a few steps ago.

# Click Save & Continue.

# Create the destination instance
# In this step, the DMS wizard will create the AlloyDB cluster and instance on your behalf.

# For Cluster Type, the only option available is Highly available. Click Continue.

# For Cluster ID, enter alloydb-target-cluster.

# For Password, enter Change3Me.

# For Network, select peering-network.

# Click Continue.

# For Instance ID, enter alloydb-target-instance.

# Select 2 vCPU, 16 GB as your machine type.

# Click Save & Continue.

# On the pop-up window, Click Create Destination & Continue to continue.

# While your AlloyDB instance and cluster are being created, you can choose VPC peering from the Connectivity method list of options.

# Please wait until the cluster and instance are complete. The Configure & Continue link will be available once the database is available.

# Click Configure & Continue.

# Test and start the continuous migration job
# In this step, you will test and start the migration job.

# The Database Migration Service wizard will now be on the test and create migration job step.

# Click Test Job.

# After a successful test, click Create & Start Job.

# Note: You must click Create & Start Job or your job will not begin. The other link will only create and save the job details.
# If prompted to confirm, click Create & Start.

# Review the status of the continuous migration job
# In this step, you will confirm that the continuous migration job is running.

# In the Google Cloud Console, on the Navigation menu (console_nav_small.png), click Database Migration > Migration jobs.

# Click the migration job postgres-to-alloydb to see the details page.

# Review the migration job status.

# If you have not started the job, the status will show as Not started. You can choose to start or delete the job.
# After the job has started, the status will show as Starting and then transition to Running Full dump in progress to indicate that the initial database dump is in progress.
# The job status will move to Running CDC in progress once the initial load is complete and DMS is available for continuous operations.
# When the job status changes to Running CDC in progress, proceed to the next task.

# Task 4. Confirm data load in the AlloyDB for PostgreSQL Instance
# Check the AlloyDB for PostgreSQL Instance
# On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters to examine the cluster's details.

# The cluster is named alloydb-target-cluster and the instance is named alloydb-target-instance.

# Please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the following environment variable, replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance.

# export ALLOYDB=ALLOYDB_ADDRESS
# Copied!
# Run the following command to store the Private IP address of the AlloyDB instance on the AlloyDB client VM so that it will persist throughout the lab.

# echo $ALLOYDB  > alloydbip.txt 
# Copied!
# Connect to the psql client and run the following query to verify that the five source tables are now in the AlloyDB instance. You will be prompted to provide the postgres user's password (Change3Me) which was specified when the cluster was created.

# psql -h $ALLOYDB -U postgres
# Copied!
# \dt
# Copied!
#                  List of relations
#  Schema |    Name     | Type  |        Owner        
# --------+-------------+-------+---------------------
#  public | countries   | table | alloydbexternalsync
#  public | departments | table | alloydbexternalsync
#  public | employees   | table | alloydbexternalsync
#  public | jobs        | table | alloydbexternalsync
#  public | locations   | table | alloydbexternalsync
#  public | regions     | table | alloydbexternalsync
# (6 rows)
# Run the following queries to determine the row counts for the migrated tables. The values will match the query outputs on the source instance.

# select count (*) as countries_row_count from countries;
# select count (*) as departments_row_count from departments;
# select count (*) as employees_row_count from employees;
# select count (*) as jobs_row_count from jobs;
# select count (*) as locations_row_count from locations;
# select count (*) as regions_row_count from regions;
# Copied!
# The target table row counts are as follows.
# Name	Rows
# countries	25
# departments	27
# employees	107
# jobs	19
# locations	23
# regions	4



# Run the following query to verify the data in the regions table.

# select region_id, region_name from regions;
# Copied!
#  region_id |      region_name       
# -----------+------------------------
#          1 | Europe
#          2 | Americas
#          3 | Asia
#          4 | Middle East and Africa
# (4 rows)
# .
# Task 5. Propagate a live update to the AlloyDB Instance
# Because the Database Migration Service job is set in a continuous update configuration, any updates you make on the source instance will be applied to the AlloyDB target.

# On the Navigation menu (console_nav_small.png), under Compute Engine click VM instances.

# For the instance named pg14-source, in the Connect column, click SSH to open a terminal window.

# Use the following command to launch the PostgreSQL (psql) client.

# sudo -u postgres psql
# Copied!
# You will be presented the psql terminal prompt. Input and run the following SQL command to add one row of data to the regions table.

# insert into regions values (5, 'Oceania');
# Copied!
# Confirm that the row was inserted locally.

# select region_id, region_name from regions;
# Copied!
#  region_id |      region_name       
# -----------+------------------------
#          1 | Europe
#          2 | Americas
#          3 | Asia
#          4 | Middle East and Africa
#          5 | Oceania
# (5 rows)
# Review data in the AlloyDB for PostgreSQL instance
# Return to the terminal shell for the alloydb-client. The psql client will still be open. Run the following query to verify that the Oceania row was added to the targeted AlloyDB instance.

# select region_id, region_name from regions;
# Copied!
#  region_id |      region_name       
# -----------+------------------------
#          1 | Europe
#          2 | Americas
#          3 | Asia
#          4 | Middle East and Africa
#          5 | Oceania
# (5 rows)
# Click Check my progress to verify the objective.
# Test the continuous migration of data

# Congratulations!
# You have now successfully migrated a stand-alone PostgreSQL database (running on a virtual machine) to AlloyDB for PostgreSQL using a continuous Database Migration Service job.

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