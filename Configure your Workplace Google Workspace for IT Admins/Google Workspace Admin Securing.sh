# Google Workspace Admin: Securing
# 1 hour 15 minutes
# 1 Credit
# GSP712
# Google Cloud self-paced labs logo

# Overview
# In this lab you explore just a few of the security policies and features that are available to you in Google Workspace.

# Objectives
# In this lab, you explore basic security features in Google Workspace:

# Review password policy settings

# Enable user account recovery

# Enable 2-Step Verification for a subset of users

# Whitelist apps in the Marketplace

# Prerequisites
# To maximize your learning experience, the familiarity with basic Google Workspace terminology is recommended.

# Setup and requirements
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Start your lab
# When you are ready, click Start Lab in the upper left.

# Sign in to the Google Workspace Admin Console
# To access the Google Workspace Admin Console, you must find your credentials and then sign in.

# Find your lab's User Email and Password
# To access the resources and console for this lab, locate the User Email and Password in the Lab Details panel. This panel is on the left or at the top, depending on the width of the browser window. Use these credentials to log in to the Google Workspace Admin Console.

# If your lab requires other resource identifiers or connection-related information, they will appear on this panel as well.

# Sign in to the Admin Console
# Click Open Google Workspace Admin Console.
# Tip: Open the tabs in separate windows, side-by-side.

# Note: If you see the Verify your account dialog:
# Click Next.
# Click the prefilled user.
# Click Use another account.
# Enter the User Email and Password.

# Accept all terms and conditions as prompted.

# The Admin Console opens.

# Click VERIFY DOMAIN in either the yellow box at the top or the red box in the Domains card.

# Click Next.

# In the Welcome, let's set up Google Workspace dialog, in section 1, click VERIFY. Google verifies your training domain.

# Ignore step 2, Create new users and step 3, Activate Gmail sections.

# Click Google Admin in the top left to open the Google Workspace Admin Console home page.
# Task 1. Review password policy settings
# Start by reviewing Google Workspace's default settings for your user's passwords.

# From the Admin console, click the Security card. You may have to scroll down and click Show more at the bottom to see the Security card.
# Scroll down and click the Authentication > Password management section to expand the section.
# This is where you configure your password policies.

# By default, Google enforces strong passwords, and passwords must be at least 8 characters long.

# If you choose to change the password strength or length settings, the updated policy is applied when a user next changes their password.

# To force a new policy to be applied at the next sign-in, check Enforce password policy at next sign-in.

# From this section, you can also do the following:

# Password reuse: Check or uncheck Allow password reuse to enable or disable password re-use.

# Password reset frequency: Click Never expires and select a time range. The time range options are from Never expires to 365 days.

# Click the section title Password Management to collapse the section.

# Task 2. Enable user account recovery
# By default, if a user forgets their password, they must contact the Google Workspace administrator to reset their password. As your organization's super administrator, you can allow users and non-super administrators to recover their account if they forget their password.

# To enable user password recovery for your organization:

# Still in the Security page, scroll down and click the Account Recovery section. This expands the Account Recovery section.

# Click the User account recovery section.

# Check Allow users and non-super admins to recover their account.

# Click Save.

# Set account recovery for a user account
# Before a user can recover their account, they must set up a recovery method. In this section you perform the following:

# As admin, create a new user Workspace account
# As the new user, set the recovery email for your Workspace account
# To create a new user account:

# From the Main menu (Navigation menu icon), click Directory > Users.
# Click Add new user.
# Type in a First and Last name, and leave the default Primary email.
# Click Manage user's password, organizational unit, and profile photo.
# Scroll down to see Automatically generate a password enabled by default.
# Click Add New User.
# On the resulting panel, click the eye to show the password. Click Copy password to copy the password value.
# Save the email and password for this user to set the recovery email and test account recovery.

# Click Done.
# As the new user, add a recovery email address:

# Click the user avatar in the upper right to sign out of the admin console.
# Open the Google Account page and click Go to Google Account.
# Click Use another account and sign in as the new user using the username and password you saved earlier.
# When prompted, create and confirm a new password, for example luv2learn. Click Change password.
# Click the Security option on the left hand side of the page.
# Scroll down to the Ways we can verify it's you card and click Recovery email.
# Add a recovery email address that you can access outside of this lab. You will be required to re-enter your password before you can add recovery information to your account.
# Click Next. A verification email message is sent to the recovery email address.
# Copy the code in the email message to the Verify your recovery email dialog and click Verify.
# Account recovery is now in place for this user account.

