# Migrating MySQL User Data When Running Database Migration Service Jobs
# 1 hour 30 minutes
# 7 Credits
# Overview
# Database Migration Service provides a high-fidelity way to migrate MySQL database objects (including schema, data, and metadata) from a source database instance to a destination database instance. When you run a Database Migration Service job, all tables from all databases and schemas are migrated, with the exception of the following system databases: sys, mysql, performance_schema, and information_schema.

# MySQL system databases, which are not migrated during Database Migration Service jobs, contain information about users and privileges (additional details available in the Migration fidelity Guide). You can manage users and privileges in the destination Cloud SQL database instance after it is created.

# Objects that contain metadata defined with the DEFINER clause can fail when invoked on the destination instance, if the user associated with the DEFINER clause does not already exist in the destination instance (additional details available in the Create and run a MySQL migration job containing metadata with a DEFINER clause Guide).

# To prevent errors when these objects are invoked on the destination instance after migration, you can complete one of the following actions before running the migration job:

# Create the necessary users on the MySQL destination instance, so that all users associated with DEFINER clauses are present in the destination instance; OR:
# Update DEFINER clauses to INVOKER on the MySQL source instance. This ensures that the security privileges used to access the data on the destination instance are set to the privileges for the user running the query, rather than the privileges for the user who defined the object.
# In this lab, you learn how to ensure that your Cloud SQL for MySQL instance contains the relevant user metadata that was available on the MySQL source instance by completing both of the identified actions before running the migration job. First, you identify the existing MySQL users on the source instance and update DEFINER clauses to INVOKER for database objects on the source instance. Next, you create and save a Database Migration Service job. Before running the migration job, you create the necessary users on the destination database instance. Finally, you start the saved migration job; after the job runs successfully, you check the user metadata in the Cloud SQL for MySQL instance.

# Objectives
# In this lab, you learn how to migrate MySQL user data when running Database Migration Service jobs.

# Identify existing MySQL users on the source instance.

# Update DEFINER clauses to INVOKER on the MySQL source instance.

# Create and save a Database Migration Service job without starting the job.

# Create users on the Cloud SQL destination instance.

# Start a previously created Database Migration Service job.

# Check user metadata in the Cloud SQL destination instance.

# Setup
# For each lab, you get a new Google Cloud project and set of resources for a fixed time at no cost.

# Sign in to Qwiklabs using an incognito window.

# Note the lab's access time (for example, 1:15:00), and make sure you can finish within that time.
# There is no pause feature. You can restart if needed, but you have to start at the beginning.

# When ready, click Start lab.

# Note your lab credentials (Username and Password). You will use them to sign in to the Google Cloud Console.

# Click Open Google Console.

# Click Use another account and copy/paste credentials for this lab into the prompts.
# If you use other credentials, you'll receive errors or incur charges.

# Accept the terms and skip the recovery resource page.

# Note: Do not click End Lab unless you have finished the lab or want to restart it. This clears your work and removes the project.

# How to start your lab and sign in to the Console
# Click the Start Lab button. If you need to pay for the lab, a pop-up opens for you to select your payment method. On the left is a panel populated with the temporary credentials that you must use for this lab.

# Credentials panel

# Copy the username, and then click Open Google Console. The lab spins up resources, and then opens another tab that shows the Choose an account page.

# Note: Open the tabs in separate windows, side-by-side.
# On the Choose an account page, click Use Another Account. The Sign in page opens.

# Choose an account dialog box with Use Another Account option highlighted 

# Paste the username that you copied from the Connection Details panel. Then copy and paste the password.

# Note: You must use the credentials from the Connection Details panel. Do not use your Google Cloud Skills Boost credentials. If you have your own Google Cloud account, do not use it for this lab (avoids incurring charges).
# Click through the subsequent pages:
# Accept the terms and conditions.
# Do not add recovery options or two-factor authentication (because this is a temporary account).
# Do not sign up for free trials.
# After a few moments, the Cloud console opens in this tab.

# Note: You can view the menu with a list of Google Cloud Products and Services by clicking the Navigation menu at the top-left. Cloud Console Menu
# Activate Google Cloud Shell
# Google Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud.

# Google Cloud Shell provides command-line access to your Google Cloud resources.

# In Cloud console, on the top right toolbar, click the Open Cloud Shell button.

# Highlighted Cloud Shell icon

# Click Continue.

# It takes a few moments to provision and connect to the environment. When you are connected, you are already authenticated, and the project is set to your PROJECT_ID. For example:

# Project ID highlighted in the Cloud Shell Terminal

# gcloud is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

# You can list the active account name with this command:
# gcloud auth list
# Copied!
# Output:

# Credentialed accounts:
#  - @.com (active)
# Example output:

