# Congratulations!
# Monitoring and Managing Bigtable Health and Performance
# 1 hour 30 minutes
# 1 Credit
# GSP1056
# Google Cloud Self-Paced Labs logo

# Overview
# Bigtable is Google's fully managed, scalable NoSQL database service. Bigtable is ideal for storing large amounts of data in a key-value store and for use cases such as personalization, ad tech, financial tech, digital media, and Internet of Things (IoT). Bigtable supports high read and write throughput at low latency for fast access to large amounts of data for processing and analytics.

# Bigtable provides many options for monitoring and managing the health and performance of your instance, including charts for storage (disk) and compute (CPU) utilization, flexible options for autoscaling of nodes, replication to improve the durability and availability of your data, and backup and restoration of tables.

# In this lab, you access various charts to monitor disk and CPU usage in a Bigtable instance, update an existing cluster to use node autoscaling, implement replication in an instance, and back up and restore data in Bigtable.

# Objectives
# In this lab, you learn how to monitor and manage the health and performance of a Bigtable instance.

# Monitor disk and CPU usage for a Bigtable instance.

# Configure node autoscaling and replication in Bigtable.

# Back up and restore data in Bigtable.

# Prerequisites
# Basic understanding of database concepts and terms such as instances, schemas, and keys

# Completion of GSP1053 Designing and Querying Bigtable Schemas

# Completion of GSP1055 Streaming Data to Bigtable

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
# Check project permissions
# Before you begin working on Google Cloud, you must ensure that your project has the correct permissions within Identity and Access Management (IAM).

# In the Google Cloud console, on the Navigation menu (Navigation menu icon), click IAM & Admin > IAM.

# Confirm that the default compute Service Account {project-number}-compute@developer.gserviceaccount.com is present and has the editor role assigned. The account prefix is the project number, which you can find on Navigation menu > Cloud overview.

# Default compute service account

# If the account is not present in IAM or does not have the editor role, follow the steps below to assign the required role.

# In the Google Cloud console, on the Navigation menu, click Cloud overview.

# From the Project info card, copy the Project number.

# On the Navigation menu, click IAM & Admin > IAM.

# At the top of the IAM page, click Add.

# For New principals, type:

# {project-number}-compute@developer.gserviceaccount.com
# Copied!
# Replace {project-number} with your project number.

# For Select a role, select Basic (or Project) > Editor.

# Click Save.

# Task 1. Use Dataflow to create high throughput reads
# In this task, you initiate a Dataflow job in Cloud Shell to create high throughput reads on your Bigtable data. The job simulates a real-world workflow in which your data is served to other applications for additional processing. In a later task, you review the CPU utilization resulting from this Dataflow job.

# For a review of how to access Cloud Shell, see the Setup and requirements section earlier in this guide.

# To enable the Dataflow API, run the following command in Cloud Shell:

# gcloud services enable dataflow.googleapis.com
# Copied!
# To run the Dataflow job, run the following command:

# gcloud dataflow flex-template run \
#     serve-recommendation-workload \
#     --template-file-gcs-location \
#     "gs://tcd_repo/scripts/bigtable/dataflow/generate-reads.json" \
#     --parameters \
#     bigtableInstanceId="sandiego" \
#     --parameters \
#     bigtableTableId="current_conditions" \
#     --parameters \
#     workloadRate="1000000" --region \
#     "us-central1"
# Copied!
# Although this job requires several minutes to fully initiate, you can begin the next task.

# Click Check my progress to verify the objective.
# Create and run the Dataflow job.

# Task 2. Monitor disk and CPU usage
# To ensure the performance of your Bigtable instance, it is important to monitor the disk and CPU usage for each cluster in your instance. When the disk or CPU usage for a cluster exceeds the recommended thresholds, the cluster is not performant and may return errors for attempts to read or write data.

# In this task, you use the Monitoring tab in Bigtable to review disk and CPU utilization for a cluster to ensure that the values are under the recommended thresholds.

# Monitor disk utilization
# In Bigtable, the storage capacity of each cluster is determined by the storage type (SSD or HDD) and the number of nodes. As the amount of data in a cluster increases, Bigtable redistributes the data across the nodes in the cluster.

# In general, we recommend that you utilize less than 70% of disk storage in a cluster. For latency-sensitive applications, we recommend that storage utilization per node remain below 60%. As your data grows, you can add more nodes to maintain low latency.

# In the Google Cloud Console, in the Navigation menu (Navigation menu), under Databases, click Bigtable.

# Click on the instance ID named sandiego.

# In the navigation menu for Bigtable, under Insights, click Monitoring.

# For Group by, select Cluster.

# Review the charts with names beginning with the prefix Storage.


# Which chart displays the storage usage as a percent of the total storage capacity for each cluster?

# Storage utilization (bytes)

# Storage utilization

# Read throughput

# You can calculate the storage usage per node by dividing the storage utilization in bytes by the number of nodes in the cluster.


# For the existing cluster, is the storage utilization per node below the recommended limit of 60%?

# Yes

# Equal to 60%

# No

# Monitor CPU usage
# The nodes in each cluster use CPU resources to handle reads, writes, and administrative tasks. For optimal performance, CPU utilization should remain below 70% average CPU utilization and 90% CPU utilization for the most used node.

# In Task 1, you initiated a Dataflow job to simulate high reads of your data. In this section, you monitor the CPU utilization resulting from the Dataflow job.

# In the Google Cloud Console, in the Navigation menu (Navigation menu), under Analytics, click Dataflow.

