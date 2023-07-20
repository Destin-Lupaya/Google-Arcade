# Configure Replication and Enable Point-in-Time-Recovery for Cloud SQL for PostgreSQL
# 1 hour
# 1 Credit
# GSP922
# Google Cloud self-paced labs logo

# Overview
# In this lab you will configure and test point-in-time recovery for a Cloud SQL for PostgreSQL instance.

# Point-in-time recovery helps you recover an instance to a specific point in time. For example, if an error causes a loss of data, you can recover a database to its state before the error occurred.

# A point-in-time recovery always creates a new instance; you cannot perform a point-in-time recovery to an existing instance. The new instance inherits the settings of the source instance.

# Objectives
# You will learn how to perform the following tasks:

# Enable point-in-time recovery on a Cloud SQL for PostgreSQL instance.

# Perform a point-in-time recovery.

# Confirm that the recovered database reflects an earlier point in time.

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
# Target audience
# The content of this hands-on lab will be most applicable to PostgreSQL DBAs. This lab is designed to give professionals hands-on experience setting up and configuring Google Cloud resources to support PostgreSQL.

# Task 1. Enable backups on the Cloud SQL for PostgreSQL instance
# In this task you will enable scheduled backups on a Cloud SQL for PostgreSQL instance.

# In Cloud Shell, display the instance details:
# export CLOUD_SQL_INSTANCE=postgres-orders
# gcloud sql instances describe $CLOUD_SQL_INSTANCE
# Copied!
# Click the Authorize button if prompted.

# In Cloud Shell, get the current UTC time in 24 hour format:

# date +"%R"
# Copied!
# In Cloud Shell, enter the following command to enable scheduled back-ups, replacing HH:MM with a time that is earlier than the time that was displayed in the previous step.

# gcloud sql instances patch $CLOUD_SQL_INSTANCE \
#     --backup-start-time=HH:MM
# Copied!
# Note: For the purposes of this lab, it is imperative that you specify a backup start time earlier than the time displayed in the previous step. This is because you do not want a back-up to start while you are running the lab.
# For example if the date command shows that the current time is 14:25 you could replace HH:MM with 13:25, or even 12:00. You must make sure it is a valid time in 24 hour format or you will receive an error saying the request was invalid.

# Confirm your changes. Note the format parameter, which extracts only the desired fields.
# gcloud sql instances describe $CLOUD_SQL_INSTANCE --format 'value(settings.backupConfiguration)'
# Copied!
# You will see a response similar to the following showing that backups are set for 7 days, and run at 14:00 daily in this example:

# backupRetentionSettings={'retainedBackups': 7, 'retentionUnit': 'COUNT'}; enabled=True;kind=sql#backupConfiguration; startTime=14:00; transactionLogRetentionDays=7
# Enable Backups on the Cloud SQL for PostgreSQL instance
# Task 2. Enable and run point-in-time recovery
# In this task you will enable and configure point-in-time recovery on a Cloud SQL for PostgreSQL instance. A point-in-time recovery always creates a new instance; you cannot perform a point-in-time recovery to an existing instance. The new instance inherits the settings of the source instance.

# Enable point-in-time recovery
# In this step you will enable point-in-time recovery.

# In Cloud Shell, enable point-in-time recovery:
#   gcloud sql instances patch $CLOUD_SQL_INSTANCE \
#      --enable-point-in-time-recovery \
#      --retained-transaction-log-days=1
# Copied!
# It will take a minute or two for this command to complete.

# Make a change to the Cloud SQL for PostgreSQL database
# In this step you will add a row to the orders.distribution_centers table in the database. After point-in-time recovery we will expect this row to be absent from the database.

# In Cloud Console, on the Navigation menu (Navigation menu icon), click Databases > SQL and click on the Cloud SQL instance named postgres-orders.

# In Cloud Console, in the Connect to this instance section, click Open Cloud Shell. A command will be auto-populated to the Cloud Shell.

