# Connect an App to a Cloud SQL for PostgreSQL Instance
# 1 hour
# 1 Credit
# GSP919
# Google Cloud self-paced labs logo

# Overview
# This lab guides you through connecting an application to a Cloud SQL for PostgreSQL database.

# In this lab you will create a Kubernetes cluster and deploy a simple application to that cluster. You will then connect the application to the supplied Cloud SQL for PostgreSQL database instance and confirm that it is able to write to and read from it.

# You must create or configure the services and resources that are specified for each task and you must follow any detailed instructions that are provided in order to successfully complete each task.

# Objectives
# In this lab, you learn to configure an application to access a Cloud SQL for PostgreSQL database.

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
# Task 1. Initialize APIs and create a Cloud IAM service account
# To complete this task you must initialize the APIs and create an IAM service account that will be used to allow your application to connect to the Cloud SQL database.

# Enable the APIs
# You must enable the required APIs for this lab. You will build and push a container to the Artifact Registry in a later task, so you must enable the Artifact Registry API first.

# In Cloud Shell, run:
# gcloud services enable artifactregistry.googleapis.com
# Copied!
# Create a Service Account for Cloud SQL
# You need to configure IAM service account credentials for the application that you will deploy later. The service account must be bound to a role that allows it to create and access Cloud SQL databases.

# In Cloud Shell, create a Service Account and bind it to the Cloud SQL admin role in the lab project:
# export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
# export CLOUDSQL_SERVICE_ACCOUNT=cloudsql-service-account
# gcloud iam service-accounts create $CLOUDSQL_SERVICE_ACCOUNT --project=$PROJECT_ID
# gcloud projects add-iam-policy-binding $PROJECT_ID \
#     --member="serviceAccount:$CLOUDSQL_SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com"  \
#     --role="roles/cloudsql.admin"
# Copied!
# In Cloud Shell, create and export keys to a local file:
# gcloud iam service-accounts keys create $CLOUDSQL_SERVICE_ACCOUNT.json \
#     --iam-account=$CLOUDSQL_SERVICE_ACCOUNT@$PROJECT_ID.iam.gserviceaccount.com \
#     --project=$PROJECT_ID
# Copied!
# The file will be saved to your home folder in Cloud Shell.

# Click Check my progress to verify the objective.
# Create an IAM service account for Cloud SQL.

# Task 2. Deploy a lightweight GKE application
# In this task you will create a Kubernetes cluster and deploy a lightweight Google Kubernetes Engine (GKE) application on that cluster. You will configure the application to have access to the supplied Cloud SQL instance.

# The application provided is a simple Flask-SQLAlchemy web application called gMemegen. It creates memes by supplying a set of photographs and capturing header and footer text, storing them in the database and rendering the meme to a local folder. It runs on a single pod with two containers; one for the application and one for the Cloud SQL Auth Proxy deployed in the side-car pattern.

# A load balancer will marshal requests between the app and the database through the side-car. This load balancer will expose an external Ingress IP address through which you will access the app in your browser.

# Create a Kubernetes cluster
# In this step, you will create a minimal Kubernetes cluster. The cluster will take a couple of minutes to be deployed.

# In Cloud Shell, create a minimal Kubernetes cluster as follows:
# ZONE=us-central1-a
# gcloud container clusters create postgres-cluster \
#     --zone=$ZONE --num-nodes=2
# Copied!
# Create Kubernetes secrets for database access
# In this step you will create a pair of Kubernetes secrets containing the credentials that are needed to connect to the Cloud SQL instance and database.

# In Cloud Shell, run:
# kubectl create secret generic cloudsql-instance-credentials \
#     --from-file=credentials.json=$CLOUDSQL_SERVICE_ACCOUNT.json
    
# kubectl create secret generic cloudsql-db-credentials \
#     --from-literal=username=postgres \
#     --from-literal=password=supersecret! \
#     --from-literal=dbname=gmemegen_db
# Copied!
# Download and build the GKE application container
# Before you can deploy the gMemegen application to your GKE cluster you need to build the container and push it to a repository.

