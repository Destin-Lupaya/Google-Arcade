# Reduce Costs for the Managed Service for Prometheus
# 1 hour 30 minutes
# 1 Credit
# GSP1027
# Google Cloud self-paced labs logo

# Overview
# In this lab, you will explore cost control mechanisms when utilizing the Managed Service for Prometheus on Google Cloud.

# The Google Cloud Managed Service for Prometheus charges for the number of samples ingested into Cloud Monitoring and for read requests to the Monitoring API. The number of samples ingested is the primary contributor to your cost.

# Objectives
# In this lab, you will learn how to:

# Understand how to reduce the costs associated with using the Managed Service for Prometheus

# Deploy GMP in a GKE cluster as well as a python application

# Reduce the number of time series metrics you send to the managed service by filtering the metric data generated

# Reduce the number of samples collected by changing the scraping interval

# Task 1. Deploy GKE cluster
# Deploy a basic GKE cluster to setup lab:

# gcloud beta container clusters create gmp-cluster --num-nodes=1 --zone us-central1-f --enable-managed-prometheus
# Copied!
# gcloud container clusters get-credentials gmp-cluster --zone=us-central1-f
# Copied!
# kubectl create ns gmp-system
# Copied!
# Task 2. Deploy managed collection
# Configure a PodMonitoring resource
# The following manifest defines a PodMonitoring resource, prom-example, in the gmp-test namespace. The resource uses a Kubernetes label selector to find all pods in the namespace that have the label app with the value prom-example. The matching pods are scraped on a port named metrics, every 30 seconds, on the /metrics HTTP path.

# apiVersion: monitoring.googleapis.com/v1
# kind: PodMonitoring
# metadata:
#   namespace: gmp-system
#   name: collector
#   labels:
#     app.kubernetes.io/name: collector
#     app.kubernetes.io/part-of: google-cloud-managed-prometheus
# spec:
#   selector:
#     matchLabels:
#       app.kubernetes.io/name: collector
#   endpoints:
#   - port: prom-metrics
#     interval: 10s
#   - port: cfg-rel-metrics
#     interval: 10s
# Copied!
# To apply this resource, run the following command:
# kubectl -n gmp-system apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/main/examples/self-pod-monitoring.yaml
# Copied!
# Your managed collector is now scraping the matching pods.

# Deploy the example application
# The managed service provides a manifest for an example application that emits Prometheus metrics on its metrics port. The application uses three replicas.

# To deploy the example application, run the following command:

# kubectl -n gmp-system apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/main/examples/example-app.yaml
# Copied!
# Check if prometheus has been deployed
# Task 3. Cloud Console for Monitoring
# To view your Managed Service for Prometheus data as Cloud Monitoring time series, you can use Metrics Explorer. To configure Metrics Explorer to display metrics, do the following:

# In the Google Cloud Console, go to Monitoring.

# In the Monitoring navigation pane, click Metrics Explorer icon Metrics Explorer.

# Specify the data to appear on the chart. You can use the MQL tab or the Configuration tab.

# To use the MQL tab, do the following:

# a. Select the MQL tab.

# b. Enter the following query:

# fetch prometheus_target::prometheus.googleapis.com/up/gauge
# Copied!
# c. Click Run Query.

# To use the Configuration tab, do the following:

# a. Select the Configuration tab.

# b. In the Resource & Metric field, type "up/" to filter the list, then select Prometheus Target > Up > prometheus/up/gauge.

# c. Then select Apply.

# Task 4. Populate a Graph
# Go to Cloud Monitoring > Metrix Explorer and select Code Editor.

# Choose the syntax mode PromQL and run the query below by clicking Run Query to see metrics:

# go_memstats_heap_alloc_bytes
# Copied!
# This will populate a graph similar to the image below when selected.

# promql_query

# Task 5. Filter exported metrics
# If you collect a lot of data, you might want to prevent some time series from being sent to Managed Service for Prometheus to keep costs down.

# To filter exported metrics, you can configure a set of PromQL series selectors in the OperatorConfig resource. A time series is exported to Managed Service for Prometheus if it satisfies at least one of the selectors.

# Open the OperatorConfig resource for editing:

# kubectl -n gmp-public edit operatorconfig config
# Copied!
# After the apiVersion line, press "i" to go into insert mode. Go to the final line and press enter to go to a newline. Ensure there are no indents at the beginning of the line. Then paste the following:

# collection:
#   filter:
#     matchOneOf:
#     - '{job="prom-example"}'
#     - '{__name__=~"job:.+"}'
# Copied!
# The file should look like the following:

# Operator config code

