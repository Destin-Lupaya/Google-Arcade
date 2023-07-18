# Accelerating Analytical Queries using the AlloyDB Columnar Engine
# 1 hour 30 minutes
# 1 Credit
# GSP1087
# Google Cloud Self-Paced Labs logo

# Overview
# AlloyDB for PostgreSQL is a fully managed PostgreSQL-compatible database service for your most demanding enterprise database workloads. AlloyDB combines the best of Google with one of the most popular open-source database engines, PostgreSQL, for superior performance, scale, and availability.

# The Columnar Engine can significantly accelerate the speed at which AlloyDB processes SQL scans, joins, and aggregates. The Columnar Engine provides the following features: 1) a column store that contains table data for selected columns, reorganized into a column-oriented format and 2) a columnar query planner and execution engine to support use of the column store in queries.

# In this lab you will explore features of the AlloyDB Columnar Engine.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create Baseline Dataset for Testing the Columnar Engine

# Run a Baseline Test

# Verify the Database Flag for the Columnar Engine

# Set or Verify the Database Extension for the Columnar Engine

# Testing the Columnar Engine

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
# Task 1. Create Baseline Dataset for Testing the Columnar Engine
# An AlloyDB cluster and instance were provisioned when you started the lab. On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters to examine the cluster's details.

# The cluster is named lab-cluster and the instance is named lab-instance.

# The instance takes a while to be fully created and initialized. Please wait until you see a Status of Ready to proceed.

# Please make note of the Private IP address in the instances section. Copy the Private IP address to a text file so that you can paste the value in a later step.

# In order to evaluate the capabilities of the Columnar Engine you need a dataset of significant size against which to measure performance. You will utilize the Postgres tool pgbench to generate a synthetic dataset to evaluate the Columnar Engine.

# On the Navigation menu (Navigation menu icon), under Compute Engine click VM instances.

# For the instance named alloydb-client, in the Connect column, click SSH to open a terminal window.

# Set the following environment variable, replacing ALLOYDB_ADDRESS with the Private IP address of the AlloyDB instance.

# export ALLOYDB=ALLOYDB_ADDRESS
# Copied!
# Run the following command to store the Private IP address of the AlloyDB instance on the AlloyDB client VM so that it will persist throughout the lab.

# echo $ALLOYDB  > alloydbip.txt 
# Copied!
# The first step of using pgbench is to create and populate the sample tables. Run the following command to create a set of four tables. You will be prompted for the postgres user's password which is Change3Me.
# The largest table pgbench_accounts will be loaded with 50 million rows. The operation will take just a few minutes.

# pgbench -h $ALLOYDB -U postgres -i -s 500 -F 90 -n postgres
# Copied!
# dropping old tables...
# NOTICE:  table "pgbench_accounts" does not exist, skipping
# NOTICE:  table "pgbench_branches" does not exist, skipping
# NOTICE:  table "pgbench_history" does not exist, skipping
# NOTICE:  table "pgbench_tellers" does not exist, skipping
# creating tables...
# generating data (client-side)...
# 50000000 of 50000000 tuples (100%) done (elapsed 91.26 s, remaining 0.00 s)
# creating primary keys...
# done in 167.61 s (drop tables 0.00 s, create tables 0.01 s, client-side generate 93.16 s, primary keys 74.43 s).
# Connect to the psql client and run the following query to verify the row count in the pgbench_accounts table. You will be prompted for the postgres user's password which is Change3Me.

# psql -h $ALLOYDB -U postgres
# Copied!
# select count (*) from pgbench_accounts;
# Copied!
#   count   
# ----------
#  50000000
# (1 row)
# Click Check my progress to verify the objective.
# Create a baseline data set
# Task 2. Run a Baseline Test
# For evaluation purposes you can run a very simple query that performs seq scans and then use explain query plans for that query before and after adding the test table to the Columnar Engine.

# Return to the alloydb-client shell. The psql client should still be active. If not, reconnect using the instructions in Task 1. Run the following query to turn on timings for all query operations.

