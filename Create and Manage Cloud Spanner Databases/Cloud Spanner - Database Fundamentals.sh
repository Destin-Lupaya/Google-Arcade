# Cloud Spanner - Database Fundamentals
# 1 hour
# 1 Credit
# GSP1048
# Google Cloud self-paced labs logo

# Overview
# Cloud Spanner is Google’s fully managed, horizontally scalable relational database service. Customers in financial services, gaming, retail and many other industries trust it to run their most demanding workloads, where consistency and availability at scale are critical.

# In this lab you perform basic administrative tasks within a Cloud Spanner instance.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create an instance.

# Create a database.

# Create tables.

# Insert and modify data.

# Use the Google Cloud CLI with Cloud Spanner.

# Use Automation Tools with Cloud Spanner.

# Delete an instance.

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
# Task 1. Create an instance
# The first step in using Cloud Spanner is to create an instance. An instance is an allocation of Google Cloud compute and storage resources. On the Cloud Console Navigation menu (console_nav_small.png), under Databases click Spanner.

# Accept any acknowledgement or information window that may appear.

# Then click CREATE A PROVISIONED INSTANCE.

# Fill in the following fields, leave the remainder with the default values:

# Item	Value
# Instance Name	banking-instance
# Choose a configuration	us-central1 (lowa)
# Allocate Compute Capacity	Unit: Nodes, Quantity: 1

# Click Create. Now you can see your instance on the Instance Details page. Here you have an overview of how the instance is performing, utilization, etc.. The next step is to create a database.

# Task 2. Create a database
# From the instance details page, click Create database.

# For the database name, enter banking-db.

# Skip the Define your schema (optional) step for now. You'll define your schema in the next section.

# Click Create.

# You're now on the Overview page for the new database you created. You can see that the page is similar to the Instance one, but the statistics refer to the specific database. Also note the new options on the left menu.

# Click Check my progress to verify the objective.

# Create an instance and database
# Task 3. Create a table in your database
# On the Database Details page for your banking-db database, click Create table.

# As you can see in the DDL Templates dropdown, there are multiple statements that you can use and which helps you to create and alter tables.

# In the DDL statement field, enter:

# CREATE TABLE Customer (
#   CustomerId STRING(36) NOT NULL,
#   Name STRING(MAX) NOT NULL,
#   Location STRING(MAX) NOT NULL,
# ) PRIMARY KEY (CustomerId);
# Copied!
# Click Submit.

# When the operation is complete, click Customer to see the schema:

# Click Check my progress to verify the objective.

# Create a schema for your database
# Task 4. Insert and modify data
# The Cloud Console provides an interface for inserting, editing, and deleting data.

# Insert data
# In the left pane of the Console, click Data then click Insert.

# This takes you to the Query page automatically. Click Clear Query, paste the query below, and click Run:

# INSERT INTO
#   Customer (CustomerId,
#     Name,
#     Location)
# VALUES
#   ('bdaaaa97-1b4b-4e58-b4ad-84030de92235',
#     'Richard Nelson',
#     'Ada Ohio'
#     );
# Copied!
# The lower page of the screen shows the result. The Customer table now has one row.

# Add a second row. Replace the previous statement with the following, and click Run:

# INSERT INTO
#   Customer (CustomerId,
#     Name,
#     Location)
# VALUES
#   ('b2b4002d-7813-4551-b83b-366ef95f9273',
#     'Shana Underwood',
#     'Ely Iowa'
#     );
# Copied!
# On the lower part of the screen, click on the link that says View all data in the table. The Customer table now has two rows.

# Edit and Delete data
# Using the buttons Edit and Delete you can modify or erase data from the table in a similar way.

# Run a query
# You can execute a SQL statement on the query page of your database.

# In the left pane of the Cloud Platform Console, click Query to navigate to the Query UI window.

# Click Clear Query, paste the query below:

# SELECT * FROM Customer;
# Copied!
# Click Run.

# The Cloud Console displays the result of your query.

# Task 5. Use the Google Cloud CLI with Cloud Spanner
# The Cloud Console is very useful, but in some use cases you want to manage Spanner instances using other methods. Google Cloud services can also be managed through the command line tool named gcloud. The easiest way to use the gcloud CLI is via the Cloud Shell but it can also be installed on a wide variety of operating systems.

