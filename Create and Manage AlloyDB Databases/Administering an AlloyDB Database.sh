# Administering an AlloyDB Database
# 1 hour 30 minutes
# 1 Credit
# GSP1086
# Google Cloud Self-Paced Labs logo

# Overview
# AlloyDB for PostgreSQL is a fully managed PostgreSQL-compatible database service for your most demanding enterprise database workloads. AlloyDB combines the best of Google with one of the most popular open-source database engines, PostgreSQL, for superior performance, scale, and availability.

# In this lab you perform administrative tasks that are essential to the optimal use of an AlloyDB for PostgreSQL database.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Examine a Database Flag

# Setup a Database Extension

# Create a Read Pool Instance for an Existing Cluster

# Setup Backups

# Examine Monitoring in the AlloyDB Console

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
# Task 1. Examine a Database Flag
# An AlloyDB cluster and instance were provisioned when you started the lab. On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters to examine the cluster's details.

# The cluster is named lab-cluster and the instance is named lab-instance.

# The instance takes a while to be fully created and initialized. Please wait until you see a Status of Ready to proceed.

# Please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step.

# The instance was also configured with the enable_pgaudit database flag already set. Pgaudit is a popular feature of PostgreSQL that provides detailed session and object audit logging via the standard logging facility. To fully enable pgaudit you must also enable the corresponding database extension which you will do in the next section.

# In the Instances in your cluster section, select the lab-instance, and then click Edit Primary.

# To add a database flag to your instance, click Add flag.

# Browse the list of avaiable flags (inside Choose a flag) to get a sense of the supported options. You will not add an additional flag as part of this lab.

# Click Cancel twice to exit the Edit Primary instance screen.

# Task 2. Setup a Database Extension
# Continuing from the previous you will setup a database extension to fully enable the pgaudit feature for your AlloyDB cluster.

# Unlike configuring a flag, you must connect to your instance via the psql client to enable a database extension.

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
# You will be presented the psql terminal prompt as shown below.
# psql (14.5 (Debian 14.5-1.pgdg110+1), server 14.4)
# SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, bits: 256, compression: off)
# Type "help" for help.
# postgres=> 
# Input and run the following SQL commands separately to enable the extension.

# \c postgres
# Copied!
# CREATE EXTENSION IF NOT EXISTS PGAUDIT;
# Copied!
# Run the following system query to see details on the pgaudit extension.

# select extname, extversion from pg_extension where extname = 'pgaudit';
# Copied!
#  extname | extversion 
# ---------+------------
#  pgaudit | 1.6.1
# (1 row)
# Type \q to exit the psql client.

# Type exit to close the terminal window.

# Click Check my progress to verify the objective.

# Enable the pgaudit extension
# Task 3. Create a Read Pool Instance for an Existing Cluster
# One key feature of AlloyDB for PostgreSQL is the implementation of read pool instances. A read pool instance increases your cluster’s read capacity by aggregating nodes, which you can scale, enabling highly available reads.
# You are not required to have any read pool instances in a cluster, but they provide better support for data analytics workloads than do primary instances. Therefore they are the best choice for your data analytics needs.

# To add a read pool instance click Add Read Pool or Add Read Pool Instance in the Instances in your cluster section of the Overview page for your cluster.

# For Read pool instance ID input lab-instance-rp1. Set the Node count to 2.

# Select 2 vCPU, 16 GB as your machine type.

# Click Create Read Pool.

# Read pool instance creation will take approximately 8 to 11 minutes.

# Your read pool instance now appears on the Overview page. Notice the Private IP is in the same pool of addresses as the Primary Instance. The direct IP address allows you to funnel read-specific queries to the read pool, thereby enhancing overall cluster performance.

# Click Check my progress to verify the objective.

# Create a read pool instance
# Task 4. Setup Backups
# Automatic backups are configured by default when every AlloyDB cluster is created. You can however create backups as needed, on-demand for additional recovery options based on workload requirements.

# On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Backups to launch the Backups page.

# Your instance was too recently created to have any automatic backups so you will proceed with creating an on-demand backup. Click Create backup.

# Select lab-cluster as the source for the backup.

# Enter a unique ID for the backup. In this case enter lab-backup.

# Click Create.

# AlloyDB checks that the source cluster is in the Ready state and then starts a long-running operation to perform the backup. The Backups page shows the backup with a status of In progress until the operation finshes. The speed varies based on the size of the instance but in the lab environment the backup should be created quickly -- within 1 minute.

# In the Cloud Shell, run the command below to see more details on your backup.
# gcloud beta alloydb backups list
# Copied!
# Recovery of a backup is very simple. Click the Restore link at the end of the backup row. Inspect the information for the backup and the proposed target for recovery. For this lab you will not restore the backup you just created. Click Cancel to close the wizard.