# Click Check my progress to verify the objective.
# Enable user account recovery

# Task 3. Enable 2-Step Verification (optional)
# Note: Because 2-Step Verification requires a phone number, this task is optional.
# 2-Step Verification puts an extra barrier between your business and cybercriminals who try to steal usernames and passwords to access business data. Enforcing 2-Step Verification is the single most important action you can take to protect your business.

# By default, users can enroll in 2-Step Verification but enrollment is not enforced. To enforce 2-Step Verification:

# Go to the Admin Console browser tab and sign back into the Admin console as the account super administrator (use student account credentials from the Lab Details panel).
# From the Admin console, click the Security card.
# Scroll down and click to expand the 2-Step Verification section.
# Notice that Allow users to turn on 2-Step Verification is checked (enabled) by default.

# For enforcement, select On.
# Before you can save the setting, you must enroll your super-admin account into 2-Step Verification.

# Open myaccount.google.com browser tab, click the user avatar and click Workspace User.
# Because signing into the Workspace Admin Console signed you, as the super-admin, into this session, you are not asked for the super-admin password.

# In the Welcome Workspace User page, click Security.
# In the Signing in to Google card, click 2-Step Verification.
# Click Get Started and follow the steps to enroll. You will be asked to enter the following:
# Field	Value
# Password	The password
# Phone number	A phone number on which you can receive a text message
# How do you want to get codes?	Leave Text message selected
# Click Next.

# Google will send a test code to your phone. Enter the code to confirm it's your account. If the code sent starts with "G-", ignore the "G-" and enter only the numbers.

# Click Next.

# Click Turn On to enable 2-Step Verification on your account.

# You are now able to finish configuring 2-Step Verification for your organization.

# Return to the Admin Console - Security - Settings browser tab, where you were configuring 2-Step Verification. Click Save.
# Note: It takes a day for the enforced 2-Step Verification to take effect. This allows all users to set up 2-Step Verification for their accounts.
# Task 4. Allowlist apps in the Google Workspace Marketplace
# By default, users in your organization can install any app from the Google Workspace Marketplace. In this section you restrict the apps users can install.

# From the Admin console, click the Apps card.
# Click the Google Workspace Marketplace apps card.
# Click Settings in the left panel.
# Select Allow users to install and run only selected apps from the Marketplace, and then click Save.
# Click Apps list > Allowlist App.
# Search for any workspace add-on app. From the search results, add an app by hovering over the card and clicking Add to allowlist.
# Add 2 more apps. Make a note of the apps you added so you can search for and install them in Gmail.
# Click Check my progress to verify the objective.
# Allowlist apps in the Google Workspace Marketplace

# Test this feature. Try to install add-on apps from the Marketplace into gmail.

# Install an app from the allowlist:

# Open Gmail.

# Click Get Add-ons (the plus sign in the right panel) to open a list of apps from Google Workspace Marketplace.

# Search for the app you added to your allowlist earlier, then click on the card.

# Click on Individual Install. You will be prompted to grant some permissions to the app.

# Allow the app the permissions it needs, and click Done to complete the installation.

# Install an app that is not on the allowlist:

# Click the card of an app that is not on the allowlist.
# A message that the App is not allowed for install by admin, only Admin install is allowed. This confirms that your users can only install apps that you allow.

# Congratulations!
# You explored some of the security policies and features that are available to you in Google Workspace. With this practical hands-on experience you should feel comfortable getting started with a new Google Workspace deployment, or doing further training in Google Workspace administration.

# Finish your quest
# This self-paced lab is part of the Google Workspace for IT Admin quest. A quest is a series of related labs that form a learning path. Enroll in this quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost Catalog to see all available quests.

# Next steps / Learn more
# For more information on the topics covered in this lab, refer to these Help Center articles:

# Security and data protection
# Enforce and monitor password requirements for users
# Set up password recovery for users
# Deploy 2-Step Verification
# About Google Workspace Marketplace
# Visit the Google Workspace Learning Center to learn more about Google Workspace.

# From Google Workspace for Developers, learn how to Enhance Google Workspace apps

# From the Cloud Certification Help, check out and consider Google Workspace Administrator Certification

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated November 25, 2022

# Lab Last Tested November 25, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# A Tour of Google Cloud Sustainability