# Protect Cloud Traffic with BeyondCorp Enterprise (BCE) Security: Challenge Lab
# 1 hour 30 minutes
# 5 Credits
# GSP373
# Google Cloud self-paced labs logo

# Introduction
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# Topics tested:

# A web application will be provided which the student must deploy to App Engine.

# The student must set up OAuth consent for the application in the Security menu of the console.

# The student must protect traffic to the web application which will be public at first, to use IAP and stop unsecured traffic.

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
# Challenge scenario
# In this challenge lab, you deploy a web application. You will then utilize IAP to protect access and authorize the Tester account access to the application.

# 1. Deploy a provided web application to Google Cloud
# Deploy a web application using App Engine provided with the sample code here

# Ensure you change directory to the following to access the required sample application once you clone the git repository.

# cd python-docs-samples/appengine/standard_python3/hello_world/
# Copied!
# Check if Web Application has been deployed
# 2. Configure OAuth Consent for the web application deployed
# Configure an external-facing OAuth Consent screen with no scopes and no users.

# Check if OAuth condent has been configured
# 3. Configure the deployed web application to utilize IAP to protect traffic
# Enable and configure the IAP API and enable the service for the App Engine app.

# Verify access to the link of the App with the Owner user account and confirm that it works.

# Then access the link with the Tester user account. You should receive a permissions issue as access to the Tester account has not been configured.

# Check if IAP is enabled
# 4. Authorize the test account access to the App Engine application
# Add the Tester account as a principal and assign the role IAP-secured Web App User.

# Access the link again with the Tester account. You should be able to access without any permissions issues.

# Check if the correct IAM role has been applied to the principal
# Congratulations !
# You have completed the BeyondCorp Enterprise Cloud Security Challenge lab. You:

# Deployed a web application
# Configured OAuth for the application
# Configured the web application to use IAP
# Authorized the Tester account to access the application
# BeyondCorp badge

# Earn Your Next Skill Badge
# This self-paced lab is part of the Protect Cloud Traffic with BeyondCorp Enterprise skill badge quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge. Search the catalog for 20+ other skill badge quests in which you can enroll.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: June 14, 2022 Lab Last Tested: May 5, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.