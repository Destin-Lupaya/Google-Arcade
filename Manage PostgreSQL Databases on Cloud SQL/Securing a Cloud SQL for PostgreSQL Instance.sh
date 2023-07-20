# Securing a Cloud SQL for PostgreSQL Instance
# 1 hour
# 1 Credit
# GSP920
# Google Cloud self-paced labs logo

# Overview
# This lab will provide you with step-by-step guidance on how to secure a Cloud SQL for PostgreSQL instance. You will deploy a new Cloud SQL instance using a customer-managed encryption key (CMEK). The CMEK feature lets you use your own cryptographic keys for data at rest in Cloud SQL. After adding customer-managed encryption keys, whenever an API call is made, Cloud SQL uses your key to access data. Once you have created the Cloud SQL for PostgreSQL instance you will configure pgAudit to selectively record and track SQL operations performed against that instance and finally you will configure and test Cloud SQL IAM database authentication.

# Objectives
# You will learn how to perform the following tasks:

# Setup CMEK for Cloud SQL for PostgreSQL.

# Enable and configure pgAudit on a Cloud SQL for PostgreSQL instance.

# Configure Cloud SQL for PostgreSQL IAM database authentication.

# Target Audience
# The content of this hands-on lab will be most applicable to PostgreSQL DBAs. This lab is designed to give professionals hands-on experience setting up and configuring Google Cloud resources to support PostgreSQL.

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
# Task 1. Create a Cloud SQL for PostgreSQL instance with CMEK enabled
# In this task you will create a Cloud SQL for PostgreSQL instance with CMEK enabled. It is imperative that you keep the keys safe as you cannot manage your database without them.

# Create a per-product, per-project service account for Cloud SQL
# You can create the service account you require for Cloud SQL CMEK using the gcloud beta services identity create command.

# In Cloud Shell, run:
# export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
# gcloud beta services identity create \
#     --service=sqladmin.googleapis.com \
#     --project=$PROJECT_ID
# Copied!
# Click the Authorize button if prompted.
# This creates the service account that you will bind to the CMEK in a later step.

# Create a Cloud Key Management Service keyring and key
# In this step you will create a Cloud KMS keyring and key to use with CMEK.

# In Cloud Shell, to create the Cloud KMS keyring, run:

# export KMS_KEYRING_ID=cloud-sql-keyring
# export ZONE=$(gcloud compute instances list --filter="NAME=bastion-vm" --format=json | jq -r .[].zone | awk -F "/zones/" '{print $NF}')
# export REGION=${ZONE::-2}
# gcloud kms keyrings create $KMS_KEYRING_ID \
#  --location=$REGION
# Copied!
# In Cloud Shell, to create the Cloud KMS key, run:

# export KMS_KEY_ID=cloud-sql-key
# gcloud kms keys create $KMS_KEY_ID \
# --location=$REGION \
# --keyring=$KMS_KEYRING_ID \
# --purpose=encryption
# Copied!
# In Cloud Shell, to bind the key to the service account, run:

# export PROJECT_NUMBER=$(gcloud projects describe ${PROJECT_ID} \
#     --format 'value(projectNumber)')
# gcloud kms keys add-iam-policy-binding $KMS_KEY_ID \
#     --location=$REGION \
#     --keyring=$KMS_KEYRING_ID \
#     --member=serviceAccount:service-${PROJECT_NUMBER}@gcp-sa-cloud-sql.iam.gserviceaccount.com \
#     --role=roles/cloudkms.cryptoKeyEncrypterDecrypter
# Copied!
# The service account name is the same name that was returned by the gcloud beta services identity create command in the previous sub-task.

# Create a Cloud SQL instance with CMEK enabled
# In this step you will create a Cloud SQL for PostgreSQL instance with CMEK enabled. It is not possible to patch an existing instance to enable CMEK, so you should bear this in mind if you plan to use CMEK to encrypt your data.

# In order to access your Cloud SQL instance from external development or application environments, you can configure the Cloud SQL instance with a public IP address and control access by allowlisting the IP address of those environments. This limits access to the public interface to those address ranges that you specify.

# You will treat the Compute Engine VM instance in the lab as a development environment and will therefore need the to allow list the external IP address of that instance. You will also add the external IP address of the Cloud Shell to the allowlist to make it easier to complete tasks later in the lab.

