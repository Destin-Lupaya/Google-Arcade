# Google Workspace Admin: Provisioning
# 1 hour 15 minutes
# 1 Credit
# GSP676
# Google Cloud self-paced labs logo

# Overview
# In this lab, you use Google Workspace to provision groups and calendar resources. As a single Google Workspace account supports multiple domains, you also learn how to add (or provision) an additional domain in your organization.

# Objectives
# In this lab, you do the following using the Google Workspace Admin Console:

# Create Google Groups

# Create a Calendar resource

# Add a domain to your Google Workspace organization

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
# Task 1. Google Workspace groups
# With Google Workspace, your organization can use groups to easily communicate and collaborate across teams. In this section, you create two different types of Google Groups from the Admin console, one that includes everyone in your organization, and one that's restricted to invite only.

# Create an announcement group
# Start by creating an announcement group which automatically includes all existing and future members of your organization.

# From the Admin console, click the Groups card. You may have to click Show more at the bottom of the dialog to see the Groups card.

# Click Create Group.

# In the Name field, enter Everyone.

# In the Group email field, enter everyone.

# In the Group owner field, enter your student email address, which is the User Email on the page where you started the lab.

# Note: If you start to type the User Email address, the option becomes available. Type "st" and see what happens!
# Click Next.

# Choose the Access type of Announcement only. Leave all other fields at their default value and click Next.

# Leave all fields at their default value. Click Create group.

# Under What you can do next, click Add members to Everyone.

# Click Add members, then click Advanced at the bottom of the Add members to Everyone dialog box.

# Select the Add all current and future users of 'your organization' to this group with All Email setting box.

# Click Add to group.

# Congratulations, you have created your first Google Group. By default, only group owners and managers can post to this group but everyone in your organization can view the posts.

# Verify that you can see All users in the organization in the Member list and that you are shown with the Owner role. You may have to reload the browser tab to see All users in the organization.

# Create a restricted group
# You've created a group that includes everyone, but not all communication is meant for everyone. A restricted group allows you to customize membership and access to others in the group.

# In this section you create a restricted group for use by your company’s executive. When you create this group, you restrict membership to invited users only and restrict who can contact the group owners.

# Click Main menu (The Navigation menu icon.) > Directory > Groups, and then click Create group.

# In the Name field, enter Executive.

# In the Group email field, enter executive.

# In the Group owner field, enter your student email address and then click Next.

# In the Access type > Access settings table, deselect all entries in the Entire Organization column.

# Note: The group type automatically changes to ‘Custom’ group once you start to change the default access settings. Also, when you prevent anyone in your organization from contacting the group owners, external users are also prevented from doing the same.
# Scroll down and change the Who can join the group setting to Only invited users and then click Next.

# Leave all fields at their default value.

# Click Create group.

# Click Done.

# Verify groups access
# In this lab you will not be able to test mail delivery to Google Groups, but take a look at the expected behavior for each of the two groups created earlier.

# Imagine you have three users: Sue, John, and Marco. The table below shows the role each user has for each of the two groups.

# Sue	John	Marco
# Everyone	Manager	Member	Member
# Executive	Manager	Member	Not a Member
# Sue sends an email message to each of the two groups. As Sue is a manager of both groups, her emails are delivered successfully.

# John sends an email message to each of the two groups. His message to the Everyone group is rejected because only Owners and Managers can post to this group. His message to the Executive group is delivered successfully.

# Finally, Marco also sends an email message to each of the two groups. Like John, Marco’s message to the Everyone group is rejected because only Owners and Managers can post to this group. As Marco is also not a member of the Executive group, his message to this group is also rejected.

# Click Check my progress to verify the objective.
# Google Workspace groups

# Task 2. Use Workspace to share resources
# You can use Google Workspace to set up Calendar so users can book shared company resources. Example resources are rooms, projectors, company cars, or bicycles.

# In this section, you create a Calendar resource to represent a company resource. Users in your organization will be able to view and book the resource in Calendar.

# Create a Calendar resource
# The most common example of a Calendar resource is a physical room to meet in. In this section, you create a Google Calendar resource for a meeting room in your organization. Users will see details like the building and floor where a room is located and the key features such as video conferencing equipment or whiteboards.

# Define your building
# Before adding your room as a Calendar resource, add your organization’s buildings to the Admin console. This acts as a location to which your resource will be associated.

# Click Main menu (The Navigation menu icon.) > Directory > Buildings and resources > Manage resources.

# In the breadcrumbs at the top, click Resources > Buildings.

# The highlighted file path to the option Buildings.

# Click Add building.
# Complete the building information:
# Name
# (Optional) Description
# Floors
# (Optional) Address. Click the Pencil icon to add your organization’s address.
# Click Add building.
# The Building list opens with the building you just created listed.

# Optional: Can you define another building?

# Create a Calendar resource
# In this section you define your resource as a Calendar resource.

# In the breadcrumbs at the top, click Buildings > Resources.
# Click the plus sign in the yellow circle, Add new resource.
# Set the required fields as follows:
# Category: Meeting space (room, phone booth,...)
# Building: Pre-filled with the building you created in the previous section, or use the drop down to select a building
# Floor: Pick a floor
# Resource name: Name the resource, for example Interview Room
# Capacity: The capacity of the room, for example 5
# Optional: Feel free to add data to the optional fields
# Click Add Resource.
# The Resource list opens and lists your new resource.

# Check it out: Open Google Calendar and schedule an event.
# Click Rooms at top right panel to see your meeting space listed.
# Optional: See if you can create a bike as a Calendar resource.

# Hint: The Category would be Other resource.

