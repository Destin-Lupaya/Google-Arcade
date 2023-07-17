# Migrate Existing Prometheus Monitoring Workloads to Google Cloud
# 1 hour 30 minutes
# 1 Credit
# GSP1025
# Google Cloud self-paced labs logo

# Overview
# In this lab, you will explore how to use Managed Service for Prometheus in a self-deployed data collection mode. You can also utilize managed data collection as well.

# With self-deployed data collections, you manage your Prometheus installation as usual. The only difference from upstream Prometheus is that you run the Managed Service for Prometheus drop-in replacement binary instead of the upstream Prometheus binary.

# You can find more information on considerations to make when choosing a managed vs. self-managed data collection at the following documentation link: Data collection with Managed Service for Prometheus.

# Objectives
# In this lab, you will learn how to:

# Deploy the Managed Service for Prometheus

# Create a self managed data collection for scraping metrics

# Understand considerations to make when using managed vs. self-managed data collections

# Utilize Grafana to query Prometheus metrics data

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
# Task 1. Deploy GKE cluster
# Deploy a basic GKE cluster to setup lab:

# gcloud container clusters create gmp-cluster --num-nodes=3 --zone=us-central1-c
# Copied!
# gcloud container clusters get-credentials gmp-cluster --zone=us-central1-c
# Copied!
# 2.. Create namespace gmp-test:

# kubectl create ns gmp-test
# Copied!
# Task 2. Deploy application
# This example application emits Prometheus metrics on its metrics port. The application uses three replicas.

# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/v0.4.3-gke.0/examples/example-app.yaml
# Copied!
# Task 3. Deploy Prometheus
# Run the following command to ingest a metric:

# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/v0.4.3-gke.0/examples/prometheus.yaml
# Copied!
# kubectl -n gmp-test get pod
# Copied!
# If the deployment was successful then you should see a similar output to the following. Wait for the status of all pods to be Running.

# NAME                            READY   STATUS    RESTARTS   AGE
# prom-example-84c6f547f5-fglbr   1/1     Running   0          5m
# prom-example-84c6f547f5-jnjp4   1/1     Running   0          5m
# prom-example-84c6f547f5-sqdww   1/1     Running   0          5m
# prometheus-test-0               2/2     Running   1          3m
# Task 4. Prometheus metrics
# Run the following commands to verify that you can see metrics by using the prometheus metrics API.

# Set environment variable:

# export PROJECT_ID=$(gcloud config get-value project)
# Copied!
# Use the following curl command:

# curl https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/v0.4.3-gke.0/examples/frontend.yaml |
# sed "s/\$PROJECT_ID/$PROJECT_ID/" | kubectl apply -n gmp-test -f -
# Copied!
# Forward the port to see the Prometheus metrics UI:

# kubectl -n gmp-test port-forward svc/frontend 9090
# Copied!
# In cloud shell editor use the web preview icon to change the port to 9090 then view the metrics.
# Check if Prometheus is deployed
# Check if metric appears
# Task 5. Deploy Grafana
# Note: Open a new Cloud Shell tab (+) to run the below commands.
# Clone kube-prometheus repo:

# git clone https://github.com/prometheus-operator/kube-prometheus.git
# Copied!
# Change directory to the kube-prometheus:

# cd kube-prometheus
# Copied!
# Run the following commands to deploy an ephemeral Grafana deployment:

# kubectl -n gmp-test apply -f https://raw.githubusercontent.com/GoogleCloudPlatform/prometheus-engine/v0.4.3-gke.0/examples/grafana.yaml
# Copied!
# Forward the port to see the Grafana UI:
# kubectl -n gmp-test port-forward svc/grafana 3001:3000
# Copied!
# In cloud shell editor use the web preview icon to change the port to 3001 then view the grafana dashboard.

# Task 6. Grafana
# Login to Grafana using the username admin and password admin.

# Click Skip when asked to enter new password.

# Task 7. Configure data source
# To query Managed Service for Prometheus in Grafana by using the Prometheus UI as the authentication proxy, you must add new data source to Grafana. To add a data source for the managed service, do the following:

# Go to your Grafana deployment, for example, by browsing to the URL http://localhost:3000 to reach the Grafana welcome page.

# Select Configuration from the main Grafana menu, then select Data Sources.

# Grafana welcome page displaying the selected Data Sources option in the Configuration menu

# Select Add data source, and select Prometheus as the time series database.
# The Add data source page

# In the URL field of the HTTP pane, enter the URL of the Managed Service for Prometheus frontend service. If you configured the Prometheus UI to run on port 9090, then the service URL for this field is http://frontend.gmp-test.svc:9090.

# In the HTTP Method field, select GET.

# The Data Sources/Managed Service for Prometheus page

# Click Save & Test, and look for the message "Data source is working".
# The aforementioned message displayed in the UI

# Task 8. Grafana chart
# You can now create Grafana dashboards using the new data source. You can also redirect existing dashboards to the new data source. The following screenshot shows a Grafana chart that displays the up metric.

# Grafana chart on the New dashboard/Edit Panel page

# Check if metric appears
# Congratulations
# In this lab you deploy the Managed Service for Prometheus. Create a self managed data collection for scraping metrics and utilize Grafana to query prometheus metrics data.

# Finish your quest
# This self-paced lab is part of the Monitor Environments with Google Cloud managed Service for Prometheus quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# End your lab