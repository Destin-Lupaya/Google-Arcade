# Manage Data Models in Looker: Challenge Lab
# 1 hour 30 minutes
# Free
# GSP365
# Google Cloud self-paced labs logo

# Overview
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students who have enrolled in the Manage Data Models in Looker skill badge quest. Are you ready for the challenge?

# Topics tested
# Troubleshoot and fix LookML Code

# Create a refinement with an aggregate table

# Extend a view

# Create and apply a datagroup to LookML objects

# Group fields

# Utilize different parameters to customize LookML objects

# Setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# How to start your lab and sign in to Looker
# When ready, click Start Lab button.

# A new panel will appear with the temporary credentials that you must use for this lab.

# If you need to pay for the lab, a pop-up will open for you to select your payment method.

# Note your lab credentials in the left pane. You will use them to sign in to the Looker instance for this lab.

# Note: If you use other credentials, you will get errors or incur charges.
# Click Open Looker.

# Enter the provided Username and Password in the Email and Password fields.

# Important: You must use the credentials from the Connection Details panel on this page. Do not use your Google Cloud Skills Boost credentials. If you have your own Looker account, do not use it for this lab.
# Click Log In.

# After a successful login, you will see the Looker instance for this lab.

# Challenge scenario
# You have been hired as a LookML developer for a new cutting-edge e-commerce company. The company's infrastructure is run solely on Google Cloud and uses Looker for their data platform to analyze and integrate insights across different data sources.

# For your first assignment, you have been tasked with updating your company's existing LookML code base to reflect best practices and optimize performance to reduce cost and time to analyze the data. However, upon reviewing the code base, you've found numerous instances where certain code blocks were broken, incorrectly implemented, or simply do not adhere to Looker best practices. You have been instructed to update and fix this code to help your data analysis team leverage the Looker data without any issues.

# You are expected to have the skills and knowledge for these tasks, so step-by-step guides are not provided.

# Task 1. Create LookML objects
# When going through your company's LookML code base, you found a refinement that includes a weekly profit and revenue aggregate table. You assume that Looker will use this aggregate table for total profit and revenue queries that can leverage weekly granularity. The code for the refinement, however, contains errors and is only half-implemented. Furthermore, you also notice that the refinement contains objects that haven't been created yet.

# To start, you will first need to create these LookML objects and then fix the refinement and aggregate table in the next section.

# Inside of the order_items view, create a new dimension and a new measure that calculate profit and total profit.
# Requirements:

# Name these objects profit and total_profit.
# You need to use profit to create total_profit.
# For both profit and total_profit, set the value_format_name parameter to usd (US Dollars).
# Following best practices, you will need to add a description and label to both the measure and the dimension.
# Note: You can use SQL Runner to review the product table vs. the order_items table to help you determine which fields you should use to define these new LookML objects.
# Inside of the training_ecommerce.model file, create a new datagroup.
# Requirements:

# Name the datagroup: ___.
# Set a maximum cache age of one week (168 hours). For the purposes of this challenge, you do not need to include an sql_trigger. You may receive a warning message which you can ignore for the purposes of this lab.
# Set the ___ as the caching policy to use for all Explores in the model.
# Click Validate LookML to validate your code.

# Click Commit Changes and Push, then click Deploy to Production.

# Click Check my progress to verify the objective.
# Create LookML objects

# Task 2. Create and fix a refinement with an aggregate table
# Now that the objects referenced in the refinement and aggregate table have been properly created, you are ready to troubleshoot and fix the pre-existing code. In this section, you will be given broken LookML code for a refinement with an aggregate table that you will need to troubleshoot and fix. You will need to use the LookML objects you created in the previous section to complete this task.

# Start by copying the following code into the training_ecommerce.model file, under the Events explore:

# explore: +order_items {
#   label: ""
#   aggregate_table: weekly_aggregate_revenue_profit {
#     query: {
#       dimensions: []
#       measures: []
#     }
#   materialization: {
#     datagroup_trigger: weekly_datagroup
#     increment_key: ""
#     }
#   }
# }
# Copied!
# Click Save Changes then Validate LookML to see some of the errors that the code introduces.

# Fix the refinement and aggregate table LookML code. Requirements:

# Include a label for the refinement named: Order Items - Aggregate Profit and Revenue.
# The query for the aggregate table must include the following dimensions and measures from the order_items view: created_date, total_revenue, total_profit.
# A datagroup_trigger that references ___ (which you created in the previous section). Be sure to include a time increment that references created_date to identify the time step for appending new data.
# Click Commit Changes and Push, then click Deploy to Production.

# Create a visualization
# From the Order Items - Aggregate Profit and Revenue Explore, select Order Items > Created Date > Month, Total Revenue, and Total Profit. Make sure your Created Month column is in Ascending order.

# Create a Line visualization. It should resemble the following:

# A line visualization diagram with two trending lines for the months January-July..

# Save this visualization as a Look and name it: ___.
# Click Check my progress to verify the objective.
# Create a visualization

# Task 3. Extend a view
# Now that you have fixed the code for the refinement and aggregate table, you have been requested to create a separate view that contains users' personally identifiable information (PII) and can be extended from other views.

# This will enable future work to hide the PII from some teams, so that only people with certain levels of access will be able to see it. For the time being, all you need to do is create the extend for the PII and test that it can be extended from other views.

# In this task, you will create a new view that contains user PII dimensions and test that it works by extending it from the existing users view.

# Create new view named ___. Place it in the views folder.

# Remove all the placeholder code, and add the following dimensions: first_name, last_name, email, id, latitude, and longitude.

# Note: These dimensions are already defined in one of the existing views.
# Extend this view from the users view.
# Requirements:

# Set the id dimension as the primary key.
# Add the correct parameter to require extension for this view. The contents and settings of this view can only be used when the view is extended using the extends parameter in another view.
# Add the proper code to extend users.view using the ___ view.
# Hide the LookML code for the same PII dimensions in users.view.
# Run a query in the Explore to test that the dimensions are now provided from successfully extending users.view using the ___ view.
# Click Validate LookML to validate your code.

# Click Commit Changes and Push, then click Deploy to Production.

# Click Check my progress to verify the objective.
# Extend the view

# Task 4. Group similar fields in views
# For your final task, a data analyst on your team has requested you to group specific dimensions and measures for their business requirements. In this task, you will create two groups: one for general user information and one for product information. You will then add the associated dimensions and measures to each.

# Use the correct parameter to group the following dimensions in the users view into a new group named ___:

# Age
# City
# Country
# State
# Create another group named ___ that includes the following dimensions in the products view:

# Brand
# Category
# Department
# Name
# Verify these groups are working as intended in the Explore by running two separate queries (one in each view: users and products) using all of the dimensions in the newly created group.

# Click Validate LookML to validate your code.

# Click Commit Changes and Push, then click Deploy to Production.

# Click Check my progress to verify the objective.
# Group similar fields in views

# Congratulations!
# In this lab, you proved your LookML skills by troubleshooting and fixing LookML code to create a refinement with an aggregate table, extend a view, update and create dimensions and measures, and utilize grouping.

# skill badge png

# Earn your next skill badge
# This challenge lab is part of the Manage Data Models in Looker skill badge quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge.

# This skill badge quest is part of Google Cloud’s Data Analyst learning path. If you have already completed the other skill badge quests in this learning path, search the catalog for 20+ other skill badge quests in which you can enroll.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated February 7, 2023

# Lab Last Tested February 7, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.