# \timing on
# Copied!
# Next run the following query to evaluate the run time. This query performs seq scans of the entire pgbench_accounts table. Note: This sample query has a limit of 20 returned rows because this is for demonstration purposes.

#  SELECT aid, bid, abalance FROM pgbench_accounts WHERE bid < 189  OR  abalance > 100 LIMIT 20;
# Copied!
#  aid | bid | abalance 
# -----+-----+----------
#    1 |   1 |        0
#    2 |   1 |        0
#    3 |   1 |        0
#    4 |   1 |        0
#    5 |   1 |        0
#    6 |   1 |        0
#    7 |   1 |        0
#    8 |   1 |        0
#    9 |   1 |        0
#   10 |   1 |        0
#   11 |   1 |        0
#   12 |   1 |        0
#   13 |   1 |        0
#   14 |   1 |        0
#   15 |   1 |        0
#   16 |   1 |        0
#   17 |   1 |        0
#   18 |   1 |        0
#   19 |   1 |        0
#   20 |   1 |        0
# (20 rows)
# Run the following query to generate an explain plan for an unrestricted query. Your values should appear similar to those in the sample output but will vary because of the random nature of data generation.
# Note: You may have to press the spacebar to advance through the query explain plan.
# EXPLAIN (ANALYZE,COSTS,SETTINGS,BUFFERS,TIMING,SUMMARY,WAL,VERBOSE)
#  SELECT count(*) FROM pgbench_accounts WHERE bid < 189  OR  abalance > 100;
# Copied!
# QUERY PLAN                         
                                                   
# ---------------------------------------------------------------------------------------------------------------
# ---------------------------------------------------
#  Finalize Aggregate  (cost=1242226.53..1242226.54 rows=1 width=8) (actual time=11010.409..11014.083 rows=1 loop
# s=1)
#    Output: count(*)
#    Buffers: shared hit=20921 read=888170
#    I/O Timings: read=19536.769
#    ->  Gather  (cost=1242226.32..1242226.53 rows=2 width=8) (actual time=11010.398..11014.075 rows=3 loops=1)
#          Output: (PARTIAL count(*))
#          Workers Planned: 2
#          Workers Launched: 2
#          Buffers: shared hit=20921 read=888170
#          I/O Timings: read=19536.769
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# !! Section removed for pasting !!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                      Filter: ((pgbench_accounts.bid < 189) OR (pgbench_accounts.abalance > 100))
#                      Rows Removed by Filter: 10400000
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# !! Section removed for pasting !!
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#    Buffers: shared hit=6
#  Planning Time: 0.117 ms
#  Execution Time: 11014.169 ms
# (38 rows)
# In the results pay particular attention to the Planning Time and Execution Time values. In the sample output, the Planning Time is 0.117 milliseconds and the Execution Time is 11014.169 milliseconds or 11.014 seconds. Your values should appear similar to those in the sample output but will vary because of the random nature of data generation.

# Copy the values for Planning Time and Execution Time from your run to text file so that you may compare them later with the results after the Columnar Engine is enabled. You may also copy the entire query plan results to a text file.

# Press the Q key to close the query plan.

# Task 3. Verify the Database Flag for the Columnar Engine
# Next you will examine the Columnar Engine database flag in your instance.

# On the Cloud Console Navigation menu (console_nav_small.png), under Databases click AlloyDB for PostgreSQL then Clusters to examine the cluster's details.

# In the Instances in your cluster section, select the lab-instance, and then click Edit Primary.

# To add a database flag to your instance, click Add flag.

# Browse the list of available flags to get a sense of the supported options. Observe the flag google_columnar_engine.enabled in the list. You will not add an additional flag as part of this lab.

# Click Cancel twice to exit the Edit Primary instance screen.

# Task 4. Set or Verify a Database Extension for the Columnar Engine
# Continuing from the previous section you will setup a database extension to fully enable the Columnar Engine feature for your AlloyDB cluster.