# In Cloud Shell, download the provided application and change to the created folder:
# gsutil -m cp -r gs://cloud-training/gsp919/gmemegen .
# cd gmemegen
# Copied!
# Create environment variables for the region, project ID and Artifact Registry repository:
# export REGION=us-central1
# export PROJECT_ID=$(gcloud config list --format 'value(core.project)')
# export REPO=gmemegen
# Copied!
# Configure Docker authentication for the Artifact Registry:
# gcloud auth configure-docker ${REGION}-docker.pkg.dev
# Copied!
# Enter Y if you are asked for confirmation.

# Create the Artifact Registry repository:
# gcloud artifacts repositories create $REPO \
#     --repository-format=docker --location=$REGION
# Copied!
# Build a local docker image:
# docker build -t ${REGION}-docker.pkg.dev/${PROJECT_ID}/gmemegen/gmemegen-app:v1 .
# Copied!
# For the purposes of this lab, you may ignore the warning about running 'pip' as the 'root' user, although you should note that, in general, especially when working on your local machine, it is best practice to use a virtual environment.

# Push the image to the Artifact Registry:
# docker push ${REGION}-docker.pkg.dev/${PROJECT_ID}/gmemegen/gmemegen-app:v1
# Copied!
# Configure and deploy the GKE application
# You must modify the Kubernetes deployment manifest for the gMemegen application to point at the correct container and configure the Cloud SQL Auth Proxy side-car with the connection string for the Cloud SQL PostgreSQL instance.

# The instructions explain how to edit the file using the Cloud Shell Editor, but if you prefer you can use another editor, such as vi or nano, from Cloud Shell for these steps.

# On the Cloud Shell menu bar, click Open editor and then click Open in a new window to open the Cloud Shell Editor in a new tab.

# Navigate the Explorer panel on the left hand side, expanding the gmemegen folder and then selecting gmemegen_deployment.yaml to edit the file.

# On line 33, in the image attribute, replace ${PROJECT_ID} with your Qwiklabs Project ID.

# On line 60, replace ${PROJECT_ID} with your Qwiklabs Project ID, as follows:

# "-instances=${PROJECT_ID}:us-central1:postgres-gmemegen=tcp:5432",

# A valid connection name is of the format PROJECT_ID:REGION:CLOUD_SQL_INSTANCE_ID. Replace only ${PROJECT_ID} and ensure that the line still ends with :us-central1:postgres-gmemegen=tcp:5432. To confirm that the connection name is correct, in the Cloud Console, navigate to Databases > SQL, select the postgres-gmemegen instance and compare with the Connection name in the Overview pane.

# Save your changes by selecting File > Save from the Cloud Shell Editor menu.

# In the Cloud console click the Open Terminal to re-open Cloud Shell. You may need to resize the Terminal window by dragging down the handle at the centre top of the menu bar, in order to see your Cloud Console window above.

# In Cloud Shell, deploy the application by running the following command:

# kubectl create -f gmemegen_deployment.yaml
# Copied!
# In Cloud Shell, check that the deployment was successful by running the following command:
# kubectl get pods
# Copied!
# It may take a minute or so for the pods to start up, because they need to pull the image from the repository. Repeat the above command until you see a pod, with 2 containers, with status Running.

# Click Check my progress to verify the objective.
# Deploy a lightweight GKE application.

# Task 3. Connect the GKE application to an external load balancer
# In this task you will create a load balancer to marshal requests between the containers in your GKE pods and access the application using its external IP address from your browser.

# Create a load balancer to make your GKE application accessible from the web
# In this step you will create a Kubernetes load balancer service that will provide your application with a public IP address.

# In Cloud Shell, create a load balancer for the application:
# kubectl expose deployment gmemegen \
#     --type "LoadBalancer" \
#     --port 80 --target-port 8080
# Copied!
# Test the application to generate some data
# In this step you will access the gMemegen application from your web browser.

# The application has a very simple interface. It launches to the application home page, which displays 6 candidate images for making memes. You can select an image by clicking on it.

# The Create Meme page is displayed, where you enter two items of text, to be displayed at the top and bottom of the image. Clicking Submit renders the meme and displays it. The interface provides no navigation from the completed meme page. You will have to use the browser's back button to return to the home page.

