# Google Workspace Admin: Managing Google Meet
# 1 hour 15 minutes
# 1 Credit
# GSP687
# Google Cloud self-paced labs logo

# Overview
# In this lab, you learn how to use Google Meet to create a meeting and live stream, how to configure different Google Meet features, as well as how to use the Google Workspace Console to configure access to Google Meet.

# Objectives
# In this lab, you use Google Meet to do the following:

# Create a meeting and live stream

# Explore Google Meet features

# Configure and test Google Meet features

# Configure and test Google Meet access

# Prerequisites
# Familiarity with basic Google Workspace terminology helps maximize your learning.

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
# Task 1. Creating a meeting and live stream on Google Meet
# This section reviews 3 methods of creating a meeting with Google Meet. In the third method you also create a live stream.

# Method 1: Via the Google Meet app
# Click Applications (Application icon) in the upper right.

# Scroll down and click Meet.

# Click New meeting to view meeting options.

# Close the Google Meet tab.

# Method 2: Via the browser address bar
# Open a new tab and enter meet.new in the address bar to open Google Meet and start a meeting.

# Click Leave call (call end icon) on the bottom menu bar to end the meeting.

# Close the Google Meet tab.

# Method 3: Via the Calendar app
# Open Google Calendar.
# Double click anywhere on the calendar to create a new event.
# Click Add title and enter Test Meeting 1.
# Click Add Google Meet video conferencing.
# Click View conference details (down arrow across from Join with Google Meet).
# Click Add live stream. If the popup window This will reset your settings opens, click Add live stream again.
# Click Save.
# Click Check my progress to verify the objective.
# Create a meeting on Google Meet

# Task 2. Exploring Google Meet features
# Try out various features in Google Meet. You will use the Google Workspace Admin Console to configure them later in the lab.

# Click Test Meeting 1 on your calendar.

# Click Join with Google Meet.

# The camera is turned on by default. Click Join now.

# From the bottom menu bar, click More options (more options icon).

# Click Apply visual effects. Note that Google Meet provides a variety of backgrounds to choose from and also the option to Upload a background image.

# Click the X symbol on the top right-hand corner to close the Backgrounds panel.

# Click More options more options icon again. Note that there is also an option to Manage recording.

# Click Manage streaming.

# Click Stream internally.

# Click Start streaming in the window that opens and then click Start.

# Click Meeting details (the i in the bottom right menu bar).

# Click Copy streaming info.

# Open a new tab, paste the stream URL in the address bar and press enter on the keyboard.

# Click Play to watch the live stream.

# Click Leave call (call end icon) on the bottom menu bar to end the meeting.

# Close the Google Meet tab.

# Task 3. Managing Google Meet features
# In this section, you configure the features you have just explored using the Workspace Admin Console.

# Switch to the Admin console tab.

# On the Navigation menu (Navigation menu icon) click Apps > Google Workspace > Google Meet.

# Expand and click the Meet video settings panel (click the down arrow).

# Turn off the recording function
# Hover over Recording and click the pencil icon to the right.

# Uncheck Let people record their meetings.

# Click SAVE.

# Turn off the live stream function
# Hover over Stream and click on the pencil icon to the right.

# Uncheck Let people stream their meetings.

# Click SAVE.

# Change the default video quality
# Hover over Default video quality and click the pencil icon to the right.

# Select Audio only.

# Click SAVE.

# Prevent users from replacing the background of their video feeds
# Hover over Visual effects and click the pencil icon to the right.

# Uncheck Users can replace their background with an image option.

# Click SAVE.

# Test Google Meet feature configuration
# Now test your Google Meet feature configuration.

# Note: Changes you make in the Admin console can take some time to propogate. You may need to wait and refresh the page.
# Switch to the Google Calendar tab.
# Double click anywhere on the calendar to create a new event.
# Click Add title and enter Test Meeting 2.
# Click Add Google Meet video conferencing.
# Click More options (down arrow across from Join with Google Meet).
# Note that the Add live stream option is no longer available.

# The Add live stream option might still be present because changes take some time to propagate. However, an error will occur when you click on the option as a live stream cannot be added to the meeting.

