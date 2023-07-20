# Migrating to Cloud SQL from Amazon RDS for MySQL Using Database Migration Service
# 1 hour 30 minutes
# 1 Credit
# GSP859
# Google Cloud Self-Paced Labs

# Overview
# Database Migration Service provides options for one-time and continuous jobs to migrate data to Cloud SQL using different connectivity options, including IP allowlists, VPC peering, and reverse SSH tunnels. Learn more about connectivity options from the configure connectivity guide).

# In this lab, you migrate a MySQL database from an Amazon RDS instance for MySQL to Cloud SQL for MySQL using a one-time Database Migration Service job and an IP allowlist for connectivity. After you create and run the migration job, you will check that the database has been successfully migrated to your Cloud SQL for MySQL instance.

# Objectives
# In this lab, you learn how to configure a one-time Database Migration Service job to migrate databases from a cloud-based MySQL instance to Cloud SQL for MySQL.

# Create a profile for a source connection to a cloud-based MySQL instance (Amazon RDS for MySQL).
# Configure connectivity between source and destination instances using an IP allowlist.
# Create and run a one-time migration job using Database Migration Service.
# Verify that the migration job has completed successfully.
# When you start the lab, it can take up to 10 minutes to fully provision the Google Cloud and Amazon RDS resources.

# The Amazon RDS resources are fully provisioned when a value is generated for AWS RDS Database - Source (such as mysql://qmflvsilronjc8.cyla72gcy8zl.us-east-1.rds.amazonaws.com:3306/SourceMySQLDatabase) within the AWS access information on this page.

# When you see values for the Google Console Username and Password, you may proceed to the Setup tasks.

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
# In the Google Cloud Console, enter Database Migration API in the top search bar.

# Click on the result for Database Migration API. This page will either show status information or give you the option to enable the API.

# If necessary, enable the API.

# Install a command-line utility to identify IP addresses
# Amazon RDS instance hostnames are often longer than the MySQL limit of 60 characters for hostnames. To configure a successful migration connection for MySQL, you can provide the IP address of the Amazon RDS instance, instead of the hostname. In this setup task, you install and use dig, a command-line utility, to obtain the IP address.

# To install dig in Cloud Shell, run the following command:

# sudo apt-get update && sudo apt-get install dnsutils -y
# Copied!
# For the next step, identify the hostname from the AWS RDS Database - Source (such as mysql://qmflvsilronjc8.cyla72gcy8zl.us-east-1.rds.amazonaws.com:3306/SourceMySQLDatabase) within the AWS access information on this page.

# The Amazon RDS instance hostname will be similar to qmflvsilronjc8.cyla72gcy8zl.us-east-1.rds.amazonaws.com. Do not include the prefix mysql:// or the suffix :3306/SourceMySQLDatabase as part of the hostname.
# To obtain the IP address of the Amazon RDS instance, run the following command in Cloud Shell (replace HOSTNAME with the Amazon RDS instance hostname, such as qmflvsilronjc8.cyla72gcy8zl.us-east-1.rds.amazonaws.com):

# dig HOSTNAME
# Copied!
# The IP address is provided in the last line of the Answer output section, such as 54.84.181.60.

# ;; ANSWER SECTION:
# qls-43123050feb97e21add454a6fa74bc9c-mydb-oocs9qo4aem6.ct0brribqcxe.us-east-1.rds.amazonaws.com. 5 IN CNAME ec2-54-84-181-60.compute-1.amazonaws.com.
# ec2-54-84-181-60.compute-1.amazonaws.com. 21600 IN A 54.84.181.60
# Note this IP address for use throughout this lab.

# Task 1. Install and configure the AWS CLI tool in Cloud Shell
# Although AWS configuration tasks can be completed in the AWS console, this lab uses the AWS CLI to complete these tasks in Cloud Shell. In this task, you install the AWS CLI tool in Cloud Shell to access the AWS resources from Google Cloud.

# To install the AWS CLI tool in Cloud Shell, run the following commands:

# curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
# unzip awscliv2.zip
# sudo ./aws/install
# Copied!
# To configure the AWS CLI tool in Cloud Shell, run the following command:

# aws configure
# Copied!
# Enter the required information to configure the AWS CLI tool:
# Property	Value
# AWS Access Key ID [None]	enter the provided value for AWS Access Key
# AWS Secret Access Key [None]	enter the provided value for AWS Secret Key
# Default region name [None]	us-east-1
# Default output format [None]	to accept the default, do not enter a value



# You have now configured the AWS CLI tool.

# Task 2. Create a new connection profile for the Amazon RDS instance for MySQL
# A connection profile stores information about the source database instance (such as Amazon RDS for MySQL) and is used by Database Migration Service to migrate data from the source to your destination Cloud SQL database instance. After you create a connection profile, it can be reused across migration jobs.

# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Connection profiles.

# Click Create Profile.

# For Source database engine, select Amazon RDS for MySQL.

# Enter the required information for a connection profile:

# Property	Value
# Connection profile name	mysql-rds
# Connection profile ID	keep the auto-generated value
# Hostname or IP address	enter the IP address you identified for the Amazon RDS instance in the Setup tasks (such as 54.84.181.60)
# Port	3306
# Username	admin
# Password	changeme



# Because you will use an IP allowlist as the connectivity option, you are providing a public address for the source. Learn more about connectivity options from the Database Migration Service documentation .

# For Region, select us-central1 (Iowa).

# For the Encryption Type, select None.

# You will an IP allowlist as the connectivity option, so you can consider using SSL/TLS certificates to encrypt the data migrating from the source to the destination instance. Learn more about using an IP allowlist from the Cloud SQL documentation.

