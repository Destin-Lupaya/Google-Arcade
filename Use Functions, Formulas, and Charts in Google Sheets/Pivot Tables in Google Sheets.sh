# Pivot Tables in Google Sheets
# 1 hour
# Free
# GSP1065
# Google Cloud self-paced labs logo

# Overview
# For the labs in the Use Functions, Formulas and Charts in Google Sheets quest, you read through a fictitious business scenario. By completing the various lab activities, you assist the staff with their Google Sheets usage.

# on-the-rise-bakery-logo.png

# Thomas Omar and Seroja Malone started On the Rise Bakery as a small family business to share their love for international flavors and nostalgic baked goods. They expanded from New York City to across North America and now have bakeries around the world. As the company has grown, they have hired staff to help oversee daily operations for multiple locations.

# In this lab, you use pivot tables and statistical formulas to help On the Rise Bakery analyze data about visitors to its food blog.

# Objectives
# You learn how to perform the following tasks:

# Apply formatting to cells, rows, and columns.

# Calculate descriptive statistics like AVERAGE, MEDIAN, and MODE.

# Create a pivot table and reference data by using named ranges.

# Use collaboration features in Sheets.

# Prerequisites
# If you're new to Google Sheets, the following courses are recommended: Google Sheets, Google Sheets - Advanced Topics.

# It might be helpful to complete the following lab: Google Sheets: Getting Started.

# Setup and requirements
# Before you click Start Lab
# Read these instructions. Labs are timed and you cannot pause them. The timer starts when you click Start Lab and shows how long Google Workspace resources are available to you.

# This Google Workspace hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Workspace for the duration of the lab.

# What you need
# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Time. Note the time at the top of the left panel, which is an estimate of how long it should take to complete all steps. Plan your schedule so you have time to complete the lab. Once you start the lab, you will not be able to pause and return later (you begin at step 1 every time you start a lab).
# You do NOT need a Google Workspace account. An account is provided to you as part of this lab.
# Open an Incognito window to run this lab.
# When your lab prompts you to log into the console, use only the student account provided to you by the lab. This allows the activity tracking to verify that you have completed the lab activities.
# Start your lab
# When you are ready, click Start Lab in the upper left panel.

# Find Your Lab's User Email and Password
# To access the resources and console for this lab, locate the User Email and Password in the left panel. These are the credentials you use to log in to Google Drive.

# Sign in to Google Drive
# Click Open Google Drive.
# Tip: Open the tabs in separate windows, side-by-side.

# Notice the Email or phone field has been pre-filled with the User Email. Click Next.

# Enter the Password and click Next.

# Accept all terms and conditions as prompted.

# Google Drive opens and you are signed in to the Student Google Account.

# Task 1. Customize a sheet
# In this task, you customize a sheet by applying formatting to cells, rows, and columns.

# Import a spreadsheet
# Click On the Rise Bakery Web Traffic to download a spreadsheet.

# The spreadsheet includes data for the 25 cities with the highest number of visitors to the food blog for On The Rise Bakery. Note that this is an Excel spreadsheet, not a Google Sheets file.

# In the left panel of the lab instructions, right-click Open Google Sheets, and then click Open link in incognito window to sign into your student account.

# In the top left, under Start a new spreadsheet, click + to open a blank spreadsheet in a new browser tab.

# At the top, click File > Import.

# The Import file dialog opens.

# Click the Upload tab.

# To upload the file, drag the file from step 1 into the upload window or select the file from your device.

# In the Import location dropdown, select Replace spreadsheet, and then click Import data.

# At the top, change the filename from Untitled spreadsheet to On the Rise Bakery Web Traffic

# Text wrapping
# Wrapping text lets you show the full contents of a cell without increasing the width of the column.

# Click the gray column B label to select all items in the column.

# In the toolbar, click Text wrapping (text-wrapping.png), and then click Wrap (wrap.png).

# To increase the size of a column, mouse over the gray column label until a blue line appears, and then drag your cursor to the right.

# Create a new line
# Sometimes data must be displayed on separate lines within a single cell. You can create a new line in a cell regardless of whether you’re already using text wrapping.

# In cell C21, place your cursor before the word East.

# To insert a line break, press CTRL+ENTER on your keyboard.

# Align text vertically
# The vertical align tool lets you choose whether you want your text to be aligned to the top, bottom, or middle of the cell.