# In Cloud Shell, find the external IP address of the bastion-vm VM instance:
# export AUTHORIZED_IP=$(gcloud compute instances describe bastion-vm \
#     --zone=$ZONE \
#     --format 'value(networkInterfaces[0].accessConfigs.natIP)')
# echo Authorized IP: $AUTHORIZED_IP
# Copied!
# In Cloud Shell, find the external IP address of the Cloud Shell:
# export CLOUD_SHELL_IP=$(curl ifconfig.me)
# echo Cloud Shell IP: $CLOUD_SHELL_IP
# Copied!
# In Cloud Shell, create your Cloud SQL for PostgreSQL instance with:
# export KEY_NAME=$(gcloud kms keys describe $KMS_KEY_ID \
#     --keyring=$KMS_KEYRING_ID --location=$REGION \
#     --format 'value(name)')
# export CLOUDSQL_INSTANCE=postgres-orders
# gcloud sql instances create $CLOUDSQL_INSTANCE \
#     --project=$PROJECT_ID \
#     --authorized-networks=${AUTHORIZED_IP}/32,$CLOUD_SHELL_IP/32 \
#     --disk-encryption-key=$KEY_NAME \
#     --database-version=POSTGRES_13 \
#     --cpu=1 \
#     --memory=3840MB \
#     --region=$REGION \
#     --root-password=supersecret!
# Copied!
# Enter 'y' if asked after entering the command.
# Create a Cloud SQL instance with CMEK enabled
# Task 2. Enable and configure pgAudit on a Cloud SQL for PostgreSQL database
# In this task you will enable and configure the pgAudit database extension which enables fine-grained control of logging of all types of database activity.

# In Cloud Shell enter the following to add the pgAudit database flags to your Cloud SQL instance:
# gcloud sql instances patch $CLOUDSQL_INSTANCE \
#     --database-flags cloudsql.enable_pgaudit=on,pgaudit.log=all
# Copied!
# Hit enter to confirm and continue. Wait a minute for the patch command to complete before continuing.

# In Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL and click on the Cloud SQL instance named postgres-orders.

# In the Cloud SQL Overview panel, top menu, click Restart and Restart again in the pop-up dialog.

# It will take a minute to restart your Cloud SQL for PostgreSQL instance, then continue below.

# In Cloud Console, in the Connect to this instance section, click Open Cloud Shell. A command will be auto-populated to the Cloud Shell.

# Run that command and enter the password supersecret! when prompted. A psql session will start in Cloud Shell.

# In psql, to create the orders database and enable the pgAudit extension to log all reads and writes, run:

# CREATE DATABASE orders;
# \c orders;
# Copied!
# Enter the password supersecret! again.

# In psql, to create and configure the database extension, run:

# CREATE EXTENSION pgaudit;
# ALTER DATABASE orders SET pgaudit.log = 'read,write';
# Copied!
# Enable Audit Logging in Cloud Console
# In this step you will enable Audit Logging in Cloud Console.

# In Cloud Console, on the Navigation menu (Navigation menu icon), click IAM & Admin > Audit Logs.

# In the Filter box, type Cloud SQL and select the entry in the drop-down list.

# Check the checkbox for Cloud SQL on the left and all the checkboxes in the Info Panel on the right.

# Click the Save button in the Info Panel.

# Populate a database on Cloud SQL for PostgreSQL
# In this step you will populate the orders database with data provided to you.

# Click the + icon on the Cloud Shell title bar to open a new tab in the Cloud Shell, and in that tab, to download the data and database population scripts, run:
# export SOURCE_BUCKET=gs://cloud-training/gsp920
# gsutil -m cp ${SOURCE_BUCKET}/create_orders_db.sql .
# gsutil -m cp ${SOURCE_BUCKET}/DDL/distribution_centers_data.csv .
# gsutil -m cp ${SOURCE_BUCKET}/DDL/inventory_items_data.csv .
# gsutil -m cp ${SOURCE_BUCKET}/DDL/order_items_data.csv .
# gsutil -m cp ${SOURCE_BUCKET}/DDL/products_data.csv .
# gsutil -m cp ${SOURCE_BUCKET}/DDL/users_data.csv .
# Copied!
# In the same Cloud Shell session, create and populate the database as follows:
# export CLOUDSQL_INSTANCE=postgres-orders
# export POSTGRESQL_IP=$(gcloud sql instances describe $CLOUDSQL_INSTANCE --format="value(ipAddresses[0].ipAddress)")
# export PGPASSWORD=supersecret!
# psql "sslmode=disable user=postgres hostaddr=${POSTGRESQL_IP}" \
#     -c "\i create_orders_db.sql"
# Copied!
# It will take a minute for the orders database to be populated.