# Click Create.
# A new connection profile named mysql-rds will appear in the Connections profile list.

# Click Check my progress to verify the objective.
# Create a connection profile for the MySQL source instance.

# Task 3. Create a one-time migration job
# When you create a new migration job, you first define the source database instance using a previously created connection profile. Then, you create a new destination database instance and configure connectivity between the source and destination instances.

# In this task, you will use the migration job interface to create a new Cloud SQL for MySQL instance and set it as the destination for the one-time migration job from the source Amazon RDS for MySQL instance.

# Create a new migration job
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click Create Migration Job.

# For Create a migration job, on the Get Started tab, use the following values:

# Property	Value
# Migration job name	rds-to-cloudsql
# Migration job ID	keep the auto-generated value
# Source database engine	Amazon RDS for MySQL
# Destination region	us-central1 (Iowa)
# Migration job type	One-time



# Leave all other settings as default.

# Click Save & Continue.

# Define the source instance
# For source connection profile, select mysql-rds.

# Leave the defaults for the other settings.

# Note: After you select the source connection profile, you can see its configuration details, including source hostname or IP address, port, username, and encryption type.
# Click Save & Continue.

# Create the destination instance
# Enter the required information to create the destination instance on Cloud SQL:
# Property	Value
# Destination Instance ID	mysql-cloudsql
# Root password	supersecret
# Database version	Cloud SQL for MySQL 5.7
# Zone	Any
# Connections	Public IP
# Machine type	Standard (1 vCPU, 3.75 GB)
# Storage type	SSD
# Storage capacity	10



# Click Create & Continue.

# When prompted to confirm, click Create Destination & Continue.

# Define the connectivity method
# A message will state that your destination database instance is being created. Continue to step 1 while you wait.

# For Connectivity method, select IP allowlist.
# When the destination database (Cloud SQL for MySQL) is created, the IP address will be available.

# Copy the Destination outgoing IP address (such as 35.239.140.158) to configure the IP allowlist on the Amazon RDS instance.

# Click Save & Continue.

# Leave this window open. You will modify the IP allowlist on the Amazon RDS instance in the next task.

# Click Check my progress to verify the objective.
# Create the Cloud SQL destination instance.

# Task 4. Configure the IP allowlist on source instance
# To allow connections between the source and destination instances, you need to modify the IP allowlist on the source. For Amazon RDS, you accomplish this by modifying a Database Security Group with the public IP address of the destination instance (such as Cloud SQL).

# Although this task can be completed in the AWS console, you will use the AWS CLI to complete this task in Cloud Shell.

# To modify the IP allowlist on the Amazon RDS instance, run the following command in Cloud Shell:

# Replace <sg_id> with the provided value for AWS RDS Database Security Group (such as sg-06700713f70076ad8) on this page, and replace <a.b.c.d> with the Destination outgoing IP address of your Cloud SQL instance (such as 35.239.140.158).

# aws ec2 authorize-security-group-ingress \
#     --group-id <sg-id> \
#     --protocol tcp \
#     --port 3306 \
#     --cidr <a.b.c.d>/32
# Copied!
# The IP address for the Cloud SQL instance has now been added to the IP allowlist on the Amazon RDS instance.

# Click Check my progress to verify the objective.
# Configure the IP allowlist on the source instance.

# Task 5. Test and run a one-time migration job
# Return to the migration job window and review the summary.

# Click Test Job.

# After a successful test, click Create & Start Job.

# Test and create your migration dialog box with Create and start job button highlighted

# Note: Be sure to click on the button for CREATE & START JOB to ensure that the job is successfully started.
# If prompted to confirm, click Create & Start.

# Task 6. Review status of the one-time migration job in DMS
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Database Migration > Migration jobs.

# Click the migration job rds-to-cloudsql to see the details page.

# Review the migration job status.

# If you have not started the job, the status will show as Not started. You can choose to start or delete the job.
# After the job has started, the status will show as Starting and then transition to Running.
# When the job status changes to Completed, the migration job has completed successfully, and you can move on to the next task.
# Click Check my progress to verify the objective.
# Review the status of the completed migration job.

# Task 7. Confirm the data in Cloud SQL for MySQL
# Check MySQL databases in Cloud SQL
# In the Google Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL.

# Click on the instance ID called mysql-cloudsql.

# In the Primary Instance menu, click Databases.

# Notice that the databases called customers_data and sales_data have been migrated to Cloud SQL.

# Connect to MySQL database
# In the Primary Instance menu, click Overview.

# In Connect to this instance panel, click on Open cloud shell button.

# The command to connect to MySQL will pre-populate in Cloud Shell:

# gcloud sql connect mysql-cloudsql --user=root --quiet
# Copied!
# Run the pre-populated command.
# If prompted, click Authorize for the API.

# When prompted for a password, which you previously set, enter:

# supersecret
# Copied!
# You have now activated the MySQL interactive console.

# Review data in Cloud SQL for MySQL database
# To select the database in the MySQL interactive console, run the following command:

# use customers_data;
# Copied!
# Query the number of records in the customers table:

# select count(*) from customers;
# Copied!
# There are 5,030 records in the customers table that was migrated from the Amazon RDS instance for MySQL.

# Exit the MySQL interactive console:

# exit
# Copied!
# Click Check my progress to verify the objective.
# Confirm the data in Cloud SQL for MySQL.

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

# Congratulations!
# Finish your quest
# This self-paced lab is part of the Migrating MySQL Data to Cloud SQL using Database Migration Servicequest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# Manual Last Updated: Aug 12, 2022
# Lab Last Tested: Aug 12, 2022
# Copyright 2022 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.