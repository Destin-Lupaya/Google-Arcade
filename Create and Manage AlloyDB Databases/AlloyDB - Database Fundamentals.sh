# AlloyDB - Database Fundamentals
# 1 hour 30 minutes
# 1 Credit
# GSP1083
# Google Cloud Self-Paced Labs logo

# Overview
# AlloyDB for PostgreSQL is a fully managed PostgreSQL-compatible database service for your most demanding enterprise database workloads. AlloyDB combines the best of Google with one of the most popular open-source database engines, PostgreSQL, for superior performance, scale, and availability.

# In this lab you perform several key tasks when using an AlloyDB for PostgreSQL database.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create a cluster and instance.

# Create tables and insert data in your database

# Use the Google Cloud CLI with AlloyDB.

# Delete an instance.

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
# Task 1. Create a cluster and instance
# First create an AlloyDB cluster. On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters.

# Then click Create cluster at the top of the page.

# Choose Highly Available from the list of options for the cluster type to start with step of the wizard.

# Click Continue under the list of cluster options.

# In the Configure your cluster section, fill in the following fields. Leave the others at their default value.

# Item	Value
# Cluster ID	lab-cluster
# Password	Change3Me
# Network	peering-network



# The private services access connection option was configured for this project when you started the lab. This step is required to allow access to the AlloyDB cluster.

# Click Continue to proceed.

# Under Configure your primary instance, set the instance ID as lab-instance.

# Select 2 vCPU, 16 GB as your machine type.

# Scroll to the bottom of the page and click Create Cluster.

# Note: Cluster creation will take approximately __9__ to __13__ minutes.
# You're now on the Overview page for the new cluster you created. The bottom section contains details on your instance. Please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step.

# Click Check my progress to verify the objective.

# Create a cluster and instance
# Task 2. Create tables and insert data in your database
# A VM named, alloydb-client, containing the PostgreSQL client was provisioned for you at the start of the lab.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the following environment variable, replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance.

# export ALLOYDB=ALLOYDB_ADDRESS
# Copied!
# Run the following command to store the Private IP address of the AlloyDB instance on the AlloyDB client VM so that it will persist throughout the lab.

# echo $ALLOYDB  > alloydbip.txt 
# Copied!
# Use the following command to launch the PostgreSQL (psql) client. You will be prompted to provide the postgres user's password (Change3Me) which you entered when you created the cluster.

# psql -h $ALLOYDB -U postgres
# Copied!
# You will be presented with the psql terminal prompt as shown below.
# psql (14.5 (Debian 14.5-1.pgdg110+1), server 14.4)
# SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
# Type "help" for help.
# postgres=> 
# Input and run the following SQL command to create a new table named regions.

# CREATE TABLE regions (
#     region_id bigint NOT NULL,
#     region_name varchar(25)
# ) ;
# ALTER TABLE regions ADD PRIMARY KEY (region_id);
# Copied!
# Next add several rows of data to the regions table. Input and run the following SQL command.

# INSERT INTO regions VALUES ( 1, 'Europe' );
# INSERT INTO regions VALUES ( 2, 'Americas' );
# INSERT INTO regions VALUES ( 3, 'Asia' );
# INSERT INTO regions VALUES ( 4, 'Middle East and Africa' );
# Copied!
# Run the following simple query to verify that you inserted the records.

# SELECT region_id, region_name from regions;
# Copied!
# Type \q to exit the psql client.

# Another option to create tables and/or load data is by using a SQL file (.sql). A SQL file can contain DDL, DML or any supported SQL syntax. You will download and run a file containing DDL and DML, run that file, and then verify the load.

# Run the following command to download a file containing DDL and DML for three tables: countries, departments, and jobs.

# gsutil cp gs://cloud-training/OCBL403/hrm_load.sql hrm_load.sql
# Copied!
# Reconnect to the PostgreSQL (psql) client. You will be prompted to provide the postgres user's password (Change3Me).

# psql -h $ALLOYDB -U postgres
# Copied!
# Run the following command to process the sql file.

# \i hrm_load.sql
# Copied!
# Run the following command to see the tables that are loaded into your database.

# \dt
# Copied!
#             List of relations
#  Schema |    Name     | Type  |  Owner   
# --------+-------------+-------+----------
#  public | countries   | table | postgres
#  public | departments | table | postgres
#  public | jobs        | table | postgres
#  public | regions     | table | postgres
# (4 rows)
# Run a spot check query to examine the data in one of the tables you just created and loaded.

# select job_title, max_salary 
# from jobs 
# order by max_salary desc;
# Copied!
# Type \q to exit the psql client.

# Type exit to close the terminal window.

# Click Check my progress to verify the objective.

# Create and load a table
# Task 3. Use the Google Cloud CLI with AlloyDB
# The Cloud Console is very useful, but in some use cases you want to manage AlloyDB databases using other methods. Google Cloud services can also be managed through the command line tool named gcloud. The easiest way to use the gcloud CLI is via the Cloud Shell but it can also be installed on a wide variety of operating systems.

# Create a cluster and instance with CLI
# Creating an AlloyDB cluster instance via gcloud is very simple.

# In the Cloud Shell, create a new AlloyDB cluster using the command below.

# gcloud beta alloydb clusters create gcloud-lab-cluster \
#     --password=Change3Me \
#     --network=peering-network \
#     --region=Default Region \
#     --project=Project ID
# Copied!
# Once the cluster is created, run the following command to create the Primary instance.
# Note: The instance creation process will take 7 to 9 minutes.
# gcloud beta alloydb instances create gcloud-lab-instance\
#     --instance-type=PRIMARY \
#     --cpu-count=2 \
#     --region=Default Region  \
#     --cluster=gcloud-lab-cluster \
#     --project=Project ID
# Copied!
# After the process completes, you can run the following command to list the AlloyDB clusters instances available in your project. The earlier instance you created, lab-cluster, and the one you just created, gcloud-lab-cluster, are returned in the listing.

# gcloud beta alloydb clusters list
# Copied!
# Click Check my progress to verify the objective.
# Create a cluster and instance with CLI
# Task 4. Deleting a cluster
# A very quick way to delete a cluster is by using the CLI. Run the following command. The force option deletes any subordinate instances as well. Another option to delete a cluster is to use the Cloud Console.
# Note: The deletion process will take 5 to 8 minutes.
# gcloud beta alloydb clusters delete gcloud-lab-cluster \
#     --force \
#     --region=Default Region \
#     --project=Project ID
# Copied!
# To confirm that gcloud-lab-cluster was deleted run the following command:
# If prompted Do you want to continue (Y/n)? press Y to continue.

# gcloud beta alloydb clusters list
# Copied!
# Congratulations!
# You now have a solid understanding of several key tasks when using an AlloyDB for PostgreSQL database.

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

# Lab
# A Tour of Google Cloud Sustainability