# Run that command and enter the password supersecret! when prompted. A psql session will start in Cloud Shell.

# In psql, change to the orders database:

# \c orders
# Copied!
# When prompted, enter the password supersecret! again.

# In psql, get the row count of the distribution_centers table:

# SELECT COUNT(*) FROM distribution_centers;
# Copied!
# Output:

# orders=> SELECT COUNT(*) FROM distribution_centers;
#  count
# -------
#     10
# (1 row)
# In Cloud Shell, open a new tab (+), get the current UTC time in RFC 3339 format. This is the timestamp you will use for the point-in-time replica that you will create in the next task.
# date --rfc-3339=seconds
# Copied!
# You should wait for a few moments at this point to make sure that the changes you make in the next step occur after this timestamp.

# Note: For the purposes of this lab, it is imperative that you specify a timestamp after point-in-time recovery was enabled (if not a successful back-up will be required as a starting point), but before the source instance was modified. If not your changes at the source will be replicated to the clone and the roll back won't be evident.
# In psql, to add a row to the orders.distribution_centers table and get the new COUNT, run:
# INSERT INTO distribution_centers VALUES(-80.1918,25.7617,'Miami FL',11);
# SELECT COUNT(*) FROM distribution_centers;
# Copied!
# Output:

# orders=> SELECT COUNT(*) FROM distribution_centers;
#  count
# -------
#     11
# (1 row)
# Exit psql:
# \q
# Copied!
# Perform a point-in-time recovery
# In this step you will make a clone of the postgres-orders Cloud SQL instance at a specific point in time.

# In Cloud Shell, to create a point-in-time clone, run:
# export NEW_INSTANCE_NAME=postgres-orders-pitr
# gcloud sql instances clone $CLOUD_SQL_INSTANCE $NEW_INSTANCE_NAME \
#     --point-in-time 'TIMESTAMP'
# Copied!
# You must replace the TIMESTAMP placeholder with the exact timestamp displayed by the date command you used earlier in the second Cloud Shell tab.

# This TIMESTAMP must be UTC timezone, RFC 3339 format, for example, '2021-11-01 15:00:00'. The TIMESTAMP indicates the time to which you want to recover the state of the database. It should be enclosed in single quotes. The alternate RFC3339 variant is also supported: '2021-11-01T15:00:00.000Z'.

# It could take 10 minutes or more for the replica to be created and ready for use. In the mean time, continue with the next task.

# Enable and run point-in-time recovery
# Task 3. Confirm database has been restored to the correct point-in-time
# In this task you will confirm that a row of data that was added to the original database after the point-in-time recovery timestamp is not in the cloned database.

# In Cloud Console, on the Overview page, click the All Instances breadcrumb and then click on the Cloud SQL instance named postgres-orders-pitr.
# Now you will have to wait for the replica to come online.

# In Cloud Console, in the Connect to this instance section, click Open Cloud Shell. A command will be auto-populated to the Cloud Shell.

# Run that command and enter the password supersecret! when prompted. A psql session will start in Cloud Shell.

# In psql, change to the orders database:

# \c orders
# Copied!
# When prompted, enter the password supersecret! again.

# In psql, get the row count of the distribution_centers table:

# SELECT COUNT(*) FROM distribution_centers;
# Copied!
# Output:

# orders=> SELECT COUNT(*) FROM distribution_centers;
#  count
# -------
#     10
# (1 row)
# You will see that the distribution_centers table in the new Cloud SQL for PostgreSQL instance has the 10 rows that it had on the source instance at the point-in-time of cloning. If your query returns 11 rows check that you have connected to the replica instance and not the original.

# Cloned database does not include changes made after the recovery timestamp
# Congratulations!
# In this lab configured and tested point-in-time recovery for a Cloud SQL for PostgreSQL instance.

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

# Manual Last Updated: October 6, 2022

# Lab Last Tested: June 16, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.