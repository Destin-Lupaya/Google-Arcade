# Manage PostgreSQL Databases on Cloud SQL: Challenge Lab
# 1 hour 30 minutes
# 1 Credit
# GSP355
# Google Cloud self-paced labs logo

# Overview
# In this challenge lab, lab you will be set a number of tasks to perform. These have all been covered in the quest Manage Cloud SQL for PostgreSQL Databases. You will not be given step-by-step instructions, but you will be given certain directives which you must follow, such as the naming of certain resources, or some guidelines about how you should solve the problems.

# Scenario
# Your employer has a stand-alone PostgreSQL database on a Compute Instance VM. You have been tasked with migrating the database to a Cloud SQL for PostgreSQL instance using Database Migration Services and VPC Peering. You are then required to configure and test Cloud SQL IAM Database Authentication on the migrated instance, and finally enable backups and point-in-time recovery so that the database is protected. You are required to confirm that point-in-time recovery works by using it to create a clone of the database to a particular timestamp.

# Objectives
# In this challenge lab, you are required to perform the following tasks:

# Migrate a stand-alone PostgreSQL database to Cloud SQL for PostgreSQL using Database Migration Services.

# Promote the Cloud SQL database to a stand-alone instance for reading and writing.

# Secure the database using IAM DB Authentication.

# Perform a point-in-time recovery on the database.

# Target audience
# The content of this challenge lab will be most applicable to PostgreSQL DBAs. This lab is designed to test the abilities of students who have completed the Manage Cloud SQL for PostgreSQL Databases quest.

# Setup and requirements
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
# Task 1. Migrate a stand-alone PostgreSQL database to a Cloud SQL for PostgreSQL instance
# In this task you must migrate the stand-alone PostgreSQL orders database running on the postgres-vm virtual machine to a Cloud SQL for PostgreSQL instance using a Database Migration Services continuous migration job and VPC Peering connectivity.

# Prepare the stand-alone PostgreSQL database for migration
# In this sub-task you must prepare the stand-alone PostgreSQL database so that it satisfies the requirements for migration by Database Migration Services.

# To complete this sub-task you must complete the following steps:

# Enable the Google Cloud APIs required for Database Migration Services.
# Database Migration Services require the Database Migration API and the Service Networking API to be enabled in order to function. You must enable these APIs for your project.

# Upgrade the target databases on the postgres-vm virtual machine with the pglogical database extension.

# You must install and configure the pglogical database extension on the stand-alone PostgreSQL database on the postgres-vm Compute Instance VM. The pglogical database extension package that you must install is named postgresql-13-pglogical.

# To complete the configuration of the pglogical database extension you must edit the PostgreSQL configuration file /etc/postgresql/13/main/postgresql.conf to enable the pglogical database extension and you must edit the /etc/postgresql/13/main/pg_hba.conf to allow access from all hosts.

# Create a dedicated user for database migration on the stand-alone database.

# The new user that you create on the stand-alone PostgreSQL installation on the postgres-vm virtual machine must be configured using the following user name and password:

# Migration user name : Postgres Migration User

# Migration user password : DMS_1s_cool!

# Grant that user the required privileges and permissions for databases to be migrated.
# Database Migration Services require that the migration user has privileges to specific schemata and relations of the target databases for migration, in this case that is the orders database.

# The Database Migration Service requires all tables to be migrated to have a primary key.

# You must make sure that all of the tables in the orders database have a primary key set before you start the migration.
# distribution_centers
# inventory_items
# order_items
# products
# users
# Note: The detailed pre-requisites for migrating a stand-alone PostgreSQL database to Cloud SQL for PostgreSQL are provided in the suggestion links in the Cloud Console GUI for Database Migration Services.
# Should you need some help on the detailed steps you must take, you may refer to that documentation, or you can look at the detailed steps in the migration lab that is part of this quest.
# The completed Migration job type field; Continuous.

# Prepare a stand-alone PostgreSQL database for migration to Cloud SQL for PostgreSQL.
# Migrate the stand-alone PostgreSQL database to a Cloud SQL for PostgreSQL instance
# In this sub-task you must perform the migration using Database Migration Services.

# To complete this sub-task you must complete the following steps:

