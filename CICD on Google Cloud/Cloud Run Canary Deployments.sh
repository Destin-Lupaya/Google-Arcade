# Cloud Run Canary Deployments
# 1 hour 30 minutes
# 5 Credits
# GSP1078
# Google Cloud self-paced labs logo

# Overview
# In this lab you will learn how to implement a deployment pipeline for Cloud Run that executes a progression of code from developer branches to production with automated canary testing and percentage based traffic management. It is intended for developers and DevOps engineers who are responsible for creating and managing CI/CD pipelines to Cloud Run.

# Many organizations use robust release pipelines to move code into production. Cloud Run provides unique traffic management capabilities that let you implement advanced release management techniques with little effort.

# Objectives
# Create your Cloud Run service.

# Enable developer branch.

# Implement canary testing.

# Rollout safely to production.

# Prerequisites
# This lab assumes that you have a basic understanding of Git, Cloud Run, and CI/CD pipeline concepts.

# Setup
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
# Task 1. Preparing your environment
# In Cloud Shell, create environment variables to use in this lab:
# export PROJECT_ID=$(gcloud config get-value project)
# export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
# export REGION=
# gcloud config set compute/region $REGION
# Copied!
# Enable the following APIs with the code below:

# Cloud Resource Manager

# GKE

# Cloud Source Repositories

# Cloud Build

# Container Registry

# Cloud Run

# gcloud services enable \
# cloudresourcemanager.googleapis.com \
# container.googleapis.com \
# sourcerepo.googleapis.com \
# cloudbuild.googleapis.com \
# containerregistry.googleapis.com \
# run.googleapis.com
# Copied!
# Grant the Cloud Run Admin role (roles/run.admin) to the Cloud Build service account:
# gcloud projects add-iam-policy-binding $PROJECT_ID \
# --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
# --role=roles/run.admin
# Copied!
# Grant the IAM Service Account User role (roles/iam.serviceAccountUser) to the Cloud Build service account for the Cloud Run runtime service account:

# gcloud iam service-accounts add-iam-policy-binding \
# $PROJECT_NUMBER-compute@developer.gserviceaccount.com \
# --member=serviceAccount:$PROJECT_NUMBER@cloudbuild.gserviceaccount.com \
# --role=roles/iam.serviceAccountUser
# Copied!
# If you haven't used Git in Cloud Shell previously, set the user.name and user.email values that you want to use (it's not necessary to have an existing account on GitHub):

# git config --global user.email "[YOUR_EMAIL_ADDRESS]"
# git config --global user.name "[YOUR_USERNAME]"
# Copied!
# Clone and prepare the sample repository:

# git clone https://github.com/GoogleCloudPlatform/software-delivery-workshop --branch cloudrun-progression-csr cloudrun-progression
# cd cloudrun-progression/labs/cloudrun-progression
# rm -rf ../../.git
# Copied!
# Using nano, vi or any editor replace the REGION in branch-cloudbuild.yaml , master-cloudbuild.yaml and tag-cloudbuild.yaml files with the pre-populated REGION in Step 1.

# Replace the placeholder values in the sample repository with your PROJECT_ID:

# sed "s/PROJECT/${PROJECT_ID}/g" branch-trigger.json-tmpl > branch-trigger.json
# sed "s/PROJECT/${PROJECT_ID}/g" master-trigger.json-tmpl > master-trigger.json
# sed "s/PROJECT/${PROJECT_ID}/g" tag-trigger.json-tmpl > tag-trigger.json
# Copied!
# Store the code from the sample repository in Google Source Repository:

# gcloud source repos create cloudrun-progression
# git init
# git config credential.helper gcloud.sh
# git remote add gcp https://source.developers.google.com/p/$PROJECT_ID/r/cloudrun-progression
# git branch -m master
# git add . && git commit -m "initial commit"
# git push gcp master
# Copied!
# Click Check my progress to verify the objective.

# Enable the required services, grant the desired roles and store the code in source repository
# Task 2. Creating your Cloud Run service
# In this section, you build and deploy the initial production application that you use throughout this lab.

# In Cloud Shell, build and deploy the application, including a service that requires authentication. To make a public service use the --allow-unauthenticated flag as explained in the Cloud Run documentation.

# gcloud builds submit --tag gcr.io/$PROJECT_ID/hello-cloudrun
# gcloud run deploy hello-cloudrun \
# --image gcr.io/$PROJECT_ID/hello-cloudrun \
# --platform managed \
# --region $REGION \
# --tag=prod -q
# Copied!
# The output looks similar to the following:

# Deploying container to Cloud Run service [hello-cloudrun] in project [sdw-mvp6] region [us-central1]
# ✓ Deploying new service... Done.
# ✓ Creating Revision...
# ✓ Routing traffic...
# Done.
# Service [hello-cloudrun] revision [hello-cloudrun-00001-tar] has been deployed and is serving 100 percent of traffic.
# Service URL: https://hello-cloudrun-apwaaxltma-uc.a.run.app
# The revision can be reached directly at https://prod---hello-cloudrun-apwaaxltma-uc.a.run.app
# The output includes the service URL and a unique URL for the revision. Your values will differ slightly from what's indicated here.

# After the deployment is complete, view the newly deployed service by selecting Cloud Run from the Cloud Console menu, choosing the hello-cloudrun service, and selecting the Revisions page.

# In Cloud Shell, view the authenticated service response:

# PROD_URL=$(gcloud run services describe hello-cloudrun --platform managed --region $REGION --format=json | jq --raw-output ".status.url")
# echo $PROD_URL
# curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $PROD_URL
# Copied!
# Click Check my progress to verify the objective.

# Create the CloudRun service and view the authenticated service response
# Task 3. Enabling Dynamic Developer Deployments
# In this section, you enable developers with a unique URL for development branches in Git. Each branch is represented by a URL identified by the branch name. Commits to the branch trigger a deployment, and the updates are accessible at that same URL.

# In Cloud Shell, set up the trigger:

# gcloud beta builds triggers create cloud-source-repositories --trigger-config branch-trigger.json
# Copied!
# To review the trigger, select Cloud Build from the Cloud Console menu and select Triggers.

# In Cloud Shell, create a new branch:

# git checkout -b new-feature-1
# Copied!
# Open the sample application using your favorite editor or using the Cloud Shell IDE:

# edit app.py
# Copied!
# You can now browse or modify the code with the editor. In the sample application (~/cloudrun-progression/labs/cloudrun-progression/app.py), modify line 24 to indicate v1.1 instead of v1.0:

# @app.route('/')
# def hello_world():
# return 'Hello World v1.1'
# Copied!
# To return to your terminal, click Open Terminal.

# In Cloud Shell, commit the change and push to the remote repository:

# git add . && git commit -m "updated" && git push gcp new-feature-1
# Copied!
# To review the build in progress, go back to the Cloud Build page and view the current build running on your new branch.

# After the build completes, to review the revision, go to Cloud Run from the Cloud Console menu, choose the hello-cloudrun service, and select the Revisions page.

# Click Check my progress to verify the objective.

# Set up the branch trigger and update the sample application
# In Cloud Shell, get the unique URL for this branch:

# BRANCH_URL=$(gcloud run services describe hello-cloudrun --platform managed --region $REGION --format=json | jq --raw-output ".status.traffic[] | select (.tag==\"new-feature-1\")|.url")
# echo $BRANCH_URL
# Copied!
# Access the authenticated URL:

# curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $BRANCH_URL
# Copied!
# The updated response output looks like the following:

# Hello World v1.1
# Task 4. Automating canary testing
# When code is released to production, it's common to release to a small subset of live traffic before migrating all traffic to the new code base.

# In this section, you implement a trigger that is activated when code is committed to the main branch. The trigger deploys the code to a unique canary URL and routes 10% of all live traffic to it.

# In Cloud Shell, set up the branch trigger:

# gcloud beta builds triggers create cloud-source-repositories --trigger-config master-trigger.json
# Copied!
# To review the new trigger, go to the Cloud Build > Triggers page.

# In Cloud Shell, merge the branch to the main line and push to the remote repository:

# git checkout master
# git merge new-feature-1
# git push gcp master
# Copied!
# To review the build in progress, go back to the Cloud Build page and view the current build.

# After the build completes, to review the new revision, go to Cloud Run, choose the hello-cloudrun service , and select the Revisions page. Note that 90% of the traffic is routed to prod, 10% to canary, and 0% to the branch revisions.

# Revisions page showing percentage of traffic on each revision

# Click Check my progress to verify the objective.

# Create the master trigger and build a new revision
# Review the key lines of master-cloudbuild.yaml that implement the logic for the canary deploy.
# Lines 39-44 deploy the new revision and use the tag flag to route traffic from the unique canary URL:

# gcloud run deploy ${_SERVICE_NAME} \
# --platform managed \
# --region ${_REGION} \
# --image gcr.io/${PROJECT_ID}/${_SERVICE_NAME} \
# --tag=canary \
# --no-traffic
# Line 61 adds a static tag to the revision that notes the Git short SHA of the deployment:

# gcloud beta run services update-traffic ${_SERVICE_NAME} --update-tags=sha-$SHORT_SHA=$${CANARY} --platform managed --region ${_REGION}
# Line 62 updates the traffic to route 90% to production and 10% to canary:

# gcloud run services update-traffic ${_SERVICE_NAME} --to-revisions=$${PROD}=90,$${CANARY}=10 --platform managed --region ${_REGION}
# In Cloud Shell, get the unique URL for the canary revision:

# CANARY_URL=$(gcloud run services describe hello-cloudrun --platform managed --region $REGION --format=json | jq --raw-output ".status.traffic[] | select (.tag==\"canary\")|.url")
# echo $CANARY_URL
# Copied!
# Review the canary endpoint directly:

# curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $CANARY_URL
# Copied!
# To see percentage-based responses, make a series of requests:

# LIVE_URL=$(gcloud run services describe hello-cloudrun --platform managed --region $REGION --format=json | jq --raw-output ".status.url")
# for i in {0..20};do
# curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $LIVE_URL; echo \n
# done
# Copied!
# Task 5. Releasing to Production
# After the canary deployment is validated with a small subset of traffic, you release the deployment to the remainder of the live traffic.

# In this section, you set up a trigger that is activated when you create a tag in the repository. The trigger migrates 100% of traffic to the already deployed revision based on the commit SHA of the tag. Using the commit SHA ensures the revision validated with canary traffic is the revision utilized for the remainder of production traffic.

# In Cloud Shell, set up the tag trigger:

# gcloud beta builds triggers create cloud-source-repositories --trigger-config tag-trigger.json
# Copied!
# To review the new trigger, go to the Cloud Build Triggers page in the Cloud console.

# In Cloud Shell, create a new tag and push to the remote repository:

# git tag 1.1
# git push gcp 1.1
# Copied!
# To review the build in progress, go to the Cloud Build Builds page in the Cloud console.

# After the build is complete, to review the new revision, go to the Cloud Run, choose the hello-cloudrun service, and select the Revisions page in the Cloud console. Note that the revision is updated to indicate the prod tag and it is serving 100% of live traffic.

# Revisions page showing percentage of traffic on each revision

# Click Check my progress to verify the objective.

# Create the tag trigger and view the updated revision
# In Cloud Shell, to see percentage-based responses, make a series of requests:

# LIVE_URL=$(gcloud run services describe hello-cloudrun --platform managed --region $REGION --format=json | jq --raw-output ".status.url")
# for i in {0..20};do
# curl -H "Authorization: Bearer $(gcloud auth print-identity-token)" $LIVE_URL; echo \n
# done
# Copied!
# Review the key lines of tag-cloudbuild.yaml that implement the production deployment logic.
# Line 37 updates the canary revision adding the prod tag. The deployed revision is now tagged for both prod and canary:

# gcloud beta run services update-traffic ${_SERVICE_NAME} --update-tags=prod=$${CANARY} --platform managed --region ${_REGION}
# Line 39 updates the traffic for the base service URL to route 100% of traffic to the revision tagged as prod:

# gcloud run services update-traffic ${_SERVICE_NAME} --to-revisions=$${NEW_PROD}=100 --platform managed --region ${_REGION}
# Congratulations!
# Now you can use Cloud Build to create and rollback continuous integration pipelines with Cloud Run on Google Cloud!

# Finish your quest
# This self-paced lab is part of the CI/CD on Google Cloud skill badge quest. A quest is a series of related labs that form a learning path. Completing this quest will earn you a badge to recognize your achievement. You can make your badges public and link to them in your online résumé or social media account. Enroll in this quest to get immediate credit for completing this lab.
# See other available quests.

# This skill badge quest is part of Google Cloud’s Cloud Developer learning path. Continue your learning journey here Cloud Developer Learning Path!

# Take your next lab
# Continue your quest with one of these labs:

# Continuous Delivery with Google Cloud Deploy

# CI/CD on Google Cloud: Challenge Lab

# Next steps / Learn more
# Review documentation for Managing Revisions with CloudRun.
# Read the CloudRun documentation for Rollbacks, gradual rollouts, and traffic migration.
# Review the documentation for Using tags for accessing revisions.
# Learn more about Creating and managing build triggers in CloudBuild.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated June 12, 2023

# Lab Last Tested June 12, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.