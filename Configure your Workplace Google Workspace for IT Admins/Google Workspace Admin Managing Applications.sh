# Google Workspace Admin: Managing Applications
# 1 hour 15 minutes
# 1 Credit
# GSP417
# Google Cloud self-paced labs logo

# Overview
# In this lab, you learn how to create an organizational unit structure and configure applications based on organizational units (OUs).

# What you'll learn
# In this lab, you use Google Workspace to do:

# Create three OUs and add users to those OUs.

# Configure application access based on OUs.

# Configure application settings based on OUs.

# Prerequisites
# Familiarity with basic Google Workspace terminology

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
# Task 1. Create an organizational unit (OU) structure
# Initially in your Google Admin console, all users and devices are placed in a single organizational unit (OU), called the top-level OU. All settings you make in the Admin console apply to this top-level OU and, therefore, to all users and devices in your account. Any child OUs created under the top-level OU inherit those settings.

# To apply different settings to some users or devices, place them in a child OU, below the top level. You then customize the inherited settings of the child OU, and therefore the members of the child OU.

# In this section, you create three OUs, and then apply different organizational policies to them.

# Create child OUs for Marketing, Compliance, and Contractors
# Start by creating your OUs.

# From the Admin console, click the Organizational units card. You may have to click Show more at the bottom, or scroll down to see the card.

# Click Create organizational unit to create a new OU.

# For Name of organizational unit, enter Marketing

# Optional: For Description, enter The Marketing team

# Click CREATE.

# Repeat steps 2-5 and create the Compliance and Contractors OUs.

# Create users in each of the OUs
# Next, create three new users and place each of them into their own OU. Start by adding a user to the Marketing OU.

# Click the Navigation menu (Navigation menu icon) > Directory > Users.
# Click Add new user.
# For First name, enter Jamie.
# For Last name, enter Marketeer.
# Click Manage user's password, organizational unit, and profile photo.
# For Organizational unit, click the pencil icon.
# Under Google Workspace Labs, click Marketing.
# Click Done.
# Click ADD NEW USER. Note the username and password. These will be used later in the lab.
# Click DONE.
# Repeat steps 2-10 to create two more users and assign them to an OU as described below:
# User: Leslie Compliance, OU: Compliance.
# User: Jesse Contractor, OU: Contractors.
# Click Check my progress to verify the objective.
# Create OU structure and new users

# Task 2. Configure application settings based on OUs
# In this section, you configure access settings for Gmail and Google Vault, and Data Loss Prevention (DLP) settings for Google Drive.

# Disable Gmail for Contractors
# Customize Gmail access such that users in the Contractors OU do not have access to the Gmail service.

# Click Main menu (Navigation menu icon) > Apps > Google Workspace > Gmail.
# Note: If a prompt to verify your domain appears, under Services, click the checkbox next to Gmail to select it. Leave this tab open for the rest of the lab.

# Open a new Admin console tab and repeat steps 1 and 2. The Service Status for all apps should now indicate ‘ON for everyone’.
# Click the Service status card.

# In the left panel, under Google Workspace Labs, click Contractors.

# For Service status, select OFF and click OVERRIDE to override the inherited settings and disable Gmail for all users in the Contractors OU.

# Testing Gmail access configuration
# Now test to make sure that the Gmail access configuration is working properly.

# Testing Gmail access for users in the Contractors OU
# Open Gmail.
# Click the Google avatar at the top right of the screen. (Notice that you are currently logged in as Workspace User.)
# Click Add another account.
# For Email or phone, enter the email of Jesse Contractor that you recorded in an earlier section. It should be similar to jesse@goog-test.reseller.gappslabs.co….
# Click Next.
# For Enter your password, enter the password of Jesse Contractor that you previously noted and click Next.
# Accept terms as prompted.
# Create a secure password and click Change password.
# A page opens with a message explaining that Jesse Contractor does not have access to Gmail.

# Testing Gmail access for users in the Marketing OU
# Switch to the Gmail browser tab which is logged in as Workspace User.
# Click the Google avatar at the top right of the screen.
# Click Add another account.
# This time, log in as Jamie Marketeer with the email and password for that user that you previously recorded.
# Gmail successfully opens for Jamie Marketeer.

# Testing Gmail access for users in the Compliance OU
# Switch to the Gmail tab which is logged in as Workspace User.
# Click the Google avatar at the top right of the screen.
# Click Add another account.
# This time, log in as Leslie Compliance with the email and password of that user.
# Gmail successfully opens for Leslie Compliance.

# Click Check my progress to verify the objective.
# Disable Gmail for contractors

# Restrict access to Vault
# Configure access to Google Vault such that only users in the Compliance OU can access Google Vault.

# Switch to the Admin console browser tab.

# Click Main menu (Navigation menu icon) > Apps > Google Workspace > Google Vault.

# Click the Service status card.

# Click OFF for everyone to disable Google Vault for all users.

# Click SAVE.