# Create a new Database Migration Service connection profile for the stand-alone PostgreSQL database, using the credentials of the Postgres Migration User migration user you created earlier.

# Username : Postgres Migration User

# Password : DMS_1s_cool!

# You must configure the connection profile using the internal ip-address of the source compute instance.

# Create a new continuous Database Migration Service job.

# As part of the migration job configuration, make sure that you specify the following properties for the destination Cloud SQL instance:

# The Destination Instance ID must be set to Migrated Cloud SQL for PostgreSQL Instance ID
# The Password for the migrated instance must be set to supersecret!
# Database version must be set to Cloud SQL for PostgreSQL 13
# Region must be set to us-central1
# For Connections both Public IP and Private IP must be set.
# Select a standard machine type with 1 vCPU.
# For the Connectivity Method, you must use VPC peering with the default VPC network.

# Test and then start the continuous migration job.
# If you do not correctly prepare the source PostgreSQL environment, the migration might fail completely, or it might fail to migrate some individual tables. If some tables are missing, even though the migration appears to be working otherwise, check that you have correctly configured all of the source database tables.

# Migrate a stand-alone PostgreSQL database to a Cloud SQL for PostgreSQL instance.
# Task 2. Promote a Cloud SQL to be a stand-alone instance for reading and writing data
# In this task, you must complete the migration by promoting the Cloud SQL for PostgreSQL instance to a stand-alone instance.
# Promote a Cloud SQL Migration Replica to a stand-alone instance.
# Task 3. Implement Cloud SQL for PostgreSQL IAM database authentication
# In this task you must configure the newly migrated Cloud SQL for PostgreSQL instance to support Cloud IAM users and IAM database authentication. You are also required to patch the Cloud SQL for PostgreSQL instance, to add the public ip-address of the postgres-vm virtual machine to the list of networks that are allowed to connect to the instance.

# To complete this task you must complete the following steps:

# Patch the Migrated Cloud SQL for PostgreSQL Instance ID Cloud SQL instance to allow connections from the public ip-address of the postgres-vm virtual machine.

# In the Migrated Cloud SQL for PostgreSQL Instance ID Cloud SQL instance, create a Cloud SQL IAM user using the lab student ID, Qwiklabs user account name, as the principal account name.

# Grant SELECT permission to the Cloud IAM user for the orders table.

# Run the following query as the Qwiklabs user account name user in the migrated database to confirm that the Qwiklabs user account name can select data from the orders table.

# SELECT COUNT(*) FROM orders

# Secure a Cloud SQL for PostgreSQL database table using Cloud IAM database authentication.
# Task 4. Configure and test point-in-time recovery
# In this task you must configure point-in-time recovery on a Cloud SQL for PostgreSQL instance and then test it by using point-in-time recovery to create a cloned instance at a point in time that rolls back some changes.

# To complete this task you must complete the following steps:

# Enable backups on the Cloud SQL for PostgreSQL instance.
# Enable point-in-time recovery and set the number of retained transaction log days to Point-in-time recovery retention days.
# Make a note of the timestamp for the point-in-time you wish to restore to.
# Make some changes to the database after this timestamp.
# You must add a row of data to the orders.distribution_centers table.
# Use point-in-time recovery to create a clone that replicates the instance state at your chosen timestamp.
# For the Cloned instance name you must use use the name postgres-orders-pitr.
# The new instance will not be used, but do not discard it, as it will be required to confirm that you have correctly completed the lab.

# Note: You must specify the point-in-time recovery timestamp in UTC time, specified in RFC 3339 format 'yyyy-MM-ddThh:mm:ss.mmmZ'.
# Enable and test point-in-time recovery.
# Congratulations!
# You completed the Manage PostgreSQL Databases on Cloud SQL: Challenge Lab! In this lab, you have migrated a standalone PostgreSQL database to Cloud SQL, enabled Cloud SQL IAM database authentication, and tested point-in-time database recovery.

# Earn your next skill badge
# This self-paced lab is part of the Manage PostgreSQL Databases on Cloud SQL quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge.

# See other available Qwiklabs quests available in the catalog.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated October 14, 2022

# Lab Last Tested October 14, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.