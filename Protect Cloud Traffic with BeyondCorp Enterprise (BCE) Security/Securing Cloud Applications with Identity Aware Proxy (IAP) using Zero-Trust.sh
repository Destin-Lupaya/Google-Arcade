# Securing Cloud Applications with Identity Aware Proxy (IAP) using Zero-Trust
# 1 hour
# 1 Credit
# GSP946
# Google Cloud self-paced labs logo

# Overview
# The Zero Trust security model is where no person, device or network is inherently trusted. Granting access is based on numerous factors including but not limited to: identity, device, location, and time of day. One of the primary use cases for Zero-Trust policy enforcement is to provide secure access to web applications, i.e., HTTP/HTTPS-based applications that are hosted on Google Cloud (or on-premises data centers). Thus each web application can have it's own access control for precise security and lower risk. Securing the web application doesn't require setting ACL's and setting IP ranges which allows for rapid onboarding without compromising security. Architecturally, the primary component to provide zero-trust access is:

# Identity-Aware Proxy - a policy enforcement engine for ensuring every access request is authorized.

# In this lab, you will walk through deploying a sample application to App Engine and enforcing policies using Identity-Aware Proxy (IAP). You will also obtain user identity information in the application protected by IAP.

# What you'll learn
# Deploying a simple App Engine application using Python
# Enabling Identity Aware Proxy (IAP) to restrict access to the application
# Obtaining user identity information from IAP in your application
# Prerequisites
# Basic programming language knowledge (Python)

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
# Scenario
# You're building a minimal web application with Google App Engine, then exploring various ways to use Identity-Aware Proxy to restrict access to the application and provide user identity information to it. Your app will:

# Display a welcome page

# Access user identity information provided by IAP

# Task 1. Deploy the application and protect it using IAP
# The application is an App Engine Standard application written in Python 3.7 that simply displays a "Hello, World" welcome page. You will deploy and test it, then restrict access to it using IAP.

# In Cloud Shell, run the following to download the code needed for this lab from Github and then change to the code folder:

# git clone https://github.com/googlecodelabs/user-authentication-with-iap.git
# cd user-authentication-with-iap
# Copied!
# Review the application code
# Change directories from the main project folder to the 1-HelloWorld folder:

# cd 1-HelloWorld
# Copied!
# The application code is in the main.py file. It uses the Flask web framework to respond to web requests with the contents of a template. That template file is in templates/index.html, and for this step contains only plain HTML. A second template file contains a skeletal example privacy policy in templates/privacy.html.

# There are two other files: requirements.txt lists all the non-default Python libraries the application uses, and app.yaml tells Google Cloud Platform that this is a Python 3.7 App Engine application.

# You can list each file in Cloud Shell using the cat command:

# cat main.py
# Copied!
# You can also open the Cloud Shell Code Editor by clicking Edit (The Edit icon.) at the top right-hand side of the Cloud Shell window, and examine the code using the editor once it loads.

# You do not need to change any files for this step.

# Deploy the application to app engine
# Now deploy the app to the App Engine Standard environment for Python 3.7.

# Run the following command:

# gcloud app create --project=$(gcloud config get-value project) --region=us-central
# Copied!
# If you are asked if you want to continue, enter Y for yes.

# You may also be asked to Authorize the call made to create the App Engine app. If so click the Authorize button.
# Run the following command after the create command completes:

# gcloud app deploy
# Copied!
# If asked to continue, enter Y and press Enter.

# Note: Re-run the command to avoid an error if it appears.
# In a few minutes the deploy should complete and you will see a message that you can view your application with the following command:

# gcloud app browse
# Copied!
# Note: Since this is the first time this app is run, it will take a few seconds to appear while a cloud instance is started, and you should see similar output to the following image. Access is not yet restricted.
# The IAP example application is displayed within a browser, which includes the text 'This is step 1 of the User Authentication with IAP codelab'.

# Click Check my progress to verify the objective.
# Deploy the application to App Engine

# Restrict access with IAP
# Navigate to Navigation Menu > Security > Identity Aware Proxy, and click on the Enable API button, then Go To Identity Aware Proxy.
# Since this is the first time you have enabled an authentication option for this project, you will see a message that you must configure your OAuth consent screen before you can use IAP.

# The Identity-Aware Proxy pop-up, which displays a warning message and a Configure Consent Screen button.

# Click on the Configure Consent Screen button. A new tab will open to configure the consent screen.

# Select the Internal radio option and then click Create.

# Go back to the first browser tab and run the following command in Cloud Shell:

# export AUTH_DOMAIN=$(gcloud config get-value project).uc.r.appspot.com
# Copied!
# You will use the output of the commands as input for the form on the OAuth Consent tab.

# To view the value populated run:
# echo $AUTH_DOMAIN
# Copied!
# Fill in the required inputs with appropriate values:
# Application Name: IAP Example

# Support email: (select the student user in the dropdown)