# Create an instance with CLI
# Creating a Spanner instance via gcloud is very simple. The core command is as follows:
#     gcloud spanner instances create [INSTANCE-ID] \
#     --config=[INSTANCE-CONFIG] \
#     --description="[INSTANCE-NAME]" \
#     --nodes=[NODE-COUNT]
# In the Cloud Shell, create a new Cloud Spanner using the command below.

# gcloud spanner instances create banking-instance-2 \
# --config=regional-us-central1  \
# --description="Banking Instance 2" \
# --nodes=2
# Copied!
# Listing instances
# You can run the following command to list the Spanner instances available in your project.

# gcloud spanner instances list
# Copied!
# Creating a database
# You can also create databases in a Spanner instance using gcloud.

# In the Cloud Shell, create a new database using the command below.

# gcloud spanner databases create banking-db-2 --instance=banking-instance-2
# Copied!
# Click Check my progress to verify the objective.
# Create an instance and database with CLI
# Modifying number of nodes
# Remember that it is important to provision enough nodes to keep CPU utilization and storage utilization below the recommended maximum values. However, sometimes it is necessary to reduce the number of nodes.

# You are now going to reduce the number of nodes of the instance banking-instance-2 from two to one.

# Use the following gcloud command to adjust the instance:

# gcloud spanner instances update banking-instance-2 --nodes=1
# Copied!
# After completion, check that the number of nodes has been reduced:

# gcloud spanner instances list
# Copied!
# Task 6. Use Automation Tools with Cloud Spanner
# As your Spanner architectures grow and get more complex, you want to automate the deployment and management of Spanner instances. One of the tools available to deploy and manage Spanner is Terraform.

# The goal of this lab is not to explain how Terraform works. If you are not familiar with Terraform, you can check the documentation.

# In short, you provide Terraform with a set of files that describe the infrastructure or services that you want it to deploy in Google Cloud, which is called a configuration. Then you instruct Terraform to initialize and plan the deployment, before applying the changes.

# Verify Terraform installation
# Terraform comes pre-installed in the Cloud Shell. Using the previous Cloud Shell (or open it again if you closed it), verify that terraform is available:

# terraform -version
# Copied!
# You should see an output similar to this:
# Terraform v1.2.2
# on linux_amd64
# Note: You may safely ignore any warning about the version of Terraform being out of date.
# Create Terraform Configuration
# In the cloud shell enter the following command to invoke the Nano text editor and create a new empty configuration file named spanner.tf.

# nano spanner.tf
# Copied!
# In the Nano editor, paste the code block listed below.

# resource "google_spanner_instance" "banking-instance-3" {
#   name         = "banking-instance-3"
#   config       = "regional-us-central1"
#   display_name = "Banking Instance 3"
#   num_nodes    = 2
#   labels = {
#   }
# }
# Copied!
# Press Ctrl+X to exit Nano, Y to confirm the update, and press Enter to save your changes.

# Deploy
# The next step is to make sure all the Terraform service providers are available (in this case, the Spanner service provider). For that, run the following command in the Cloud Shell:

# terraform init
# Copied!
# Next instruct Terraform to create an execution plan that is based on the configuration file that you created a few steps ago. Run the following command:

# terraform plan
# Copied!
# The output shows details about the new instance that will be created. Run the following command to apply the plan to your project:

# terraform apply
# Copied!
# The plan will be displayed again and Terraform will pause for approval to continue. Type yes and Terraform will create the new instance.

# The apply will process and return the following output:

# Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
# Confirm that the new instance was created:

# gcloud spanner instances list
# Copied!
# Task 7. Deleting instances
# A very quick way to delete an instance is using the CLI. Run the following command:

# gcloud spanner instances delete banking-instance-2
# Copied!
# To confirm that banking-instance-2 was deleted run the following command:

# gcloud spanner instances list
# Copied!
# Congratulations!
# You now have now a solid understanding of several basic administrative actions when using a Cloud Spanner Instance.

# Finish your quest
# This self-paced lab is part of the Create and Manage Cloud Spanner Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Manual Last Updated: January 13, 2023
# Lab Last Tested: January 13, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# # A Tour of Google Cloud Sustainability