# There are two other pages, Recent and Random, which display a set of recently generated memes and a random meme, respectively. Generating memes and navigating the UI will generate database activity which you can view in the logs as described below.

# Wait for the load balancer to expose an external IP, which you can retrieve as follows:

# In Cloud Shell, copy the external IP address attribute of the LoadBalancer Ingress from the output of:
# kubectl describe service gmemegen
# Copied!
# Output:

# Name:                     gmemegen
# Namespace:                default
# Labels:                   app=gmemegen
# Annotations:              
# Selector:                 app=gmemegen
# Type:                     LoadBalancer
# IP Families:              
# IP:                       10.3.240.201
# IPs:                      10.3.240.201
# LoadBalancer Ingress:     34.67.122.203
# Port:                       80/TCP
# TargetPort:               8080/TCP
# NodePort:                   31837/TCP
# Endpoints:                10.0.0.7:8080
# Session Affinity:         None
# External Traffic Policy:  Cluster
# Events:
#   Type    Reason                Age   From                Message
#   ----    ------                ----  ----                -------
#   Normal  EnsuringLoadBalancer  85s   service-controller  Ensuring load balancer
#   Normal  EnsuredLoadBalancer   36s   service-controller  Ensured load balancer
# It will take a minute or so for the LoadBalancer Ingress attribute to be included in the output (see above), so repeat the command until it is there before performing the next step.

# In a browser, navigate to the load balancer's Ingress IP address.
# You can create a clickable link to the external IP address of the load balancer in Cloud Shell using the following commands:

# export LOAD_BALANCER_IP=$(kubectl get svc gmemegen \
#     -o=jsonpath='{.status.loadBalancer.ingress[0].ip}' -n default)
# echo gMemegen Load Balancer Ingress IP: http://$LOAD_BALANCER_IP
# Copied!
# Click the link in Cloud Shell and you will see the gMemegen application running in a new tab in your browser.

# Create a meme as follows:

# On the Home page, click on one of the presented images.
# Enter text in the Top and Bottom text boxes.
# Click the Submit button.
# Your new meme is displayed.

# Meme for GKE app connected to cloud SQL.

# To create more memes, use the browser's back buttton to navigate to the home page.

# To view existing memes, click Recent or Random in the application menu. (Note that Random opens a new browser tab)

# In Cloud Shell, view the application’s activity by running the following:

# POD_NAME=$(kubectl get pods --output=json | jq -r ".items[0].metadata.name")
# kubectl logs $POD_NAME gmemegen | grep "INFO"
# Copied!
# This queries the logs from the gmemegen container and will display the activity of the application on the pod, including the SQL statements, which are logged to stderr as they are executed.

# Click Check my progress to verify the objective.
# Connect the GKE application to an external load balancer.

# Task 4. Verify full read/write capabilities of application to database
# In this task you will verify that the application is able to write to and read from the database.

# Connect to the database and query an application table
# In this step you will connect to the Cloud SQL instance by running PL/SQL in Cloud Shell.

# In Google Cloud Console, navigate to Databases > SQL and select the postgres-gmemegen instance.

# In the Overview pane , scroll down to Connect to this instance and click the Open Cloud Shell button.

# Run the auto-populated command in Cloud Shell.

# When prompted, enter the password: supersecret!

# At the postgres=> prompt enter the following command to select the gmemegen_db database:

# \c gmemegen_db
# Copied!
# When prompted, enter the password: supersecret!

# At the gmemegen_db=> prompt enter:

# select * from meme;
# Copied!
# This will display a row for each meme you have generated through the gMemegen app.

# Click Check my progress to verify the objective.
# Verify full read/write capabilities of the application to its database.

# Congratulations
# You have completed this lab.

# Finish your quest
# This self-paced lab is part of the Manage PostgreSQL Databases on Cloud SQL quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in a quest and get immediate completion credit if you've taken this lab. Refer to the Google Cloud Skills Boost catalog for all available quests.

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

# Manual Last Updated: October 17, 2022

# Lab Last Tested: December 02, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.