# Create a resource feature
# Next, create some features you can associate with your resources. For example, does your meeting room have a smart board? Does it have a refreshment station? Noting amenities in the room is helpful to anyone booking the room for a meeting.

# In this section you create a feature. You start at the Building list. Start at the Admin console home page Main menu (The Navigation menu icon.) > Home.

# From the Admin console Home page, click the Buildings and resources card. You may have to click Show more and then scroll down to see the card.
# In the Resource management card, click Open.
# Click Manage resource features (Manage resource features icon) on the top right.
# Click Add Feature and then complete the resource information:
# Feature name: Name the feature, for example Refreshment Station.
# Feature type: Use the dropdown to select the appropriate type, for example Other.
# Click Save.
# See the feature listed in the Resource features list.

# Click Close. This returns you to the Resource list.
# Optional: Can you create another resource, maybe video conferencing equipment for your meeting room, or a bike helmet for your bike?

# Associate the resource feature to the Calendar resource
# You made the feature, now associate it with the Calendar resource.

# Click a resource in the Resource list.
# Click the Features card.
# Click Search features and select a feature from the dropdown and click Save.
# In the breadcrumbs at the top, click the resource to view the resource overview. Notice the feature you added in the Features card.
# Optional: If you created another resource in the last section, can you associate it with a Calendar resource?

# Verify resource in Google Calendar
# You created the Calendar resource, now verify the resource by booking it in Google Calendar.

# Open Google Calendar.

# Create a new event. (Click the Create or anywhere under a day, and then More options at the bottom left of the dialog that opens.)

# Click the Rooms tab. The resource or resources you created are listed under Available rooms.

# Click to reserve the resource for your event. Hover over the resource to view more details, including any features you added.

# Note: It may take a short while for the newly created resource to be visible in Google Calendar.
# Click Check my progress to verify the objective.
# Use Workspace to share resources

# Task 3. Add a secondary domain or a domain alias
# If you own another domain, you can add it to your Google Workspace account. For example, you might manage multiple businesses or brands, each with their own domain. Depending on your needs, you can add a domain as a domain alias or a secondary domain.

# A secondary domain is a separate domain with its own set of users. A domain alias gives users in your primary domain an email address at the alias domain. Whether you add a secondary domain or a domain alias, Google requires that you verify domain ownership.

# The process for adding a secondary domain and a domain alias is the same. In this section, you walk through the steps to add a secondary domain.

# Add the domain
# Add a secondary domain to your Google Workspace account.

# From the Admin console home page Main menu (The Navigation menu icon.) > Home.

# On the Domains card, click Manage domains.

# Click Add a domain.

# Enter any domain name (do not use a domain name that you own), then click Add Domain & Start Verification.

# Note: Google now needs to verify that you own the domain. In this lab, you do not actually verify ownership of the domain. Instead you walk through the process so you understand the steps needed to add a domain to your own Google Workspace account.
# The recommended way to verify your domain is to add a TXT record to your DNS records.

# Click Continue.
# The next page provides a unique Google site verification code and a set of instructions on how to add your verification code to your DNS records. At this stage you would copy the site verification code, sign into your domain registrar and add your new TXT record. DO NOT do that now. Instead, assume you have done it and continue with the lab.

# Click Verify my domain.
# Google now attempts to find the TXT record in your DNS to verify that you own the domain name you entered earlier.

# Click the X in the top left corner of the page to close the verification page.
# Confirm that you can see the new domain in your domain list.
# Note how the Domain status is Verify domain. This is expected as Google has not been able to verify the domain.

# Click Check my progress to verify the objective.
# Add a secondary domain or a domain alias

# Task 4. Check your learning

# Why would you create a Workspace group?

# To easily communicate and collaborate across teams.

# To easily communicate and collaborate only within a team.

# To ensure all team members have the same access to all communication.

# So that any team member could add external partners to the Group to ensure inclusive communication


# True or False: You can create a Group for a team, and also add someone outside the team to the Group.

# True

# False


# In Workspace, you can use Calendar to:

# Set who can use the resource.

# Schedule a resource and then add features to the resources.

# Know when a resource needs maintenance.

# View and schedule resources at a location.


# When scheduling a resource in Calendar, how do you know what features are included?

# Calendar type indicates what features are included.

# You don’t, when you schedule a resource, you fill out a questionnaire that determines what features are needed.

# Hover over the resource to view the resource details, which includes the features.

# You don’t, you schedule the feature you want first, and then Calendar displays the resources that include the feature.


# True or False: You can add only verified domains as a secondary domain or domain alias.

# True

# False


# True or False: A domain alias gives users in your primary domain an email address at the alias domain.

# True

# False

# Congratulations!
# In this lab you’ve practiced using tools a Google Workspace Administrator uses to create Google groups and Calendar resources. You have also seen how simple it is to add a secondary domain to your Google Workspace account.

# With this practical hands-on experience you should feel comfortable getting started with a new Google Workspace deployment, or doing further training in Google Workspace administration.

# Finish your quest
# This self-paced lab is part of the Google Workspace for IT Admin quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest or any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost Catalog to see all available quests.

# Take your next lab
# Continue your Quest with Google Workspace Admin: Managing Applications

# Next steps / learn more
# Refer to the following Help Center articles to learn more about Google Workspace provisioning:

# Google Groups admin help
# Manage Calendar resources
# Add multiple domains or domain aliases
# Explore Additional G Suite Training

# Visit the Workspace Learning Center

# Learn how to Develop Extensions and Add Ons to Workspace

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated Jan 2, 2023

# Lab Last Tested Jan 2, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# A Tour of Google Cloud Sustainability