# Credentialed accounts:
#  - google1623327_student@qwiklabs.net
# You can list the project ID with this command:
# gcloud config list project
# Copied!
# Output:

# [core]
# project = 
# Example output:

# [core]
# project = qwiklabs-gcp-44776a13dea667a6
# Note: Full documentation of gcloud is available in the gcloud CLI overview guide .
# Verify that the Database Migration API is enabled
# In the Google Cloud Console, enter Database Migration API in the top search bar. Click on the result for Database Migration API.
# This page will either show status information or give you the option to enable the API.

# If necessary, enable the API.

# Verify that the Service Networking API is enabled
# In the Google Cloud Console, enter Service Networking API in the top search bar. Click on the result for Service Networking API.
# This page will either show status information or give you the option to enable the API.

# If necessary, enable the API.

# Task 1. Identify the existing MySQL users on the source instance
# Similar to other Cloud resources, you can control Cloud SQL project access and permissions on the destination instance using Identity and Access Management (IAM) (details available in the IAM for Cloud SQL Guide).

# In this task, you identify database users that are managed through database access control (read more in the About MySQL users Guide); for example, admins and superusers that can test the results of the migration job before others are provided access to the destination Cloud SQL instance via IAM.

# Connect to the MySQL source instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Locate the line with the instance called dms-mysql-training-vm.

# For Connect, click on SSH to open a terminal window.

# To connect to the MySQL interactive console within the terminal window, run the following command:

# mysql -u admin -p
# Copied!
# When prompted for a password, enter:

# changeme!
# Copied!
# Identify the existing MySQL users
# Run the following query to identify existing MySQL users:

# select host, user, authentication_string from mysql.user
# order by user;
# Copied!
# Notice the system users named debian-sys-maint, mysql.session, and mysql.sys. These users do not need to be recreated, as they are created by MySQL as needed when the destination instance is created.

# Run the modified query to exclude these system users:
# select host, user, authentication_string from mysql.user
# where user not like '%mysql%' and user not like '%debian%'
# order by user;
# Copied!
# Review the list of the users that need to be recreated in the destination Cloud SQL instance:
# host	user
# localhost	admin
# %	admin
# localhost	bsmith
# localhost	dwilliams
# localhost	mhill
# localhost	root
# %	root
# All users except for admin and root have localhost access only.

# You will create the root user when you create a new Database Migration Service job. You will create other users in a later task, after the Cloud SQL destination instance has been created by the migration job.

# Leave the terminal window open for use in the next task.

# Task 2. Update DEFINER to INVOKER on the MySQL source instance
# In the previous task, you identified the existing MySQL users on the source instance. In this task, you identify and update database objects that have DEFINER entries for either root or the other users that do not yet exist in the destination instance.

# If you have not or will not create a user in the destination instance, then all DEFINER entries associated with that user need to be updated to INVOKER. Any DEFINER entries for root need to be updated to INVOKER using another user such as admin.

# These actions prevent failures when the objects are invoked on the destination instance after migration (review additional documentation in the Create and run a MySQL migration job containing metadata with a DEFINER clause Guide).

# Identify objects with DEFINER entries
# To obtain information about DEFINERs in a MySQL instance, you can query the INFORMATION_SCHEMA tables to identify DEFINER entries that require review before migration (for example, DEFINER entries that are not associated with system databases such as mysql and thus will be migrated to the destination instance).

# Run the following query to identify DEFINER entries:

# select table_schema, table_name from information_schema.columns
# where column_name = 'DEFINER'
# and table_schema != 'mysql';
# Copied!
# The results indicate that you need to check events, routines, triggers, and views for DEFINER entries.

# Note that some of these DEFINER entries may be associated with system users, which do not require additional action. These system users will be excluded in the queries to identify DEFINER entries for the various database objects.

# Run the following query to identify DEFINERs in events:

# select definer, event_schema, event_name from information_schema.events
# where definer not like '%mysql%' and definer not like '%debian%';
# Copied!
# There are no instances of DEFINER in events associated with non-system users.

# Run the following query to identify DEFINERs in routines:

# select definer, routine_schema, routine_name from information_schema.routines
# where definer not like '%mysql%' and definer not like '%debian%';
# Copied!
# There are no instances of DEFINER in routines associated with non-system users.

# Run the following query to identify DEFINERs in triggers:

# select definer, trigger_schema, trigger_name from information_schema.triggers
# where definer not like '%mysql%' and definer not like '%debian%';
# Copied!
# There are no instances of DEFINER in triggers associated with non-system users.

# Run the following query to identify DEFINERs in views:

