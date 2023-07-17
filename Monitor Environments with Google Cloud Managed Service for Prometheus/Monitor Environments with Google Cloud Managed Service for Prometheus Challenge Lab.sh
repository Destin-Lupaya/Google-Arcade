# Monitor Environments with Google Cloud Managed Service for Prometheus: Challenge Lab
# 1 hour 30 minutes
# 5 Credits
# GSP364
# Google Cloud self-paced labs logo

# Introduction
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students enrolled in the Monitor Environments with Google Cloud managed Service for Prometheus quest. Are you ready for the challenge?

# Lab Objectives
# In this lab, you will learn how to:

# Deploy the Managed Service for Prometheus

# Create a self managed data collection for scraping metrics

# Deploy an application to query metrics

# Prerequisites
# This lab is recommended for students who have completed labs GSP1025 (Migrate Existing Prometheus Monitoring Workloads to Google Cloud) and GSP1027 (Reduce Costs for the Managed Service for Prometheus).

# Task 1. Deploy a GKE cluster
# Task 2. Deploy a managed collection
# Note: You will need to utilize a flag when issuing the command to create the GKE cluster in order to enable the Managed Service for Prometheus.
# Note: You should use the setup and operator manifest files to complete this challenge. For more information, refer to GoogleCloudPlatform/prometheus-engine.
# Task 3. Deploy an example application
# Note: Use the following manifest: example-app.yaml
# Check if prometheus has been deployed
# Task 4. Filter exported metrics
# Add the following to operator config to filter metrics

# collection:
#   filter:
#     matchOneOf:
#     - '{job="prom-example"}'
#     - '{__name__=~"job:.+"}'
# Copied!
# Create a config.yaml file

# vi op-config.yaml
# Copied!
# Copy the contents of operatorconfig inside the config.yaml file

# Upload the config file you created to verify.

# export PROJECT=$(gcloud config get-value project)
# Copied!
# gsutil mb -p $PROJECT gs://$PROJECT
# Copied!
# gsutil cp op-config.yaml gs://$PROJECT
# Copied!
# gsutil -m acl set -R -a public-read gs://$PROJECT
# Copied!
# Check if metrics filter has been applied
# Congratulations
# In this lab you have deployed Prometheus and a example application. Then you have applied a filter to the exported metrics.

# Monitor Environments with Google Cloud Managed Service for Prometheus Skill Badge

# Earn your next skill badge
# This self-paced lab is part of the Monitor Environments with Google Cloud managed Service for Prometheus skill badge quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: June 13, 2022

# Lab Last Tested: March 17, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