# To select all rows in columns A-F, click the gray column A label, and then drag your cursor to the right.

# To vertically align the text in the center of each row, click the vertical align icon (vertical-align.png) and then click the middle icon (vertical-align-center.png).

# Click Check my progress to verify the objective.
# Customize a sheet.

# Task 2. Create a summary table
# In this task, you create a customized table for On the Rise Bakery.

# Use the ROUND function
# In cell G1, type Number of Visitors (Rounded)

# In cell G2, type =ROUND(F2, 3)

# The ROUND function rounds a number to a specific number of decimal places. Since F2 does not contain any decimals, the values of F2 and G2 are equal.

# In cell G2, change the formula to =ROUND(F2, -3)

# When the number of decimal places becomes a negative number, the result is rounded by numbers to the left of the decimal point. Specifying -3 rounds to the nearest thousand.

# To apply formula to the rest of the column, select cell G2 and then double-click the small blue box in the lower-right corner of the cell.

# Alternatively, you can click the small blue box in the cell, and then drag your cursor down.

# Merge cells
# In cell A29, type Descriptive Statistics

# Notice that the word Statistics spills over into cell B29.

# Select cells A29 and B29.

# At the top, click Format > Merge cells > Merge horizontally.

# You can also use the Merge cells icon (merge.png) in the toolbar.

# Change the appearance of cells
# Copy the following list, click cell A30, and then paste the list.

# Average (Mean)
# Median
# Mode
# Range
# Standard Deviation
# Notice that each item from the list was pasted into its own cell and the bullet points were not pasted.

# Select cells A29:B34, and then at the top, click Format > Alternating colors.

# The Alternating colors feature changes the colors of every other row in the chart. To change the color of an individual cell or group of cells, you can use the color fill (format-color.png) tool in the toolbar.

# While cells A29:B34 are still selected, click the Borders icon (border.png) in the toolbar, and then click the Outer borders icon (border-outer.png) to add a border.

# The border editing options let you format anything from a specific edge of a cell to an entire spreadsheet including the line style and line color.

# Click Check my progress to verify the objective.
# Create a summary table.

# Task 3. Calculate descriptive statistics
# In this task, you perform calculations by using basic arithmetic operations and statistics functions.

# Define a named range
# Named ranges in Google Sheets let you more easily reference ranges and create cleaner formulas.

# At the top, click Data > Named ranges.

# A panel will open on the right.

# At the top of the panel, click + Add a range.

# Change the name from NamedRange1 to data, type 'Blog Visitors'!F2:F26, and then click Done.

# You can use a named range to replace a range in a formula. For example, instead of typing the formula =AVERAGE(F2:F26), you can type =AVERAGE(data) and get the same result. You learn more about calculating averages in the next step.

# Calculate mean, median, and mode
# To calculate the mean population, in cell B30, type =AVERAGE(data)

# In Google Sheets, the AVERAGE function is used to calculate the mean.

# To calculate the median, in cell B31, type =MEDIAN(data)

# To calculate the mode, in cell B32, type =MODE(data)

# The MODE function determines the most commonly occurring value in a dataset. Each value in column E only appears once, so there’s no mode. As a result, you see an error message instead of a number.

# In cell B32, change the formula to =MODE(G2:G26) to calculate the mode based on rounded data.

# In column G, there’s a value that appears more than others, so a mode can be determined.

# Calculate range and standard deviation
# In cell B33, type =MAX(data) - MIN(data) to calculate the range.

# In cell B34, type =STDEV(data)

# Standard deviation represents the average distance between the values in a dataset and the mean of the dataset.

# Click Check my progress to verify the objective.
# Calculate descriptive statistics.

# Task 4. Work with pivot tables
# You can use pivot tables to narrow down a large dataset or see relationships between data points. In this task, you create a pivot table that uses the web traffic data from the food blog.

# Create a pivot table
# Pivot tables summarize data in your spreadsheet by automatically aggregating, sorting, counting, or averaging the data and displaying the results in a new table.

# At the top, click Insert and then Pivot table.

# A dialog will appear.

# Type 'Blog Visitors'!A1:F26 as the data range.

# For the Insert to option, select New Sheet, and then click Create.

# A new sheet titled Pivot Table 1 is created.