# select definer, security_type, table_schema, table_name from information_schema.views
# where definer not like '%mysql%' and definer not like '%debian%'
# order by definer;  
# Copied!
# Review the details for the view named invoices_storenum_3656, which is associated with mhill:
# definer	security_type	table_schema	table_name
# admin@localhost	DEFINER	customers_data	customers_single
# admin@localhost	DEFINER	sales_data	invoices_storenum_5173
# bsmith@localhost	DEFINER	customers_data	customers_married
# bsmith@localhost	DEFINER	sales_data	invoices_storenum_3980
# mhill@localhost	DEFINER	sales_data	invoices_storenum_3656
# This user will not be created in the destination instance. You will update DEFINER to INVOKER for this view in the next section to ensure that it will execute successfully in the destination instance.

# Notice that one of the previously identified users (dwilliams) is not associated with any DEFINER entries in views. Additionally, notice that there are no instances of DEFINER for the root user. No action is needed for either dwilliams or root.

# Update DEFINER to INVOKER
# In this subtask, you update the DEFINER entries associated with mhill to INVOKER because this user will not be created in the destination instance. You will leave the DEFINER entries for admin and bsmith because you will create these users in the destination instance in a later task before you run the migration job.

# Run the following command to see the details of the view associated with mhill:

# select definer, security_type, table_schema, view_definition from information_schema.views
# where table_name = 'invoices_storenum_3656';
# Copied!
# Select the database associated with the view:
# use sales_data;
# Copied!
# Run the following command to update DEFINER to INVOKER for the view:

# alter sql security INVOKER view invoices_storenum_3656 as
# (select * from invoices where storeNum = 3656);
# Copied!
# Review the DEFINER entries again to see that the view has been updated with INVOKER:

# select definer, security_type, table_schema, table_name from information_schema.views
# where definer not like '%mysql%' and definer not like '%debian%'
# order by definer;  
# Copied!
# Notice that the DEFINER entries for admin and bsmith remain. You have the option to leave the DEFINER clause for these users because you will create them in the destination instance in a later task.

# End the terminal session
# Exit the MySQL interactive console:
# exit
# Copied!
# Exit the terminal session:
# exit
# Copied!
# Click Check my progress to verify the objective.
# Update DEFINER clauses to INVOKER on the MySQL source instance.

# Task 3. Create and save a Database Migration Service job without starting it
# In this task, you create and save a migration job without starting the job. Specifically, you create a one-time migration job using VPC peering as the connectivity option; however, you can create and save any migration job to run at a later time.

# This allows you to create the destination Cloud SQL instance without migrating data until you have completed necessary tasks such as creating new users on the destination instance.

# Get the connectivity information for the MySQL source instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Locate the line with the instance called dms-mysql-training-vm.

# Copy the value for Internal IP (e.g. 10.128.0.2).

# Create a new connection profile for the MySQL source instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Connection profiles.

# Click Create Profile.

# For Source database engine, select MySQL.

# Enter the required information for a connection profile:

# Property	Value
# Connection profile name	mysql-vm
# Connection profile ID	keep the auto-generated value
# Hostname or IP address	enter the internal IP for the MySQL source instance that you copied in the previous task (e.g. 10.128.0.2)
# Port	3306
# Username	admin
# Password	changeme!
# For the Encryption Type, select None.

# Click Create.

# A new connection profile named mysql-vm will appear in the Connections profile list.

# Create a new one-time migration job
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click Create Migration Job.

# For Create a migration job, on the Get Started tab, use the following values:

# Property	Value
# Migration job name	vm-to-cloudsql
# Migration job ID	keep the auto-generated value
# Source database engine	MySQL
# Migration job type	One-time
# Leave all other settings as default.

# Click Save & Continue.

# Define the source instance
# For source connection profile, select mysql-vm.

# Leave the defaults for the other settings.

# Click Save & Continue.

# Create the destination instance
# Enter the required information to create the destination instance on Cloud SQL:
# Property	Value
# Destination Instance ID	mysql-cloudsql
# Root password	supersecret!
# Database version	Cloud SQL for MySQL 5.7
# Zone	Any
# For Instance connectivity, select Private IP and Public IP.

# Select Use an automatically allocated IP range.

# Click Allocate & Connect.

# Note: This step may take a few minutes. If asked to retry the request, click the Retry button to refresh the Service Networking API.

# When this step is complete, an updated message notifies you that the instance will use the existing managed service connection.
# Enter the additional information needed to create the destination instance on Cloud SQL:
# Property	Value
# Machine type	Standard
# Storage type	SSD
# Storage capacity	10
# Click Create & Continue.
# If prompted to confirm, click Create Destination & Continue.

# Define the connectivity method
# A message will state that your destination database instance is being created. Continue to step 1 while you wait.

# For Connectivity method, select VPC peering.

# For VPC, select default.

# VPC peering is configured by Database Migration Service using the information provided for the VPC network (the default network in this example).