# Click Save.
# Click Test Meeting 2 on your calendar.
# Click Join with Google Meet.
# Note that the camera is now turned off by default.

# Click Join now.
# Click More options (more settings icon).
# Note that there is no longer a Record meeting option.

# Click Apply visual effects.
# Note that you no longer have a variety of backgrounds to choose from or the option to Use image from disk

# Click Leave call (call end icon) on the bottom menu bar to end the meeting.
# Close the Google Meet tab.
# Click Check my progress to verify the objective.
# Managing Google Meet Features

# Task 4. Managing Google Meet access
# Your company has acquired a small business, and you are in charge of adding the new employees to the system. Until the acquisition is finalized, the employees will not need access to Google Meet.

# In this final section of the lab, you will create a new organizational unit (OU) and disable access to Google Meet for all users in the OU.

# Create a child OU for Acquisitions
# From the Admin console, navigate to Navigation menu (Navigation menu icon) > Directory > Organizational units.

# Click Create organizational unit to create a new OU.

# For Name of organizational unit, enter Acquisitions

# Optional: For Description, enter New team members from acquired companies

# Click CREATE.

# Turn off Google Meet service
# Switch to the Admin Console tab.
# On the Navigation menu (Navigation menu icon) > Apps > Google Workspace > Google Meet.
# Click the Service status panel.
# In the left panel, under Google Workspace Labs, click Acquisitions.
# Select OFF.
# Click OVERRIDE.
# Click TURN OFF SERVICE.
# Click Check my progress to verify the objective.
# Managing Google Meet Access

# Task 5. Test Google Meet access configuration
# To test your meeting access configuration, create a new user in the Acquisitions OU, log in as that user, and try to access Google Meet.

# Create a new user
# Click the Navigation menu (Navigation menu icon) > Directory > Users.
# Click Add new user.
# For First name, enter Amanda.
# For Last name, enter Willis.
# Click Manage user's password, organizational unit, and profile photo.
# For Organizational unit, click the pencil icon.
# Under Google Workspace Labs, click Acquisitions.
# Click Done.
# Click ADD NEW USER.
# Note: Please keep a record of the new user's username and password for future use. They will be necessary in the next step.
# Test Google Meet access for non-acquisitions users
# Open Google Calendar.
# Double click anywhere on the calendar to create a new event.
# Note the Add Google Meet video conferencing option is still available.

# Log in as a user in the Acquisitions OU
# Click the Google avatar at the top right of the screen. (Notice that you are currently logged in as Workspace User.)

# Click Add another account.

# For Email or phone, enter the email of Amanda Willis that you recorded in an earlier section. It should be similar to amanda@goog-test.reseller.gappslabs.co….

# Click Next.

# For Enter your password, enter the password of Amanda Willis that you previously noted and click Next.

# Accept terms as prompted.

# Create a secure password and click Change password.

# Testing Google Meet access for users in the Acquisitions OU
# Double click anywhere on the calendar to create a new event.
# Note the Add Google Meet video conferencing option is no longer available.

# The Add Google Meet video conferencing option might still be present because changes take some time to propagate. Refresh the page and try steps 3 and 4 again!

# Open Google Meet.
# Note that the New meeting option is still available.

# Click the Google avatar at the top right of the screen.
# You are currently logged in as the default account, Workspace User.

# Select Amanda Willis from the list of accounts.

# Google Meet will open in a new tab logged in as Amanda Willis. Note that the New meeting option is no longer available.

# Congratulations!
# You explored and configured various Google Meet features. You also configured access to Google Meet. With this hands-on experience you should feel comfortable in managing Google Meet to suit your organization’s needs. Good luck!

# Finish your quest
# This self-paced lab is part of the Google Workspace for IT Admin quest. A quest is a series of related labs that form a learning path. See the Google Cloud Skills Boost Catalog to see all available quests.

# Take your next lab
# Continue your quest with Google Workspace Admin: Securing

# Next steps / Learn more
# Visit the Google Workspace Learning Center
# From Google Workspace for Developers, learn how to Enhance Google Workspace apps
# From Cloud Certification Help, consider Google Workspace Administrator Certification
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated June 23, 2023

# Lab Last Tested June 23, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# A Tour of Google Cloud Sustainability