# Exit the terminal session in the new tab:
# exit
# Copied!
# In your psql session in the remaining Cloud Shell tab, to further log all SELECT operations on a particular relation, for example the order_items table, run the following commands:
# CREATE ROLE auditor WITH NOLOGIN;
# ALTER DATABASE orders SET pgaudit.role = 'auditor';
# GRANT SELECT ON order_items TO auditor;
# Copied!
# Run the first SELECT query below :
# Summary of orders by users
# Summary by individual product
# Orders by distribution center
# SELECT
#     users.id  AS users_id,
#     users.first_name  AS users_first_name,
#     users.last_name  AS users_last_name,
#     COUNT(DISTINCT order_items.order_id ) AS order_items_order_count,
#     COALESCE(SUM(order_items.sale_price ), 0) AS order_items_total_revenue
# FROM order_items
# LEFT JOIN users ON order_items.user_id = users.id
# GROUP BY 1, 2, 3
# ORDER BY 4 DESC
# LIMIT 500;
# Copied!
# The output is 500 rows long, so hit q and the colon prompt to return to the orders=> prompt.

# Repeat the last two steps for the other two queries tabs in the code block.

# Exit psql:

# \q
# Copied!
# View pgAudit logs
# In this step you will view the logging of your database updates and queries in the pgAudit logs.

# In Cloud Console, on the Navigation menu (Navigation menu icon), click Operations > Logging > Logs Explorer.

# In the Query tab of the Logs Explorer, paste the following and click the Run query button:

# resource.type="cloudsql_database"
# logName="projects/(GCP Project)/logs/cloudaudit.googleapis.com%2Fdata_access"
# protoPayload.request.@type="type.googleapis.com/google.cloud.sql.audit.v1.PgAuditEntry"
# Copied!
# In the histogram displayed, you can see the audit activity associated with your DDL inserts and the SELECT queries you ran earlier.
# A histogram with seven bars.

# Click on the last bar on the histogram - this corresponds to the SELECT queries you ran.
# In the Query results panel below the histogram, the log entries are listed.

# Expand a log entry, and under protoPayload.request you will see the SELECT query.
# Enable and configure pgAudit on a Cloud SQL for PostgreSQL database
# Task 3. Configure Cloud SQL IAM database authentication
# In this task you will configure Cloud SQL IAM database authentication. All of the database access and update tasks you have performed so far have used built-in PostgreSQL user accounts. You can also create Cloud SQL for PostgreSQL users using Cloud IAM accounts. Database users can authenticate to Cloud SQL using Cloud IAM instead of using built-in database accounts and fine-grained permissions at the database level can be granted to those users.

# In this task you will configure the lab user account as a Cloud SQL IAM user, grant that user access to the orders.order_items database table using the postgres administrator account, and then test access to the orders.order_items database table from the command line using the psql command line utility.

# The authentication process that is used in this task is explained in detail in the IAM authentication documentation for Cloud SQL for PostgreSQL.

# Test database access using a Cloud IAM user before Cloud SQL IAM authentication is configured.
# You will attempt to access the database using a Cloud IAM user before Cloud SQL IAM authentication haas been enabled in order to establish that the Cloud IAM user cannot initially access the data.

# Test access to the orders database using the lab student account as the username:
# export USERNAME=$(gcloud config list --format="value(core.account)")
# export CLOUDSQL_INSTANCE=postgres-orders
# export POSTGRESQL_IP=$(gcloud sql instances describe $CLOUDSQL_INSTANCE --format="value(ipAddresses[0].ipAddress)")
# export PGPASSWORD=$(gcloud auth print-access-token)
# psql --host=$POSTGRESQL_IP $USERNAME --dbname=orders
# Copied!
# This connection attempt will fail and you will see an authentication failed message similar to the following because the Cloud SQL IAM user has not been created yet:

# psql --host=$POSTGRESQL_IP $USERNAME --dbname=orders
# psql: error: connection to server at "35.226.251.234", port 5432 failed: FATAL:  password authentication failed for user "student-01-22fa974575e4@qwiklabs.net"
# connection to server at "35.226.251.234", port 5432 failed: FATAL:  password authentication failed for user "student-01-22fa974575e4@qwiklabs.net"
# Cloud SQL IAM database authentication uses OAuth 2.0 access tokens is the Cloud IAM user password, which are short-lived and only valid for one hour so you should regenerate the token every time you need to authenticate. The access token should always be passed into the psql command using the PGPASSWORD environment variable as the buffer for the psql password parameter is too small to hold the OAuth 2.0 token string.

# Create a Cloud SQL IAM user
# You will now create a Cloud SQL IAM user and confirm that Cloud SQL IAM user authentication has been enabled.

# In Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL and click on the Cloud SQL instance named postgres-orders.

# In the Cloud SQL Overview panel, in the Configuration panel note that the Database flags list includes pgAudit.log and cloudsql.enable_pgaudit only.

# Click Users to open the Users panel.

# Click Add user account.

# Select Cloud IAM.

# In the Principal box enter the lab student name.

# Click Add.

# Wait for the new user to be added.

# Click Overview and now note that cloudsql.iam_authentication has been added to the list of database flags.

# Grant the Cloud IAM user access to a Cloud SQL database table
# You will now connect to the postgres-orders instance using the built in postgres administrator account and grant access to the orders.order_items table to the Cloud IAM user.

# In the Cloud Shell connect to the postgres-orders Cloud SQL instance as the postgres administrative user:
# gcloud sql connect postgres-orders --user=postgres --quiet
# Copied!
# When prompted enter the password: supersecret!.

# Enter the following SQL command to switch to the orders database:

# \c orders
# Copied!
# When prompted for a password enter supersecret! again.

# Enter the following SQL command to grant the lab user all permissions on the order_items table. The Cloud IAM username for the lab has been inserted into this query for you.

# GRANT ALL PRIVILEGES ON TABLE order_items TO "[IAM Username]";
# \q
# Copied!
# Test database access using a Cloud IAM user after Cloud SQL IAM authentication is configured.
# You will repeat the attempt to access the database using a Cloud IAM user after Cloud SQL IAM authentication has been enabled in order to establish that the Cloud IAM user can now access the data.

# You can now test access to the database again using the Cloud IAM user instead of the built-in postgres user:

# In the Cloud Shell enter the following command to connect to the database using the Cloud IAM database user:
# export PGPASSWORD=$(gcloud auth print-access-token)
# psql --host=$POSTGRESQL_IP $USERNAME --dbname=orders
# Copied!
# This connection succeeds and you are now connected the instance using Cloud IAM user authentication.

# Test your access permission by running this query:
# SELECT COUNT(*) FROM order_items;
# Copied!
# This will now return a successful result:

# orders=> SELECT COUNT(*) FROM order_items;
#  count
# --------
#  198553
# (1 row)
# Confirm that you do not have access to one of the other tables by running this query:
# SELECT COUNT(*) FROM users;
# Copied!
# This will now return a successful result:

# orders=> SELECT COUNT(*) FROM users;
# ERROR:  permission denied for table users
# Configure Cloud SQL IAM database authentication
# Congratulations!
# You completed the lab! In this lab, you secured data at rest in Cloud SQL for PostgreSQL using a customer managed encryption key, enabled pgAudit, and configured Cloud SQL IAM database user authentication.

# Finish your quest
# This self-paced lab is part of the Manage PostgreSQL Databases on Cloud SQL quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in a quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# End your lab
# When you have completed your lab, click End Lab. Your account and the resources you've used are removed from the lab platform.

# You will be given an opportunity to rate the lab experience. Select the applicable number of stars, type a comment, and then click Submit.

# The number of stars indicates the following:

# 1 star = Very dissatisfied
# 2 stars = Dissatisfied
# 3 stars = Neutral
# 4 stars = Satisfied
# 5 stars = Very satisfied
# You can close the dialog box if you don't want to provide feedback.

# For feedback, suggestions, or corrections, please use the Support tab.

# Manual Last Updated: October 10, 2022

# Lab Last Tested: September 13, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.