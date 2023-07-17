# Streaming Data to Bigtable
# 1 hour 30 minutes
# 1 Credit
# GSP1055
# Google Cloud Self-Paced Labs logo

# Overview
# Bigtable is Google's fully managed, scalable NoSQL database service. Bigtable is ideal for storing large amounts of data in a key-value store and for use cases such as personalization, ad tech, financial tech, digital media, and Internet of Things (IoT). Bigtable supports high read and write throughput at low latency for fast access to large amounts of data for processing and analytics.

# For streaming data from sensors, Bigtable can handle high writes to capture large volumes of real-time data.

# In this lab, you use commands to create a Bigtable instance with a table to store simulated traffic sensor data. Then you launch a Dataflow pipeline to load the simulated streaming data from Pub/Sub into Bigtable. While the Dataflow job loads streaming data from Pub/Sub into Bigtable, you verify that the table is being successfully populated. You complete the lab by stopping the streaming job and deleting the Bigtable data.

# Objectives
# In this lab, you learn how to create a Bigtable instance and table using commands and use Dataflow to load streaming data.

# Create a Bigtable instance using Google Cloud CLI (gcloud CLI) commands.

# Create a Bigtable table with column families using Cloud Bigtable CLI (cbt CLI) commands.

# Launch a Dataflow pipeline to read streaming data from Pub/Sub and write into Bigtable.

# Verify the streaming data loaded into Bigtable.

# Delete a Bigtable table and a Bigtable instance using commands.

# Prerequisites
# Basic understanding of database concepts and terms such as instances, schemas, and keys

# Completion of GSP1053 Designing and Querying Bigtable Schemas

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
# Cloud console
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

# Task 1. Create a Bigtable instance and table using commands
# To create a new table in Bigtable, you first need to create a Bigtable instance to store your table. To create a Bigtable instance, you can use the Google Cloud console, gcloud CLI commands, or cbt CLI commands.

# In this task, you use Cloud Shell to first run gcloud CLI commands to create a new Bigtable instance, and then run cbt CLI commands to connect to Bigtable and create a new table.

# For a review of how to access Cloud Shell, click Setup and requirements on the right-side menu of this page.

# Create a Bigtable instance
# To create a new Bigtable instance, in Cloud Shell, run the following command after updating the zone to ____:

# gcloud bigtable instances create sandiego \
# --display-name="San Diego Traffic Sensors" \
# --cluster-storage-type=SSD \
# --cluster-config=id=sandiego-traffic-sensors-c1,zone=zone,nodes=1
# Copied!
# This command creates a new Bigtable instance with the following properties:

# Property	Value
# Instance ID	sandiego
# Instance display name	San Diego Traffic Sensors
# Storage Type	SSD
# Cluster ID	sandiego-traffic-sensors-c1
# Zone	____
# Node scaling mode	Manual allocation
# Number of nodes	1



# When you receive the output message stating Creating bigtable instance sandiego...done., continue to the next task.

# Configure the Bigtable CLI
# To connect to Bigtable using cbt CLI commands, you first need to use Cloud Shell to update the .cbtrc configuration file with your project ID and your Bigtable instance ID.

# To modify the .cbtrc file with the project ID and instance ID, run the following commands:

# echo project = `gcloud config get-value project` \
#     >> ~/.cbtrc
# Copied!
# echo instance = sandiego \
#     >> ~/.cbtrc
# Copied!
# To verify that you have successfully modified the .cbtrc file, run the following command:

# cat ~/.cbtrc
# Copied!
# The output should resemble the following:

# project = <project-id>
# instance = sandiego
# Create a Bigtable table with column families
# After you configure the .cbtrc configuration file in Cloud Shell, you can run a simple cbt CLI command to create a new Bigtable table with column families.

# To create a new table named current_conditions with one column family named lane, run the following command:

# cbt createtable current_conditions \
#     families="lane"
# Copied!
# Click Check my progress to verify the objective.
# Create a Bigtable instance and table.

# Task 2. Simulate streaming traffic sensor data into Pub/Sub
# In this task, you run a streaming data simulator from a Compute Engine virtual machine (VM) that has been created for this lab. To begin this task, you will enter commands on a VM named training-vm to set up your environment and download the necessary files for the streaming data simulator.

# Connect to the VM
# In the Google Cloud console, on the Navigation menu (nav-menu.png), click Compute Engine > VM instances.

# Locate the line with the instance called training-vm, and under Connect, click SSH.

# A terminal window for training-vm will open.

# The training-vm is installing some software in the background. In the next step, you verify that setup is complete by checking the contents of the new directory.

# To list the contents of the directory named training, run the following command:

# ls /training
# Copied!
# The VM is ready for you to continue when the output of the ls command yields the following result:

# bq_magic.sh  project_env.sh  sensor_magic.sh
# If the three scripts are not listed, wait a few minutes and try again.

# Note: It may take 2 to 3 minutes for all background actions to complete.
# Run script to simulate streaming data
# To download a code repository for use in this lab, run the following command:

# git clone https://github.com/GoogleCloudPlatform/training-data-analyst
# Copied!
# To set up the required environmental variables, run the following command:

# source /training/project_env.sh
# Copied!
# This script sets the $DEVSHELL_PROJECT_ID and $BUCKET environment variables so that you do not have to manually set these variables for Project ID and Cloud Storage bucket name.

# A Cloud Storage bucket was created for you during the initialization of lab resources.

# To start the streaming data simulator, run the following command:

# /training/sensor_magic.sh
# Copied!
# This script reads sample data from a CSV file and publishes it to Pub/Sub. This script will send one hour of data in one minute.

# Let the script continue to run in the current terminal, and continue with the next tasks.

# Click Check my progress to verify the objective.
# Simulate streaming traffic sensor data into Pub/Sub.

# Task 3. Launch a Dataflow pipeline to write data from Pub/Sub into Bigtable
# In this task, you open a second SSH terminal on training_vm and run commands to launch a Dataflow job to write streaming data from Pub/Sub into Bigtable.

# Open a second SSH terminal
# In the current terminal window, click Terminal settings (ssh_gear_settings.png), and then click New connection.
# A second terminal window will open. This new terminal session will not have the required environment variables. In the next step, you set these variables on the new terminal session.

# To set the environment variables in the new terminal, run the following command:

# source /training/project_env.sh
# Copied!
# This script sets the $DEVSHELL_PROJECT_ID and $BUCKET environment variables in the new terminal window.

# Launch a Dataflow Pipeline
# To navigate to the code directory in the new terminal, run the following command:

# cd ~/training-data-analyst/courses/streaming/process/sandiego
# Copied!
# To review the script using nano, run the following command:

# nano run_oncloud.sh
# Copied!
# Do not modify the code.

# This script takes three required arguments to run a Dataflow job:

# Project ID
# Cloud Storage bucket name
# Java classname
# optional fourth argument for options
# In the next steps, you use the --bigtable option to direct the Dataflow pipeline to write data into Bigtable.

# To exit nano, press CTRL+X.

# To launch the Dataflow pipeline to read from Pub/Sub and write into Bigtable, run the following command:

# ./run_oncloud.sh $DEVSHELL_PROJECT_ID $BUCKET CurrentConditions --bigtable
# Copied!
# When the pipeline has been launched successfully, you will see a message similar to the following:

# [INFO] ------------------------------------------------------------------------
# [INFO] BUILD SUCCESS
# [INFO] ------------------------------------------------------------------------
# [INFO] Total time: 01:09 min
# [INFO] Finished at: 2022-06-01T17:21:29+00:00
# [INFO] Final Memory: 60M/220M
# [INFO] ------------------------------------------------------------------------
# Explore the Dataflow pipeline
# In the Google Cloud console, on the Navigation menu (nav-menu.png), under Analytics, click Dataflow > Jobs.

# Click on the new pipeline job name.

# Locate the write:cbt step in the pipeline graph, and to see the details of the writer, click on the down arrow next to write:cbt.

# Click on the provided writer, and review the details provided within Step info.

# Click Check my progress to verify the objective.
# Launch a Dataflow pipeline.

# Task 4. Verify streaming data loaded into Bigtable
# In a previous task, you already configured the .cbtrc configuration file in Cloud Shell. You can now run a simple cbt CLI command to query the first five records of the table.

# To see the first five rows of data and their values in the lane column family, run the following command:

# cbt read current_conditions count=5 \
#     columns="lane:.*"
# Copied!
# The output is structured as follows:

# ----------------------------------------------
# ROW KEY
#  COLUMN_FAMILY:COLUMN_QUALIFIER       @ TIMESTAMP
#     VALUE
# The output values will resemble the following:

# ----------------------------------------------
# 15#S#1#9223370811310975807
#   lane:direction                           @ 1970/01/15-04:25:43.800000
#     "S"
#   lane:highway                             @ 1970/01/15-04:25:43.800000
#     "15"
#   lane:lane                                @ 1970/01/15-04:25:43.800000
#     "1.0"
#   lane:latitude                            @ 1970/01/15-04:25:43.800000
#     "32.706184"
#   lane:longitude                           @ 1970/01/15-04:25:43.800000
#     "-117.120565"
#   lane:sensorId                            @ 1970/01/15-04:25:43.800000
#     "32.706184,-117.120565,15,S,1"
#   lane:speed                               @ 1970/01/15-04:25:43.800000
#     "71.4"
#   lane:timestamp                           @ 1970/01/15-04:25:43.800000
#     "2008-11-01 12:50:00"
# Task 5. Stop streaming jobs and delete Bigtable data
# In this final task, you stop the streaming data job and delete the Bigtable instance and table using commands.

# Stop simulated streaming data
# In the first SSH terminal with the streaming data simulator, to stop the simulation, press CONTROL+C.

# Stop the Dataflow job
# In the Google Cloud console, on the Navigation menu (nav-menu.png), click Dataflow > Jobs.

# Click on the pipeline job name.

# Click Stop.

# Select Cancel, and then click Stop job.

# Delete a Bigtable table and instance
# To delete the Bigtable table, in Cloud Shell, run the following command:

# cbt deletetable current_conditions
# Copied!
# To delete the Bigtable instance, run the following command:

# gcloud bigtable instances delete sandiego
# Copied!
# If prompted to confirm, type Y.

# Click Check my progress to verify the objective.
# Stop streaming jobs and delete Bigtable data.

# Congratulations!
# You have now used commands to create a new Bigtable instance and table, streamed data into the table using Dataflow, and confirmed that the data was successfully streaming into Bigtable by running simple cbt CLI commands. You completed the lab by using commands to stop the job and delete the Bigtable table and instance.

# Finish your quest
# This self-paced lab is part of the Manage Bigtable on Google Cloud quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Take your next lab
# Continue your quest with GSP1056 Monitoring and Managing Bigtable Health and Performance.

# Manual Last Updated: June 30, 2022
# Lab Last Tested: June 30, 2022
# Copyright 2022 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