# Click the Pivot Table 1 sheet, if it's not already open, and then find the Pivot table editor in the right panel.

# Click Sum of Number of Unique Visitors for each Region from the Suggested list, and then expand the width of column A.

# A pivot table acts as a sort of query against a source dataset. Depending on the data you choose, Sheets might recommend pivot tables to create.

# At the top, click Format > Theme, and then choose an available theme to change the appearance of your sheet.

# Manually create a pivot table
# At the top, click Insert and then Pivot table.

# A dialog will appear.

# Type 'Blog Visitors'!A1:F26 as the data range.

# For the Insert to option, select Existing Sheet, type 'Pivot Table 1'!A17 in the field, and then click Create.

# In the Pivot table editor panel, click Add next to Rows, and then select Continent.

# To add data to column B, click Add next to Rows, and then select City.

# To display the counts of locations in each city and the total number of locations per continent, click Add next to Values, and then select City.

# The Values section of the Pivot table editor includes several options to summarize data by. Explore the options, and then answer the following question.


# Which of the following calculations is NOT an option to summarize by?

# MEDIAN

# PRODUCT

# RANGE

# COUNTUNIQUE

# Task 5. Collaborate in Sheets
# In this task, you use Google Sheets features designed for collaboration to track a project.

# Use checkboxes
# You can add checkboxes to cells in a spreadsheet and use them for many purposes like checking off a to-do list.

# In the lower-left of your spreadsheet, click the Add Sheet icon (+) to add another sheet.

# Right-click the new sheet name, click Rename, and type To-Do List

# In cell A1, type Description

# Copy this list, select cell A2, and right-click to paste:

# Create Schedule
# Create Budget
# Design Charts
# Ensure that each item in the list is pasted in its own cell in Column A.

# Select cells B2:B4, and then at the top, click Insert > Checkbox.

# To mark the item complete, click the checkbox in cell B3.

# Note: Sheets also lets you use custom cell values with checkboxes. See Add custom checkbox values for more information.
# Create action items
# Copy the User Email in the left panel of this lab.

# This email address is the same one you used to log in to Google Workspace at the beginning of the lab.

# Return to the To-Do List sheet, right-click on cell A2, and then select Comment.

# Type @, paste your User Email, and then type Deadline: Next Monday

# Check the Assign to you box, and then click Assign.

# You can use comments to assign tasks or action items to yourself or other collaborators.

# In the upper-right corner of the page, click the Open comment history icon (comment.png) to view all comments.

# To filter comments, you can click the dropdowns next to All and All sheets.

# View changes to a file
# To see who changed a cell and when it was changed, right-click cell A1, and click Show edit history.

# To see an earlier version of your spreadsheet, at the top, click File > Version history > See version history.

# The Version history should appear in the right panel. You can use the options in this panel to view or revert to earlier versions of a Sheets file.

# Select the second version in the list, click More actions (more-icon.png), and then click Name this version.

# To add a version name, type Action Items, and press ENTER on your keyboard.

# Click More (more-icon.png) to review the updated menu options, and then answer the following question.


# Which of the following options was added to the menu?

# Restore this version

# Remove name

# Make a copy

# Rename

# Note: You can also see who has viewed or shared a file by using the Activity dashboard. Read View the activity on your Google Docs, Sheets & Slides for more information.
# Click Check my progress to verify the objective.
# Collaborate in Sheets.

# Congratulations!
# In this lab, you formatted a spreadsheet, calculated descriptive statistics by using named ranges, and created a pivot table. You also learned to collaborate in Sheets by using checkboxes, action items, and more.

# Finish your quest
# This self-paced lab is part of the Using Functions, Formulas and Charts in Google Sheets quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge, to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you've taken this lab. See other available quests.

# Looking for a hands-on challenge lab to demonstrate your skills and validate your knowledge? On completing this quest, finish this additional challenge lab to receive an exclusive Google Cloud skills badge.

# Next steps / Learn more
# See the following for more information on Google Sheets:

# See the handy Sheets Cheat Sheet.
# Look like a pro when you know all the Workspace keyboard shortcuts.
# See the Productivity Guides for what else you can do with Sheets.
# Visit the Google Workspace Learning Center to view Sheets tips, templates and more.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated October 25, 2022
# Lab Last Tested September 1, 2022
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.