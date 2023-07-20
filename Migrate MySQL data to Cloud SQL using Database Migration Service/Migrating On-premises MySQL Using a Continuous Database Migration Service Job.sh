# Migrating On-premises MySQL Using a Continuous Database Migration Service Job
# 1 hour 30 minutes
# 7 Credits
# Overview
# Database Migration Service provides options for one-time and continuous jobs to migrate data to Cloud SQL using different connectivity options, including IP allowlists, VPC peering, and reverse SSH tunnels (see documentation on connectivity options in the Configure connectivity Guide).

# In this lab, you migrate an on-premises MySQL database (running on a virtual machine) to Cloud SQL for MySQL using a continuous Database Migration Service job and VPC peering for connectivity.

# After you create and run the migration job, you confirm that an initial copy of your database has been successfully migrated to your Cloud SQL for MySQL instance. You also explore how continuous migration jobs apply data updates from your source database to your Cloud SQL instance. To conclude the migration job, you promote the Cloud SQL instance to be a standalone database for reading and writing data.

# Objectives
# In this lab, you learn how to configure a continuous Database Migration Service job to migrate databases from a MySQL instance to Cloud SQL for MySQL.

# Create a profile for a source connection to a MySQL instance (e.g., on-premises MySQL).

# Configure connectivity between the source and destination database instances using VPC peering.

# Create, run, and verify a continuous migration job using Database Migration Service.

# Promote the destination instance (Cloud SQL for MySQL) to be a standalone database for reading and writing data.

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

# Task 1. Get the connectivity information for the MySQL source instance
# In this task, you identify the internal IP address of the source database instance that you will migrate to Cloud SQL.

# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Locate the line with the instance called dms-mysql-training-vm-v2.

# Copy the value for Internal IP (e.g., 10.128.0.2).

# Task 2. Create a new connection profile for the MySQL source instance
# A connection profile stores information about the source database instance (e.g., on-premises MySQL) and is used by Database Migration Service to migrate data from the source to your destination Cloud SQL database instance. After you create a connection profile, it can be reused across migration jobs.

# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Connection profiles.

# Click Create Profile.

# For Source database engine, select MySQL.

# Enter the required information for a connection profile:

# Property	Value
# Connection profile name	mysql-vm
# Connection profile ID	keep the auto-generated value
# Hostname or IP address	enter the internal IP for the MySQL source instance that you copied in the previous task (e.g., 10.128.0.2)
# Port	3306
# Username	admin
# Password	changeme
# For Connection profile region select (region).

# For the Encryption Type, select None.

# Click Create.

# A new connection profile named mysql-vm will appear in the Connections profile list.

# Click Check my progress to verify the objective.
# Create a connection profile for the MySQL source instance.

# Task 3. Create and start a continuous migration job
# When you create a new migration job, you first define the source database instance using a previously created connection profile. Then you create a new destination database instance and configure connectivity between the source and destination instances.

# In this task, you use the migration job interface to create a new Cloud SQL for MySQL database instance and set it as the destination for the continuous migration job from the MySQL source instance.

# Create a new continuous migration job
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click Create Migration Job.

# For Create a migration job, on the Get Started tab, use the following values:

# Property	Value
# Migration job name	vm-to-cloudsql
# Migration job ID	keep the auto-generated value
# Source database engine	MySQL
# Destination region	(region)
# Migration job type	Continuous
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
# Zone	default_zone
# In Connections, select Private IP and Public IP.

# Select Use an automatically allocated IP range.

# Click Allocate & Connect.

# Note: This step may take a few minutes. If asked to retry the request, click the Retry button to refresh the Service Networking API.
# When this step is complete, an updated message notifies you that the instance will use the existing managed service connection.

# Enter the additional information needed to create the destination instance on Cloud SQL:
# Property	Value
# Machine type	Standard (1 vCPU, 3.75 GB)
# Storage type	SSD
# Storage capacity	10
# Click Create & Continue.
# If prompted to confirm, click Create Destination & Continue.

# Define the connectivity method
# A message will state that your destination database instance is being created. Continue to step 1 while you wait.

# The message states that the button for configure & continue is enabled when the destination Cloud SQL instance has been created.

# For Connectivity method, select VPC peering.

# For VPC, select default.

# VPC peering is configured by Database Migration Service using the information provided for the VPC network (the default network in this example).

# When you see an updated message that the destination instance was created, proceed to the next step.

# Click Configure & Continue.

# Test and start the continuous migration job
# Review the details of the migration job.

# Click Test Job.

# After a successful test, click Create & Start Job.

# If prompted to confirm, click Create & Start.

# Task 4. Review the status of the continuous migration job
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click the migration job vm-to-cloudsql to see the details page.

# Review the migration job status.

# If you have not started the job, the status will show as Not started. You can choose to start or delete the job.
# After the job has started, the status will show as Starting and then transition to Running Full Dump to indicate that the initial database dump is in progress.
# After the initial database dump has been completed, the status will transition to Running CDC in progress to indicate that continuous migration is active.
# When the job status changes to Running CDC in progress, proceed to the next task.

# Note: Continuous migration jobs remain in a running status to ensure that the destination database continues to receive data updates from the source.
# A completed status is achieved after the destination database is promoted to be a standalone database for reading and writing data (see task 7).
# Click Check my progress to verify the objective.
# Create, start, and review a continuous migration job.