# Wait for the Cloud SQL for MySQL instance to be created.
# When you see an updated message that the destination instance was created, proceed to the next step.

# Click Configure & Continue.

# Save the one-time migration job
# Review the details of the migration job.

# Click Create Job.

# You have not tested the migration job, so you may receive a message that the job may fail after it is started.

# Recall that testing the job now may result in an error message because there are DEFINER entries associated with users that have not yet been created in the destination instance (admin and bsmith).

# Create migration job? dialog box. Cretae button is highlighted.

# If prompted to confirm, click Create.
# The migration job has been created but has not been started. You will start the job in a later task, after you have created new users in the Cloud SQL destination instance.

# Click Check my progress to verify the objective.
# Create and save a Database Migration Service job without starting the job.

# Task 4. Create the necessary users on the Cloud SQL destination instance
# In Cloud SQL, you can create MySQL users, such as admins and superusers, who can test the results of the migration job before others are provided access via IAM. In addition, you want to create users that have DEFINER clauses associated with them, before you run a migration job.

# In this task, you create the users named admin and bsmith, so that the database objects with DEFINER clauses associated with these users will execute successfully.

# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click SQL.

# Expand the mysql-cloudsql-master instance and click on the instance ID called mysql-cloudsql.

# In the Replica Instance menu, click Users.

# Create user with localhost access only
# Recall from an earlier task, that bsmith is a MySQL user that connects via localhost on the source instance. You will limit this user to localhost access only.

# Click Add User Account.

# For User name, enter: bsmith

# For Password, enter: mustchangeasap!

# For Host name, select Restrict host by IP address or address range.

# For Host, enter: localhost

# Click Add.

# Create user with access from any host
# Next, you will create admin with access from any host.

# Click Add User Account.

# For User name, enter: admin

# For Password, enter: changeme!

# For Host name, select Allow any host.

# Click Add.

# Click Check my progress to verify the objective.
# Create users on the Cloud SQL destination instance.

# Task 5. Run a previously created migration job
# Start a migration job
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click the migration job vm-to-cloudsql to see the details page.

# Click the Start button to run the migration job.

# If prompted to confirm, click Start.

# Review the migration job status.
# If you have not started the job, the status will show as Not started. You can choose to start or delete the job.
# After the job has started, the status will show as Starting and then transition to Running.
# When the job status changes to Completed, the migration job has completed successfully, and you can move on to the next task.
# Click Check my progress to verify the objective.
# Run a previously created Database Migration Service job.

# Task 6. Confirm the user metadata in Cloud SQL for MySQL
# Connect to the MySQL instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click SQL.

# Click on the instance ID called mysql-cloudsql.

# In the Primary Instance menu, click Overview.

# In Connect to this instance panel, click Open Cloud Shell.

# The command to connect to MySQL will pre-populate in Cloud Shell:

# gcloud sql connect mysql-cloudsql --user=root --quiet
# Copied!
# Run the pre-populated command.
# If prompted, click Authorize for the API.

# When prompted for a password, which you previously set, enter:

# supersecret!
# Copied!
# You have now activated the MySQL interactive console.

# Review the user metadata in the Cloud SQL for MySQL instance
# Run the following query to see non-system users:
# select host, user, authentication_string from mysql.user
# where user not like '%mysql%' and user not like '%debian%'
# order by user;
# Copied!
# Notice that mhill is not listed as a user because you did not create this user in Cloud SQL.

# Run the following query to see that the user metadata has been migrated successfully:

# select definer, security_type, table_schema, table_name from information_schema.views
# where definer not like '%mysql%' and definer not like '%debian%'
# order by definer;  
# Copied!
# Review the DEFINER entries to see that the metadata for invoices_storenum_3656 was migrated successful even though you did not create the user mhill on Cloud SQL:
# definer	security_type	table_schema	table_name
# admin@localhost	DEFINER	customers_data	customers_single
# admin@localhost	DEFINER	sales_data	invoices_storenum_5173
# bsmith@localhost	DEFINER	customers_data	customers_married
# bsmith@localhost	DEFINER	sales_data	invoices_storenum_3980
# mhill@localhost	INVOKER	sales_data	invoices_storenum_3656
# To select the database in the MySQL interactive console, run the following command:

# use sales_data;
# Copied!
# Query the view associated with mhill to check that it executes successfully:

# select * from invoices_storenum_3656;
# Copied!
# Because you updated DEFINER to INVOKER for this view before the data were migrated, you did not have to create the user mhill for this view to execute successfully on the destination instance.

# Exit the MySQL interactive console:

# exit
# Copied!
# Click Check my progress to verify the objective.
# Confirm the user metadata in Cloud SQL for MySQL

# End your lab
# When you have completed your lab, click End Lab. Google Cloud Skills Boost removes the resources you’ve used and cleans the account for you.

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