# Filtering Explores with LookML
# 1 hour
# Free
# GSP892
# Google Cloud self-paced labs logo

# Overview
# Looker is a modern data platform in Google Cloud that lets you analyze and visualize your data interactively. You can use Looker to do in-depth data analysis, integrate insights across different data sources, build actionable data-driven workflows, and create custom data applications.

# So far you have created dimensions and measures, explored and joined views, and learned how to use derived tables - it's time to learn about filters. In this lab you will learn how to take your Explores to the next level by filtering them.

# Objectives
# In this lab, you will learn how to:

# Understand the different use cases for each filter

# Use the sql_always_where and sql_always_having filters

# Use the always_filter

# Use the conditionally_filter

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

# Task 1. Types of Explore filters
# To filter an Explore, you need to apply a default WHERE or HAVING clause to every SQL query that gets generated in that Explore. There are three principal ways to filter an Explore:

# sql_always_where and sql_always_having, which behave similarly and have the same use case
# always_filter
# conditionally_filter
# In the following sections you will learn about common use cases for each of these.

# The sql_always_where and sql_always_having filters
# Both sql_always_where and sql_always_having allow you to add filters to an Explore that cannot be modified. This is useful when you have certain rows of data you always want to exclude from the Explore results.

# The sql_always_where filter is used to add a WHERE clause applied to dimensions in a SQL query, whereas sql_always_having is used to add a HAVING clause applied to measures in a SQL query. In addition to queries run explicitly by business users, the restriction will apply to dashboards, scheduled Looks, and embedded information that relies on that Explore.

# There will be no indication of the filter in the user interface, so business users are not informed that the data are being filtered, unless they have permission to look at the generated SQL. This is useful if you want to filter out certain values of the Explore, such as test or internal data.

# The always_filter
# The always_filter enables you to require users to include a certain set of filters that you define. You also define a default value for the filters. Though users may change your default value for their query, they cannot remove the filter entirely. This is helpful when you want users to always filter by specific dimensions, such as always filtering by order status or user country, so that they do not request all of the possible data at one time.

# The always_filter has a sub-parameter to define the specific filters using the same Looker filter expressions that are used to filter dimensions and measures. The dimensions provided in the filters sub-parameter identify the dimensions that users must provide values for, such as a value for order status or user country.

# The specific values provided for in the filters sub-parameter are the default values which can be changed by the business user. For example, while the default order status is “Complete”, business users can change this value to say orders with a different status like “Returned”. For additional information, review the Looker filter expressions document.

# The conditionally_filter
# Similar to the always_filter, the conditionally_filter adds a filter to the Explore frontend that is accessible by business users. The conditionally_filter parameter enables you to define a set of default filters that users can override if they apply at least one filter from a second list that you define.

# Although users can indeed change the filter operator and values, they cannot remove the filter itself unless they put a filter on a specific alternative field. This is helpful when you want to limit the amount of data that an business user requests, but you also want to give them a list of alternative dimensions that they can use to filter the data.

# Conditionally_filter has a sub-parameter to define the specific filters as well as a sub-parameter to define the alternative dimensions that can be used to filter the data. For example, conditionally_filter can be used to create a filter that only returns data for the past 1 year, unless a filter is applied to a user ID or state dimension. This is typically used to prevent users from accidentally creating very large queries that may be too expensive to run on your database.

# Task 2. Add an always_filter
# In this section, you will add an always_filter to the Order Items Explore to require filtering on order status and user country, which are two key dimensions in the e-commerce dataset.

# First, on the bottom left of the Looker User Interface, click the toggle button to enter Development mode.
# The Development Mode toggle switched to on.

# Next, click the Develop tab and then select the qwiklabs-ecommerce LookML project.

# Navigate to the training_ecommerce.model file in the qwiklab_ecommerce project. Notice that the Order Items Explore does not currently have any filters.

# The training_ecommerce model opened, displaying several rows of data.

# Under the first line to define the Order Items Explore, add a new line and type always_filter followed by a colon (:) and curly braces ({}):

# always_filter: {}
# Copied!
# You will add code within these curly braces to define the filter.