# To save the file and exit press "Esc" then type ":wq" then enter.
# This addition causes only metrics for the "prometheus" job as well as metrics produced by recording rules that aggregate to the job level—when following naming best practices—to be exported. Samples for all other time series are filtered out. By default, no selectors are specified and all time series are exported.

# The filter.matchOneOf configuration section has the same semantics as the match[] parameters for Prometheus federation.

# Create a config.yaml file:

# vi op-config.yaml
# Copied!
# Copy the following into the config.yaml file:

# apiVersion: monitoring.googleapis.com/v1alpha1
# collection:
#   filter:
#     matchOneOf:
#     - '{job="prom-example"}'
#     - '{__name__=~"job:.+"}'
# kind: OperatorConfig
# metadata:
#   annotations:
#     components.gke.io/layer: addon
#     kubectl.kubernetes.io/last-applied-configuration: |
#       {"apiVersion":"monitoring.googleapis.com/v1alpha1","kind":"OperatorConfig","metadata":{"annotations":{"components.gke.io/layer":"addon"},"labels":{"addonmanager.kubernetes.io/mode":"Reconcile"},"name":"config","namespace":"gmp-public"}}
#   creationTimestamp: "2022-03-14T22:34:23Z"
#   generation: 1
#   labels:
#     addonmanager.kubernetes.io/mode: Reconcile
#   name: config
#   namespace: gmp-public
#   resourceVersion: "2882"
#   uid: 4ad23359-efeb-42bb-b689-045bd704f295
# Copied!
# Upload the config file you created to verify:

# export PROJECT=$(gcloud config get-value project)
# Copied!
# gsutil mb -p $PROJECT gs://$PROJECT
# Copied!
# gsutil cp op-config.yaml gs://$PROJECT
# Copied!
# gsutil -m acl set -R -a public-read gs://$PROJECT
# Copied!
# Check if metrics filter has been applied
# Task 6. Run the query
# Go back to the PromQL Query editor. In the top search type "Managed Prometheus" and run the query "up" and select RUN QUERY.

# Task 7. Monitor the app
# Increase the scrape interval for the PodMonitoring resource created to monitor the example app:

# kubectl -n gmp-system edit podmonitoring/prom-example
# Copied!
# Change the interval in the file to 60s from 30s then save file. Press "Esc" then type ":wq" then enter.

# Create a prom-example-config.yaml file you created to verify:

# vi prom-example-config.yaml
# Copied!
# Copy the following into the file:

# apiVersion: monitoring.googleapis.com/v1alpha1
# kind: PodMonitoring
# metadata:
#   annotations:
#     kubectl.kubernetes.io/last-applied-configuration: |
#       {"apiVersion":"monitoring.googleapis.com/v1alpha1","kind":"PodMonitoring","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"prom-example"},"name":"prom-example","namespace":"gmp-test"},"spec":{"endpoints":[{"interval":"30s","port":"metrics"}],"selector":{"matchLabels":{"app":"prom-example"}}}}
#   creationTimestamp: "2022-03-14T22:33:55Z"
#   generation: 1
#   labels:
#     app.kubernetes.io/name: prom-example
#   name: prom-example
#   namespace: gmp-test
#   resourceVersion: "2648"
#   uid: c10a8507-429e-4f69-8993-0c562f9c730f
# spec:
#   endpoints:
#   - interval: 60s
#     port: metrics
#   selector:
#     matchLabels:
#       app: prom-example
# status:
#   conditions:
#   - lastTransitionTime: "2022-03-14T22:33:55Z"
#     lastUpdateTime: "2022-03-14T22:33:55Z"
#     status: "True"
#     type: ConfigurationCreateSuccess
#   observedGeneration: 1
# Copied!
# export PROJECT=$(gcloud config get-value project)
# Copied!
# gsutil cp prom-example-config.yaml gs://$PROJECT
# Copied!
# gsutil -m acl set -R -a public-read gs://$PROJECT
# Copied!
# Check if scrape interval has been changed
# This completes the lab.

# Congratulations
# In this lab, you deployed prometheus and an example application. Then, you applied a metrics filter and changed the scraping interval to reduce the costs associated with ingesting metrics using the Google Managed Prometheus service.

# Finish your quest
# This self-paced lab is part of the Monitor Environments with Google Cloud managed Service for Prometheus skill badge quest.A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit. Refer to the Google Cloud Skills Boost catalog for all available quests.

# Next steps / Learn more
# You can read more about Google Cloud Managed Service for Prometheus.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: October 14, 2022

# Lab Last Tested: June 2, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# A Tour of Google Cloud Sustainability