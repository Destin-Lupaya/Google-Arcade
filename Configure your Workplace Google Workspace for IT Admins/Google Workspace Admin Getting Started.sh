# Google Workspace Admin: Getting Started
# 1 hour
# 1 Credit
# GSP035
# Google Cloud self-paced labs logo

# Overview
# Google Workspace by Google Cloud is your go-to solution for productivity tools. Get more done with seamless collaboration tools, a simple management interface, and enterprise-level security and reliability. Easily add users, manage devices and configure security and settings so your data stays safe.

# Centralized administration makes set up and management fast and easy. But access to Google Workspace Administration controls is not commonly available for practice, so in this lab you are provided with an organization "Google Workspace Labs" and a temporary Google Workspace domain to work in. In this lab, you personalize your Google Workspace Admin console to suit your needs, and then make some basic modifications to the Admin Console, and modify the company profile. After, you provision users both individually and in a batch upload using a CSV file.

# Objectives
# In this lab, you customize your Workspace using the Google Workspace Admin Console:

# Change your organization's name

# Enter the correct primary and secondary administrator emails

# Select a default time zone for new users

# Select new user feature release schedule

# Select communication preferences for your domain

# Add your company's logo

# Add users individually and bulk uploading with a CSV file

# Log in as an added user to verify the customization

# Prerequisites
# To get the most from this lab, familiarity with basic Google Workspace terminology is recommended.

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
# Task 1. Configure your organization's profile
# In this section, you customize the "Google Workspace Labs" organization profile page. Feel free to change the data or the name of the organization.

# Customize your profile
# From the Main menu (Navigation menu icon), click Account > Account settings.

# Click the Profile card.

# To update a profile field, hover over the field, click the pencil that displays on the right, and then click Save.

# Change the organization Name to your organization's name. It can be a fictitious name.

# The Contact info section is where you provide the primary and secondary email addresses of your organization's admin contacts. Leave the default emails.

# In the Support message section, enter a message users will see if they can't sign in to their Google Workspace account. This message usually identifies who to contact or instructions if they forget their password, for example "Contact Magda Smith for any Sign In issues." Click Save.

# Specify the Language users see for your Google services when they first sign into their managed Google account.

# In the Time zone section, choose the default time zone that applies to your organization. Click Save.

# Collapse the Profile card by clicking the up-arrow at the top right of the card.

# Customize preferences
# Click the Preferences card.
# In New features, leave Scheduled release selected. As an administrator, you can briefly delay when new features in Google Workspace are released to your users. You then have time to try out the features first and train users on the changes. By selecting Scheduled release, new feature deployment is delayed.
# Learn more about Schedule releases from the Choose when users get new features page.
# In New products select Turned off when released, which means that you or another administrator must manually add new products before users can access them.

# Click Save.

# Scroll down and click on Communication preferences.

# Select all of the options and then click Save to save all changes.

# Collapse the Preferences card by clicking the up-arrow at the top right of the card.

# Add your organization's logo
# Click the Personalization card.
# Select Custom Logo, click Select file to upload, and then Upload to upload your organization's logo. Click Save to save your settings.
# If you need a logo to upload, right-click or Ctrl-click on the logo below to save it to your desktop.

# Example of a power button logo

# Collapse the Personalization card.
# Click Check my progress to verify the objective.
# Configure your organization's profile

# Task 2. Add users individually
# From the Main menu (Navigation menu icon), click Directory > Users.

# Click Add new user.

# Type in a First and Last name, and leave the default Primary email.

# Click Manage user's password, organizational unit, and profile photo.

# Scroll down to see Automatically generate a password enabled by default.

# Click Add New User.

# On the resulting panel, click the eye to show the password. Click Copy password to copy the password value.

# Save the email and password for this user to test new user access at the end of this lab.

# To send Sign-in instructions to the new user:

# Click Preview and Send. The Send sign in instructions dialog opens.

# Enter the new user's email address. Click Send. Clicking Email instructions or Print instructions can be used to deliver the account information to the new user — you can change the address to which this new user information is sent.

# Click Done. You may have to refresh the browser tab to see the new user in the user list.

# (Optional) To set other user settings, such as adding the new user to groups or suspending the user, click the user's name in the list.

# Learn more about addition instruction from the Update user profiles or photos page for additional instructions.

# Task 3. Batch add users from a CSV spreadsheet
# Return to the Users page.

# Click Bulk update users.

# Click Download blank CSV template. This provides a blank CSV file to populate with a set of multiple users. Do not close this dialog box.

# Open the CSV file in a spreadsheet application like Google Sheets or Microsoft Excel.

# Add two or more new users. The following information is required:

# First Name

# Last Name

# Email Address - for this lab you must use the same domain (@xxx.com) as the User Email for this lab.

# For example, if the User Email you used to start the lab is student@goog-test.reseller.gappslabs.co.s-4aknhohx.qwiklabs-gsuite.net, the email for one of the users on the spreadsheet will be username@goog-test.reseller.gappslabs.co.s-4aknhohx.qwiklabs-gsuite.net.

# Password - must meet format guidelines, the default requirement is 8 characters. For example, "12345678".

# Org Unit Path - for this lab use a backslash (/).

# (Optional) Fill in the other columns.
# Note: To add multiple phone numbers or addresses for a user, add columns to the spreadsheet. Rename the header accordingly. For example, to add a second home address, create a new column with the header Home Address 2.
# Save the updated file as a CSV file on your computer.

# Select the CSV file to upload:

# Click Attach CSV file.

# Select the CSV file and click Open.

# Click Upload to import the user list. You can view progress by clicking the Tasks icon on the top right of the Users page. If there's an error, update the information as needed in your spreadsheet and upload the file again.
# Learn more about errors from the Add or update multiple users from a CSV file page.

# After a moment, refresh your browser to reload the user list. The new users should appear.
# Click Check my progress to verify the objective.
# Batch add users from a CSV spreadsheet

# Task 4. Verify customization
# Log in to Gmail to verify customization
# In this section, you open the Google Workspace application, Gmail, to verify that you can log and view the customized Workspace app as a new user.

# Open Gmail.
# In the top right, click the Account Owner icon, and click Add another account.
# Log in using the username and password you saved earlier.
# Click Accept to accept the Google Terms of Service and Google Privacy Policy.
# You will be presented with a Change Password dialog.
# Change the user's password. If you try to use a password that is not secure enough, you will be asked to change it. Use a password such as "Testuser1" with a capital letter and a number.
# When your password is accepted, you are logged in and see your custom Google Workspace app as a new user.

# Click Check my progress to verify the objective.
# Verify customization

# Congratulations!
# In this lab you've gotten practice as a Google Workspace Administrator, using the tools the Administrator uses to set up, customize, and add users to a Workspace domain for a new organization. With this practical hands-on experience you should feel comfortable getting started with a new Google Workspace deployment, or doing further training in Google Workspace administration.

# Finish your quest
# This self-paced lab is part of the Google Workspace for IT Admin quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost Catalog to see all available quests

# Take your next lab
# Continue your Quest with Google Workspace Admin: Provisioning

# Next steps / Learn more
# For more information on personalization topics, there is extensive documentation online. Refer to the following Help Center articles to dive into the full documentation:

# Customize Google Workspace Dashboard for your users

# Adding your logo to your admin console

# Admin console map

# Change the default time zone for new users

# Explore Additional Google Workspace Admin Help Center

# Visit the Google Workspace Learning Center

# Google Workspace for Developers

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated July 22, 2022

# Lab Last Tested May 25, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?