# The training_ecommerce.model data, with the addition of the line: 'always_filter: {}'.

# Using the filters sub-parameter, define the filters to use status from the order_items table with a default value of “Complete” and country from the users table with a default value of “USA” using:

# filters: [order_items.status: "Complete", users.country: "USA"]
# Copied!
# Note: Recall that while the a value for the filter is required, business users will be able to provide different values for these dimensions.
# The training_ecommerce.model data, with the addition of the line: 'filters: [order_items.status:"complete", users.country: "USA"]'

# Click Save Changes.

# Click the caret next to the file title at the top of the IDE and then select Explore Order Items.

# The option 'Explore Order Items' highlighted within the training_ecommerce.model file's drop-down menu.

# Click on the arrow next to Filters to expand the window and see the two new filters with the default values:
# Order Items Status with a default value of Complete
# Users Country with a default value of USA
# Two filters listed; Order Items Status is equal to Complete, and Users Country is equal to USA.

# Under Order Items > Measures, click Order Count.

# Click Run. You should now see the number of completed order items within the USA. Notice how you cannot delete the filters, but you can modify them.

# The filter results: Order Items Order Count is equal to 151, 200.

# Change the filters. For the Status filter, change it to Processing. For the Country filter, change it to the UK.
# The filter results: Order Items Order Count: 134.

# Click Run. Your order items count should be updated along with the filters!

# Navigate back to the training_ecommerce.model file.

# Commit changes and deploy to production
# Click Validate LookML and then click Commit Changes & Push.

# Add a commit message and click Commit.

# Lastly, click Deploy to Production.

# Task 3. Add a sql_always_where filter
# In this section, you will add a sql_always_where filter to the Order Items Explore to only include data from the year 2021 and later. This is helpful if you have a large database spanning many years and only want to perform queries on the data for the current year and future years.

# Navigate back to the training_ecommerce.model file in the qwiklab_ecommerce project.

# Remove the filter you created in the previous section.

# Under the first line to define the Order Items Explore, add a new line and type sql_always_where followed by a colon (:):

# sql_always_where:
# Copied!
# Next, you will define the filter to only include data from the year 2021 and later using the created_date table.

# Add the following to your filter:

# sql_always_where: ${created_date} >= '2021-01-01' ;;
# Copied!
# The filter sql_always_where: ${created_date} >= '2021-01-01' ;; within the training_ecommerce model.

# Click Save Changes.

# Click the caret next to the file title at the top of the IDE and then select Explore Order Items.

# Note: Note that you don't see any filters. A sql_always_where condition is not displayed to the user, unless they look at the underlying SQL of any queries that they create.
# Under Order Items > Created Date, click Date.

# Under Order Items > Measures, click Order Count.

# Click Run. Notice that there are order items only from the date 2021-01-01 and later!

# The order items listed within two categories; the Created Date, and Order Count.

# On the Data bar, click the SQL tab. Notice there is the filter defined in the WHERE clause for all of the data.
# The SQL tab, with the WHERE filter set to '(CAST(order_items.created_at AS DATE)) >= '2021-01-01''

# Navigate back to the training_ecommerce.model file.
# Commit changes and deploy to production
# Click Validate LookML and then click Commit Changes & Push.

# Add a commit message and click Commit.

# Lastly, click Deploy to Production.

# Task 4. Add a sql_always_having filter
# In this section, you will add a sql_always_having filter to the Order Items Explore to prevent users from looking at orders with more than one item. This will be used to omit any orders from the Explore that have multiple items in them.

# Navigate back to the training_ecommerce.model file in the qwiklab_ecommerce project.

# Remove the filter you created in the previous section.

# Under the first line to define the Order Items Explore, add a new line and type sql_always_having followed by a colon (:):

# sql_always_having:
# Copied!
# Next, you will define the filter to only include the data with 1 order item, using the order_item_count measure:

# sql_always_having: ${order_item_count} = 1 ;;
# Copied!
# The training_ecommerce model's filter: 'sql_always_having: ${order_item_count} = 1 ;;'.

# Click Save Changes.

# Click the caret next to the file title at the top of the IDE and then select Explore Order Items.