# Unlike configuring a flag, you must connect to your instance via the psql client to enable a database extension.

# Return to the alloydb-client shell. The psql client should still be active. If not, reconnect using the instructions in Task 1.

# Ensure that you are connected to the postgres database by running the following query.

# \c postgres
# Copied!
# Run the following system query to see details on the extensions enabled in the database.
# Note: Your list of extensions may vary.
# \dx
# Copied!
#                              List of installed extensions
#           Name          | Version |   Schema   |              Description              
# ------------------------+---------+------------+---------------------------------------
#  google_columnar_engine | 1.0     | public     | Google extension for columnar engine
#  google_db_advisor      | 1.0     | public     | Google extension for Database Advisor
#  hypopg                 | 1.3.2   | public     | Hypothetical indexes for PostgreSQL
#  plpgsql                | 1.0     | pg_catalog | PL/pgSQL procedural language
# (4 rows)
# If google_columnar_engine appears in the list, skip to the next task (Task 5). If google_columnar_engine does not appear in the list run the following command.

# CREATE EXTENSION IF NOT EXISTS google_columnar_engine;
# Copied!
# Run the extension query again to confirm that the google_columnar_engine extension is enabled.

# \dx
# Copied!
# Task 5. Testing the Columnar Engine
# Because your main table ( pgbench_accounts) is relatively small, you can add it directly to the Columnar Engine for evaluation. In a real-life deployment you would utilize the Columnar Engine's recommendation framework to automatically identify the most heavily used columns across all tables that would provide the most benefit from being managed by the engine.

# Return to the alloydb-client shell. Run the following query to add pgbench_accounts to the columnar engine. The query should take a few minutes to complete.

# SELECT google_columnar_engine_add('pgbench_accounts');
# Copied!
# Next run the same explain plan query you did earlier to see the affects of the Columnar Engine. Your values should appear similar to those in the sample output but will vary because of the random nature of data generation.

# EXPLAIN (ANALYZE,COSTS,SETTINGS,BUFFERS,TIMING,SUMMARY,WAL,VERBOSE)
#  SELECT count(*) FROM pgbench_accounts WHERE bid < 189  OR  abalance > 100;
# Copied!
#  QUERY PLAN                                                                                       
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
#  Finalize Aggregate  (cost=142400.72..142400.73 rows=1 width=8) (actual time=75.948..78.680 rows=1 loops=1)
#    Output: count(*)
#    ->  Gather  (cost=142400.51..142400.72 rows=2 width=8) (actual time=71.555..78.667 rows=3 loops=1)
#          Output: (PARTIAL count(*))
#          Workers Planned: 2
#          Workers Launched: 2
#          ->  Partial Aggregate  (cost=141400.51..141400.52 rows=1 width=8) (actual time=45.768..45.771 rows=1 loops=3)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Section removed for pasting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#                            Rows Removed by Columnar Filter: 10400000
#                            Rows Aggregated by Columnar Scan: 4505600
#                            Columnar cache search mode: native
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Section removed for pasting
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#    Buffers: shared hit=22 read=3 dirtied=1
#    I/O Timings: read=0.560
#  Planning Time: 2.022 ms
#  Execution Time: 78.804 ms
# (29 rows) 
# In the results pay particular attention to the Planning Time and Execution Time values. In the Post-Columnar Engine sample, the Planning Time is 2.022 milliseconds and the Execution Time is 78.804 milliseconds. Your values should appear similar to those in the sample output but will vary because of the random nature of data generation.

# From the samples provided, the difference between the Execution Time Pre-Columnar Engine and Post-Columnar Engine is 10935.365 ms or 10.9 seconds. That is a decrease of 141 times. In the Post-Columnar Engine sample, also note that over 4.5 million rows were aggregated using a columnar scan rather than the core database engine.

# Click Check my progress to verify the objective.

# Testing the Columnar Engine
# Congratulations!
# You have now explored powerful features of the AlloyDB Columnar Engine.

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
