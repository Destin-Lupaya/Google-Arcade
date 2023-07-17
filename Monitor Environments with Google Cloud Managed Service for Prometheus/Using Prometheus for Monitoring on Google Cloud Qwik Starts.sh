# Using Prometheus for Monitoring on Google Cloud: Qwik Start
# 1 hour
# 1 Credit
# GSP1024
# Google Cloud self-paced labs logo

# Overview
# In this lab, you'll set up a Google Kubernetes Engine cluster, then deploy the Managed Service for Prometheus to ingest metrics from a simple application.

# Managed Service for Prometheus is Google Cloud's fully managed storage and query service for Prometheus metrics. This service is built on top of Monarch, the same globally scalable data store as Cloud Monitoring.

# A thin fork of Prometheus replaces existing Prometheus deployments and sends data to the managed service with no user intervention. This data can then be queried by using PromQL through the Prometheus Query API supported by the managed service and by using the existing Cloud Monitoring query mechanisms.

# Objectives
# Deploy the Managed Service for Prometheus to a GKE cluster

# Deploy a Python application to monitor

# Create a Cloud Monitoring dashboard to view metrics collected

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
# Task 1. Setup a Google Kubernetes Engine cluster
# Run the following command to deploy a standard GKE cluster, which will prompt you to authorize and enable the GKE API:

# gcloud beta container clusters create gmp-cluster --num-nodes=1 --zone us-central1-f --enable-managed-prometheus
# Copied!
# The cluster will take a couple of minutes to create. Wait for the creation to finish then proceed to the next step.

# Run the following command to authenticate to the cluster:

# gcloud container clusters get-credentials gmp-cluster --zone us-central1-f
# Copied!
# Task 2. Deploy the Prometheus service
# Run the following command to create a namespace to do the work in:

# kubectl create ns gmp-test
# Copied!
# Check if Prometheus has been deployed
# Task 3. Deploy the application
# Deploy a simple application which emits metrics at the /metrics endpoint:

# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/kyleabenson/flask_telemetry/master/gmp_prom_setup/flask_deployment.yaml
# Copied!
# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/kyleabenson/flask_telemetry/master/gmp_prom_setup/flask_service.yaml
# Copied!
# Verify that this simple Python Flask app is serving metrics with the following command:

# url=$(kubectl get services -n gmp-test -o jsonpath='{.items[*].status.loadBalancer.ingress[0].ip}')
# Copied!
# curl $url/metrics
# Copied!
# Output will look like below:

# # HELP flask_exporter_info Multiprocess metric
# # TYPE flask_exporter_info gauge
# flask_exporter_info{version="0.18.5"} 1.0
# Tell Prometheus where to begin scraping the metrics from by applying the PodMonitoring file:

# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/kyleabenson/flask_telemetry/master/gmp_prom_setup/prom_deploy.yaml
# Copied!
# Before finishing up here, generate some load on the application with a really simple interaction with the app:

# timeout 120 bash -c -- 'while true; do curl $(kubectl get services -n gmp-test -o jsonpath='{.items[*].status.loadBalancer.ingress[0].ip}'); sleep $((RANDOM % 4)) ; done'
# Copied!
# This will run for 2 minutes, and when done, you can create a visualization of what this looks like!

# Check if Flask application has been deployed
# Task 4. Observing the app via metrics
# In this last section, quickly use gcloud to deploy a custom monitoring dashboard that shows the metrics from this application in a line chart.

# Be sure to copy the entirety of this code block:

# gcloud monitoring dashboards create --config='''
# {
#   "category": "CUSTOM",
#   "displayName": "Prometheus Dashboard Example",
#   "mosaicLayout": {
#     "columns": 12,
#     "tiles": [
#       {
#         "height": 4,
#         "widget": {
#           "title": "prometheus/flask_http_request_total/counter [MEAN]",
#           "xyChart": {
#             "chartOptions": {
#               "mode": "COLOR"
#             },
#             "dataSets": [
#               {
#                 "minAlignmentPeriod": "60s",
#                 "plotType": "LINE",
#                 "targetAxis": "Y1",
#                 "timeSeriesQuery": {
#                   "apiSource": "DEFAULT_CLOUD",
#                   "timeSeriesFilter": {
#                     "aggregation": {
#                       "alignmentPeriod": "60s",
#                       "crossSeriesReducer": "REDUCE_NONE",
#                       "perSeriesAligner": "ALIGN_RATE"
#                     },
#                     "filter": "metric.type=\"prometheus.googleapis.com/flask_http_request_total/counter\" resource.type=\"prometheus_target\"",
#                     "secondaryAggregation": {
#                       "alignmentPeriod": "60s",
#                       "crossSeriesReducer": "REDUCE_MEAN",
#                       "groupByFields": [
#                         "metric.label.\"status\""
#                       ],
#                       "perSeriesAligner": "ALIGN_MEAN"
#                     }
#                   }
#                 }
#               }
#             ],
#             "thresholds": [],
#             "timeshiftDuration": "0s",
#             "yAxis": {
#               "label": "y1Axis",
#               "scale": "LINEAR"
#             }
#           }
#         },
#         "width": 6,
#         "xPos": 0,
#         "yPos": 0
#       }
#     ]
#   }
# }
# '''
# Copied!
# Once created, navigate to Monitoring > Dashboards to see the newly created Prometheus Dashboard Example. Click through below to see how to get there.
# Check if dashboard is created
# Congratulations
# You've seen the basics of deploying a GKE app with Prometheus Metrics and creating a Cloud Monitoring Dashboard from it.

# Finish your quest
# This self-paced lab is part of the Monitor Environments with Google Cloud managed Service for Prometheus quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# Next steps / Learn more
# If you'd like to learn more, check out the Prometheus documentation and look for the deploying self-managed collection.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manuallast updated: October 4, 2022

# Lab last tested: August 16, 2022

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

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are