# Task 5. Confirm the data in Cloud SQL for MySQL
# Check the MySQL databases in Cloud SQL
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL.

# Click on the instance ID called mysql-cloudsql (MySQL read replica).

# In the Replica Instance menu, click Databases.

# Notice that the databases called customers_data and sales_data have been migrated to Cloud SQL.

# Connect to the MySQL instance
# In the Replica Instance menu, click Overview.

# Click OPEN CLOUD SHELL.

# The command to connect to MySQL will pre-populate in Cloud Shell:

# gcloud sql connect mysql-cloudsql --user=root --quiet
# Copied!
# Run the pre-populated command.
# If prompted, click Authorize for the API.

# When prompted for a password, which you previously set, enter:

# supersecret!
# Copied!
# You have now activated the MySQL interactive console for the destination instance.

# Review the data in the Cloud SQL for MySQL instance
# To select the database in the MySQL interactive console, run the following command:

# use customers_data;
# Copied!
# Query the number of records in the customers table:

# select count(*) from customers;
# Copied!
# There are 5,030 records in the customers table that were migrated from the MySQL source instance.

# Sort the records in the customers table by last name and review the first ten records:

# select * from customers
# order by lastName
# limit 10;
# Copied!
# Note that the last name of the first record in the customers table is Accumsan.

# In the next task, you will add new records to the customers table in the source database instance. The continuous migration job will migrate the new records from the source instance to the destination instance.

# Exit the MySQL interactive console:

# exit
# Copied!
# Click Check my progress to verify the objective.
# Confirm the migrated data in Cloud SQL for MySQL.

# Task 6. Test the continuous migration of data from the source to the destination instance
# Add new data to the source instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM instances.

# Locate the line with the instance called dms-mysql-training-vm-v2.

# For Connect, click SSH to open a terminal window.

# To connect to the MySQL interactive console within the terminal window, run the following command:

# mysql -u admin -p
# Copied!
# When prompted for a password, enter:

# changeme
# Copied!
# To select the database in the MySQL interactive console, run the following command:

# use customers_data;
# Copied!
# Add two new data records to the customers table with the following command:

# INSERT INTO customers (customerKey, addressKey, title, firstName, lastName, birthdate, gender, maritalStatus, email, creationDate)
# VALUES ('9365552000000-999', '9999999', 'Ms', 'Magna', 'Ablorem', '1953-07-28 00:00:00', 'FEMALE', 'MARRIED', 'magna.lorem@gmail.com', CURRENT_TIMESTAMP),
# ('9965552000000-9999', '99999999', 'Mr', 'Arcu', 'Abrisus', '1959-07-28 00:00:00', 'MALE', 'MARRIED', 'arcu.risus@gmail.com', CURRENT_TIMESTAMP);
# Copied!
# Query the new number of records in the customers table:

# select count(*) from customers;
# Copied!
# There are now 5,032 records in the customers table in the MySQL source instance.

# Sort the records in the customers table by last name and review the first ten records:

# select * from customers
# order by lastName
# limit 10;
# Copied!
# Note that the last name of the first record in the customers table has changed to Ablorem.

# Exit the MySQL interactive console:
# exit
# Copied!
# Exit the terminal session:
# exit
# Copied!
# Connect to the Cloud SQL for MySQL instance
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL.

# Click on the instance ID called mysql-cloudsql (MySQL read replica).

# In the Replica Instance menu, click Overview.

# Click OPEN CLOUD SHELL.

# The command to connect to MySQL will pre-populate in Cloud Shell:

# gcloud sql connect mysql-cloudsql --user=root --quiet
# Copied!
# Run the pre-populated command.
# If prompted, click Authorize for the API.

# When prompted for a password, which you previously set, enter:

# supersecret!
# Copied!
# You have now activated the MySQL interactive console for the destination instance.

# Check that the data updates have been applied to the Cloud SQL for MySQL instance
# To select the database in the MySQL interactive console, run the following command:

# use customers_data;
# Copied!
# Query the number of records in the customers table:

# select count(*) from customers;
# Copied!
# Notice that the two records added to the MySQL source instance have been migrated. There are now 5,032 records in the customers table in the Cloud SQL destination instance.

# Sort the records in the customers table by last name and review the first ten records:

# select * from customers
# order by lastName
# limit 10;
# Copied!
# Notice that the last name of the first record in the customers table is now the same across the Cloud SQL destination instance and the MySQL source instance.

# Exit the MySQL interactive console:

# exit
# Copied!
# Click Check my progress to verify the objective.
# Test the continuous migration of data from the source to the destination.

# Task 7. Promote Cloud SQL to be a standalone instance for reading and writing data
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click the migration job name vm-to-cloudsql to see the details page.

# Click Promote.

# If prompted to confirm, click Promote.

# When the promotion is complete, the status of the job will update to completed.

# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL.
# Note that mysql-cloudsql is now a standalone instance for reading and writing data.

# The instance named mysql-cloudsql is labeled as the primary instance.

# Click Check my progress to verify the objective.
# Promote Cloud SQL for MySQL to be a standalone instance for reading and writing data.

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