# Note: Again, notice that you don't see any filters. A sql_always_having condition condition is not displayed to the user, unless they look at the underlying SQL of any queries that they create.
# Under Order Items, click Order ID.

# Under Order Items > Measures, click Average Sale Price and Order Item Count.

# Click Run. You should see the different orders and their respective average sale prices. As you can see, the items count is always equal to 1!

# The order items list, divided into three categories: Order ID, Order Item Count, and Average Sale Price.

# Navigate back to the training_ecommerce.model file.
# Commit changes and deploy to production
# Click Validate LookML and then click Commit Changes & Push.

# Add a commit message and click Commit.

# Lastly, click Deploy to Production.

# Task 5. Add a conditionality_filter
# In this section, you will add a conditionality_filter filter to the Order Items Explore to only return data for the past 3 years, unless a filter is applied to a user ID or state dimension.

# Navigate back to the training_ecommerce.model file in the qwiklab_ecommerce project.

# Remove the filter you created in the previous section.

# Under the first line to define the Order Items Explore, add a new line and type conditionally_filter followed by a colon (:) and curly braces ({}):

# conditionally_filter: {}
# Copied!
# You will add code within these curly braces to define the filter.

# Add the filters sub-parameter to define this filter.
# Here, you want the order created date to be in the past 3 years. You will also define the unless sub-parameter as an alternative dimension that can be used as a filter. For this, you will use the user ID and state dimensions:

# filters: [created_date: "3 years"]
# unless: [users.id, users.state]
# Copied!
# The filters used within the training_ecommerce model: 'filters: [created_date: "3 years"]' and 'unless: [users.id, users.state]'

# Click Save Changes.

# Click the caret next to the file title at the top of the IDE and then select Explore Order Items.

# Click on the arrow next to Filters to expand the window and see the conditional filter you created. Success!

# The conditional filter set to 'is in the past 3 years'.

# Next, under Order Items, click Order ID.

# Under Order Items > Created Date, click Year.

# Under Order Items > Measures, click Average Sale Price.

# Click Run.

# You can now see your created date is filtered in the past year in your Explore.

# The filter results, which list the orders created in the past year.

# You will now test the conditionality of the filter. Under Users, hover over State and click the filter button.
# The filter button highlighted within the State category.

# In the filter window, set the State filter to: California.

# Click the X next to the other filter to delete it.

# The Delete button highlighted within the filter, 'Created date = is in the past 3 years'.

# Click Run again.
# The orders listed within three cetegories; Order ID, Created Year, and Average Sale Price.

# Lastly, remove the State filter by clicking the X next to it to delete it. You will see the Created Date filter automatically appears again.
# The Create Date filter, which is currently set to 'is in the past 3 years'.

# Great! You just explored how conditional filters work. While you can change the default value that you set, you cannot completely remove the filter unless you apply at least one of the filters you specified in the unless sub-parameter.

# Navigate back to the training_ecommerce.model file.
# Commit changes and deploy to production
# Click Validate LookML and then click Commit Changes & Push.

# Add a commit message and click Commit.

# Lastly, click Deploy to Production.

# Click Check my progress to verify the objective.
# Add the conditionally_filter filter to the Order Items Explore

# Congratulations!
# In this lab, you learned how to filter Explores with LookML. Your first used the always_filter to require filtering on the order status and user country. You then used the sql_always_where and sql_always_having filters to filter the order creation date and the number of order items. Lastly, you used the conditionally_filter to filter the Order Items Explore to only return data for the past 3 years, unless a filter was applied to a user ID or state dimension.

# Finish your quest
# This self-paced lab is part of the Understanding LookML in Looker quest and Build LookML Objects in Looker quests. A quest is a series of related labs that form a learning path. Completing a quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in any quest that contains this lab and get immediate completion credit. See the Google Cloud Skills Boost catalog to see all available quests.

# Next steps / learn more
# LookML quick reference
# LookML terms and concepts
# Join the Looker Community
# Additional LookML basics
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual last updated July 14, 2023

# Lab last tested July 14, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.

# Lab
# A Tour of Google Cloud Sustainability