# Review the Dataflow job status to check that it is running successfully.

# When the Dataflow job displays a Running status, proceed to the next step.
# In the Google Cloud Console, in the Navigation menu (Navigation menu), under Databases, click Bigtable.

# Click on the instance ID named sandiego.

# In the navigation menu for Bigtable, under Insights, click Monitoring.

# For Group by, select Cluster.

# Review the charts with names beginning the prefix CPU.


# Which chart shows the average CPU utilization across all nodes in the cluster?

# Write throughput

# CPU utilization (hottest node)

# CPU utilization


# For the existing cluster, is the CPU utilization for the busiest node below the recommended limit of 90%?

# Yes

# No

# Equal to 90%

# Task 3. Configure node autoscaling
# After reviewing the disk and CPU utilization of your clusters, you may need to increase the number of nodes to satisfy the recommended levels for compute and storage. Bigtable provides options for either manual allocation or autoscaling of node count in a cluster.

# When autoscaling is enabled for a cluster, Bigtable adjusts the number of nodes to meet the targets for CPU and storage utilization. In this task, you enable autoscaling of nodes in an existing cluster in your Bigtable instance.

# In the navigation menu for Bigtable, under Instance, click Overview.

# From the list of cluster IDs, click on the cluster ID named sandiego-traffic-sensors-c1.

# Review the details provided in the Overview section. The node scaling mode is currently set to Manually scale nodes.

# To apply node autoscaling to the cluster, run the following command:

# gcloud bigtable clusters update sandiego-traffic-sensors-c1 \
# --instance=sandiego \
# --autoscaling-min-nodes=1 \
# --autoscaling-max-nodes=3 \
# --autoscaling-cpu-target=60
# Copied!
# Refresh the page, and click Show details for Autoscale nodes.

# Autoscaling has been applied to the cluster, starting with one node autoscaling up to three nodes. The CPU utilization target is set to the recommended value of 60%.


# What is the storage utilization target for this cluster?

# 70%

# 60%

# 50%

# Click Check my progress to verify the objective.
# Configure node autoscaling.

# Task 4. Configure replication
# If an instance has only one cluster, the durability and availability of your data are limited to the zone where that cluster is located. Replication can improve both durability and availability by storing separate copies of your data in multiple zones or regions and automatically failing over between clusters if needed.

# In this task, you configure replication in your Bigtable instance by adding a new cluster with autoscaling enabled to ensure the adequate provisioning of resources for the new cluster.

# To return to the Overview page for the instance, click Instance sandiego.

# Click Edit instance.

# Click Add cluster.

# Enter the required information to create a new cluster:

# Property	Value
# Cluster ID	sandiego-traffic-sensors-c2
# Region	____
# Zone	Select any available zone.
# Node scaling mode	Autoscaling
# Minimum	1
# Maximum	3
# CPU utilization target	60

# Click Add.

# Click Save.

# In the list of cluster IDs, there are now two clusters:

# sandiego-traffic-sensors-c1
# sandiego-traffic-sensors-c2
# Click Check my progress to verify the objective.
# Configure replication.

# Task 5. Back up and restore data in Bigtable
# In Bigtable, you can back up the schema and data of a table, and then restore the backup to a new table as needed. While replication is intended to enable failover to different regions or zones, backups are intended to help recover data from application-level data corruption or operational errors such as accidental table deletions.

# In this task, you create a backup of the table named current_conditions, and then restore the backup to a new table in your instance.

# Create a backup
# In the navigation menu for Bigtable, under Instance, click Tables.

# From the list of table IDs, in the line for current_conditions, click the Table action (More icon) menu, and then click Create backup.

# The Table ID is prepopulated as current_conditions, and it will be the first available backup for the table.

# For Cluster ID, select sandiego-traffic-sensors-c1.

# The cluster ID identifies the cluster from which the table is backed up and the cluster where the backup is stored.

# For Backup ID, type current_conditions_30.

# For Set an expiration date, select 30 days.

# The expiration date is automatically updated to 30 days from the present time.

# Click Create.

# Restore backup
# In Bigtable, backups are not readable. To access the data in a backup, you can use the option for Restore on the Backups tab for Bigtable.

# From the list of backup IDs, in the line for current_conditions_30, click Restore.

# For Table ID, type current_conditions_30_restored.

# Click Restore.

# To remove the filter for table ID, click on the x next to Table: current_conditions_30_restored.

# In the list of table IDs, there are now two tables:

# current_conditions
# current_conditions_30_restored
# Delete backup
# You can also easily delete a backup when it is no longer needed.

# In the navigation menu for Bigtable, under Instance, click Backups.

# From the list of backup IDs, in the line for current_conditions_30, click on the three vertical dots, and select Delete.

# In the confirmation dialog, type current_conditions_30

# Click Delete.

# Click Check my progress to verify the objective.
# Create the backup and restore it.

# Congratulations!
# You have now completed key tasks to monitor and manage the health and performance of your Bigtable instance, including reviewing disk and CPU utilization, enabling node autoscaling and replication, and backing up and restoring data.

# Finish your quest
# This self-paced lab is part of the Manage Bigtable on Google Cloud quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Take your next lab
# Continue your quest with GSP380 Manage Bigtable on Google Cloud: Challenge Lab.

# Manual Last Updated February 06, 2023

# Lab Last Tested February 06, 2023

# Copyright 2022 Google LLC All rights reserved. Google and the Google logo are