# Click Check my progress to verify the objective.

# Create a backup
# Task 5. Examine Monitoring in the AlloyDB Console
# The AlloyDB Monitoring dashboard contains a great deal of information about the usage, size, and performance of the clusters and instances. The dashboard displays metrics of the resources that you use and lets you monitor any trends that result.

# From the Cluster Overview select the Monitoring link on the left side of the page.

# Very little activity has occurred on the lab-instance so the metrics displayed at the moment will not offer much insight. You will utilize the Postgres tool pgbench to generate a synthetic dataset and run a simulated workload to place the lab-instance under a representative burden.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the ALLOYDB environment variable by running the following command.

# export ALLOYDB=$(cat alloydbip.txt)
# Copied!
# The first step of using pgbench is to create and populate the sample tables. Run the following command to create a set of four tables. You will be prompted for the postgres user's password which is Change3Me.
# The largest table pgbench_accounts will be loaded with 5 million rows. The operation should be very brief.

# pgbench -h $ALLOYDB -U postgres -i -s 50 -F 90 -n postgres
# Copied!
# pgbench create
# dropping old tables...
# NOTICE:  table "pgbench_accounts" does not exist, skipping
# NOTICE:  table "pgbench_branches" does not exist, skipping
# NOTICE:  table "pgbench_history" does not exist, skipping
# NOTICE:  table "pgbench_tellers" does not exist, skipping
# creating tables...
# generating data (client-side)...
# 5000000 of 5000000 tuples (100%) done (elapsed 9.49 s, remaining 0.00 s)
# creating primary keys...
# done in 13.71 s (drop tables 0.00 s, create tables 0.01 s, client-side generate 9.98 s, primary keys 3.72 s).
# Connect to the psql client and run the following query to verify the row count in the pgbench_accounts table. You will be prompted for the postgres user's password which is Change3Me.

# psql -h $ALLOYDB -U postgres
# Copied!
# select count (*) from pgbench_accounts;
# Copied!
#   count  
# ---------
#  5000000
# (1 row)
# Type \q to exit the psql client.

# Run the following pgbench operation to simulate a workload against lab-instance. The operation corresponds to a load of fifty (50) clients, across two (2) threads, polling every thirty (30) seconds, over the course of three (3) minutes. You will be prompted for the postgres user's password which is Change3Me.

# pgbench -h $ALLOYDB -U postgres -c 50 -j 2 -P 30 -T 180 postgres
# Copied!
# The workload operation will complete and report statistics for the run. The details will appear similar to the following:
# pgbench (14.5 (Debian 14.5-1.pgdg110+1), server 14.4)
# starting vacuum...end.
# progress: 30.0 s, 1412.2 tps, lat 34.433 ms stddev 25.836
# progress: 60.0 s, 1426.6 tps, lat 35.040 ms stddev 25.459
# progress: 90.0 s, 1393.2 tps, lat 35.863 ms stddev 33.101
# progress: 120.0 s, 1429.8 tps, lat 34.968 ms stddev 31.735
# progress: 150.0 s, 1335.4 tps, lat 37.406 ms stddev 30.922
# progress: 180.0 s, 1424.8 tps, lat 35.118 ms stddev 28.440
# transaction type: 
# scaling factor: 50
# query mode: simple
# number of clients: 50
# number of threads: 2
# duration: 180 s
# number of transactions actually processed: 252710
# latency average = 35.458 ms
# latency stddev = 29.391 ms
# initial connection time = 801.012 ms
# tps = 1409.393040 (without initial connection time)
# Return to the AlloyDB Monitoring dashboard and set the time horizon to 1 hour. In the tiles below you will see details on Mean CPU utilization, Minimum available memory, Connections, Transactions per second, Cluster storage, Maximum replication lag, and Active nodes.

# Click the Query insights link on the left for details on the queries that the pgbench operation issued against the instance.

# Under Top Queries and Tags, you will see an ordering of queries. In the image below the query UPDATE pgbench_branches SET ... was the top query by Load by total time. Your results may vary.

# TopQuery.png

# The Load by total time column has a selector option. You may also view the queries by Load by CPU, Load by IO wait, and Load by lock wait.

# Feel free to explore queries in detail by clicking on any of the values in the Query column in the Top Queries and Tags section or links in other areas of the dashboard.

# Congratulations!
# You have now performed administrative tasks that are essential to the optimal use of an AlloyDB for PostgreSQL database.

# Finish your quest
# This self-paced lab is part of the Create and Manage AlloyDB Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Copyright 2022 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