# In the left panel, under Google Workspace Labs, click Compliance.

# For Service status, click ON and then OVERRIDE to override the inherited settings.

# Click TURN ON when prompted.

# Testing Vault access configuration
# Now test to make sure that the Google Vault access configuration is working properly.

# Testing Vault access for users in the Compliance OU
# Switch to the Gmail tab that is logged in as Leslie Compliance.
# Click on the Google apps icon.
# Scroll down and click Vault.
# Google Vault should load successfully for user Leslie Compliance.

# Note: If Google Vault defaults to Google Workspace User instead of Leslie Compliance, click on Sign in with a different account located in the middle of the screen and sign in with Leslie Compliance.
# Testing Vault access for users in the in the Marketing OU
# Switch to the Gmail tab that is logged in as Jamie Marketeer.
# Click on the Google apps icon.
# Scroll down and click Vault.
# A page opens with the message that Jamie Marketeer does not have access to Google Vault.

# Testing Vault access for users in the Contractors OU
# Switch to the Gmail tab that is logged in as Jesse Contractor.
# Click on the Google apps icon.
# Scroll down and click Vault.
# A page opens with the message that Jesse Contractor does not have access to Google Vault.

# Click Check my progress to verify the objective.
# Restrict access to Vault

# Configuring Data Loss Prevention (DLP) for Google Drive
# Set up a rule to prevent file sharing with an external domain in Google Drive.

# Switch to the Admin console browser tab.
# Click on the Navigation menu (Navigation menu icon) > Home to return to the Admin console home page.
# Click the Rules card.
# Click Create rule > Data Protection.
# For Name, enter "Google Drive - Prevent sharing with external domain".
# Under Scope, click Organizational units and/or groups.
# Click Include organizational units.
# Select Compliance and Marketing.
# Click DONE.
# Click CONTINUE.
# Under Apps > Google Drive, select File created, modified, uploaded or shared.
# Click CONTINUE. (Because no condition has been added this rule will apply to all files in Google Drive.)
# For Actions, select Block external sharing.
# Click CONTINUE.
# Review the rule details and click CREATE.
# The new rule, Google Drive - Prevent sharing with external domain, is now listed in the Rules list.

# Testing Google Drive DLP configuration
# Now test to make sure that the DLP configuration on Google Drive is working properly.

# Testing Google Drive DLP access for users in the Compliance OU
# Switch to the Gmail tab that is logged in as Leslie Compliance.
# Click on the Applications icon.
# Click Docs.
# Under Start a new document, click Blank.
# In the top right hand corner of the page, click Share.
# For Add people and groups, enter an email address on an external domain, e.g. @gmail.com. Press the return key on the keyboard.
# Click Send.
# Leslie Compliance is notified that the file cannot be shared outside Google Workspace Labs.

# Testing Google Drive DLP access for users in the Contractors OU
# Switch to the Gmail tab that is logged in as Jesse Contractor.
# Click on the Applications icon.
# Click Docs.
# Under Start a new document, click Blank.
# In the top right hand corner of the page, click Share.
# If prompted, Name before sharing, click Save.
# For Add people and groups, enter an email address on an external domain, e.g. @gmail.com. Press the return key on the keyboard.
# Click Done.
# Click Send.
# A message appears warning that you are about to share a file externally. Click Share anyway to share the file with a user on an external domain.

# Task 3. Test your knowledge

# True or False: Three types of organizational units are automatically spun up when you set up Google Workspace: one for admins, one for users, and one for devices.

# True

# False


# To add Users to an organizational unit:

# You manually or batch add users and assign them to an organization unit.

# You put users in each organizational unit that runs an app they use.

# You manually or batch add users, Google Workspace assigns them to an organization unit based on rules set by the admin.


# The following is true when you use organizational units to set policies:

# One child organization unit may be in the hierarchy path of more than one top level organizational unit.

# You create an organizational unit for each department, even if each unit has the same policies.

# You create a top level organizational unit, and then create child organizational units to customize the policies inherited from the top level organizational unit.

# You must always keep organizational units for devices separate from organizational units for users.

# Congratulations!
# In this lab you’ve created child organizational units (OUs), added users to them, and then customized OU-specific application settings. We’ve touched on three different applications in this lab, specifically Gmail, Google Vault, and Google Drive. With this hands-on experience you should feel comfortable configuring other application settings for OUs on the Google Workspace Admin console.

# Finish your quest
# This self-paced lab is part of the Google Workspace for IT Admin quest. A Quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge public and link to them in your online resume or social media account.
# Enroll in this quest and get immediate completion credit if you've taken this lab. See other available quests.

# Take your next lab
# Continue your Quest with Google Workspace Admin: Managing Google Meet

# Next steps / Learn more
# Visit the Google Workspace Learning Center for more training.
# In Google Workspace for Developers, learn how to Develop Extensions and Add Ons to Google Workspace.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: March 01, 2023
# Lab Last Tested: March 01, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.