# Authorized domain: Click the + button and enter the output from the last step.

# Developer contact email: student-lab@qwiklabs.net (You must press Enter after entering this value.)

# Click the Save and Continue button at the bottom of the page.

# In the Scopes step of the OAuth workflow, leave everything blank and click the Save and Continue button.

# Click the Back to Dashboard button on the last step.

# You can close the workflow browser tab after returning to the dashboard.

# In the remaining tab, navigate to Navigation Menu > Security > Identity Aware Proxy.
# You may need to refresh the page if required.

# Click the toggle button in the IAP column in the App Engine app row to turn IAP on for the application deployed in the previous section.
# The HTTPS Resources tabbed page, which displays the toggled switched on for IAP in the App Engine app field.

# Navigate to the application by holding down the Ctrl/Command key and selecting the URL of the App Engine application in the IAP console.

# Sign in with the student user listed in the login form.

# The Google sign in pop-up, wherein a student user is displayed.

# You will be shown a screen that informs you that you do not have access to the application.

# A pop-up notification; You don't have access.

# You have successfully protected your app with IAP, but you have not yet told IAP which accounts to allow through.

# Click Check my progress to verify the objective.
# Restrict access with IAP

# Allow members to access application
# Return to the Identity-Aware Proxy page of the console by going to Navigation Menu > Security > Identity Aware Proxy.

# Select the checkbox next to App Engine app, and see the sidebar at the right of the page and click Add Principal.

# The App Engine app, which includes the Show inherited permissions toggle and the Add Member button.

# Copy the Username from the lab console on the top left of the lab and enter it into the New principals input box.

# Set its role to Cloud IAP > IAP-secured Web App User.

# The Filter drop-down menu, which includes options listed under the Quick access, By product or service, and Roles categories.

# Click Save when finished. The message "Policy Updated" will appear at the bottom of the window.
# Click Check my progress to verify the objective.
# Allow member to access application

# Verify access is restored
# Navigate back to your app engine application and reload the page. You should now see your web app, since you already logged in with a user you authorized.
# However, you may still see the "You don't have access" page since IAP may not recheck your authorization due to a login cookie being stored.

# In that case, do the following steps:

# Open your web browser to the home page address with /_gcp_iap/clear_login_cookie added to the end of the URL, as in https://iap-example-999999.appspot.com/_gcp_iap/clear_login_cookie.
# Note: Use the URL from the app engine application you deployed earlier in the lab. The above URL is an example.
# You will see a new Sign in with Google screen, with your account already showing.

# Note: Do not click the account!
# Click Use another account and re-enter your credentials.
# These steps cause IAP to recheck your access and you should now see your application's home screen.

# Task 2. Access user identity information
# Once an app is protected with IAP, it can use the identity information that IAP provides in the web request headers it passes through. In this step, the application will get the logged-in user's email address and a persistent unique user ID assigned by the Google Identity Service to that user. That data will be displayed to the user in the welcome page.

# In Cloud Shell enter the following command:

# cd ~/user-authentication-with-iap/2-HelloUser
# Copied!
# Deploy to App Engine using the following command:

# gcloud app deploy
# Copied!
# Note: You may be asked to Authorize the call to deploy the application.
# Enter Y if asked to continue.

# When the deployment is ready enter the following command in Cloud Shell:

# gcloud app browse
# Copied!
# If a new tab does not open on your browser, copy the displayed link and open it in a new tab. You should see a page similar to the following:

# The IAP Hello User page.

# Note: You may need to wait a few minutes for the new version of your application to replace the prior version. Refresh the page if needed to see a page similar to the above.
# Click Check my progress to verify the objective.
# Access User Identity Information

# Examine the application files
# The 2-HelloUser folder contains the same set of files as in the 1-HelloWorld folder, but two of the files have been changed: main.py and templates/index.html. The program has been changed to retrieve the user information that IAP provides in request headers, and the template now displays that data.

# Run cat main.py to view the contents of the main.py file.
# There are two lines in main.py that get the IAP-provided identity data:

# user_email = request.headers.get('X-Goog-Authenticated-User-Email')
# user_id = request.headers.get('X-Goog-Authenticated-User-ID')
# The X-Goog-Authenticated-User- headers are provided by IAP, and the names are case-insensitive, so they could be given in all lower or all upper case if preferred. The render_template statement now includes those values so they can be displayed:

# page = render_template('index.html', email=user_email, id=user_id)
# The index.html template can display those values by enclosing the names in doubled curly braces:

# Hello, {{ email }}! Your persistent ID is {{ id }}.
# As you can see, the provided data is prefixed with accounts.google.com:, showing where the information came from. Your application can remove everything up to and including the colon to get the raw values if desired.

# Congratulations!
# You have learned how to use Identity Aware Proxy (IAP) to secure HTTP(s) applications deployed to Google Cloud Platform.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual last updated August 24, 2022

# Lab last tested May 05, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.