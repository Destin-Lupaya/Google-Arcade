# Finding Data in Google Sheets
# 1 hour
# Free
# GSP1063
# Google Cloud self-paced labs logo

# Overview
# For the labs in the Use Functions, Formulas and Charts in Google Sheets Quest, you read through a fictitious business scenario. By completing the various lab activities, you assist the characters with their Google Sheets usage.

# on-the-rise-bakery-logo.png

# Thomas Omar and Seroja Malone started On the Rise Bakery as a small family business to share their love of international flavors and nostalgic baked goods. They expanded from New York City to across North America and now have bakeries around the world. As the company has grown, they have hired staff to help oversee daily operations for multiple locations.

# In this lab, you search a Google Sheet to help On the Rise Bakery communicate changes to delivery dates to its customers.

# Prerequisites
# If you’re new to Google Sheets, the following courses are recommended: Google Sheets, Google Sheets - Advanced Topics.

# You may also find it helpful to complete the following lab: Google Sheets: Getting Started.

# Objectives
# Manipulate data in Google Sheets using the SPLIT and TRANSPOSE functions.

# Use the find and replace feature and the SUBSTITUTE function.

# Use VLOOKUP and modify a QUERY statement.

# Debug common Google Sheets function errors using IFERROR.

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

# Task 1. Manipulate data
# In this task, you use the SPLIT and TRANSPOSE functions to help On the Rise Bakery update its spreadsheet so it's easily understood.

# Use the SPLIT function
# To use the spreadsheet for this lab, go to Google Drive, and then double-click to open the On the Rise Bakery Bulk Orders file that has been created for you.

# In cell B1 of the Bulk Orders sheet, paste or type =SPLIT(A1, ",")

# The Bulk Orders sheet contains orders from customers as comma-separated values. Using the SPLIT function divides text around a specified character or string and puts each fragment into a separate cell in the row.

# To apply formula to the rest of the column, select cell B1, and then double-click the small blue box in the lower-right corner of the cell.

# Alternatively, you can click the small blue box in the cell, and then drag your cursor down.

# Right-click the column A label, and then click Hide column.

# You can also split clearly defined data, like text separated by commas, into several columns without using the SPLIT function. At the top, click Data > Split text to columns.

# To adjust the size of the column, hold your pointer over the dividing line between the column D label and column E label until a blue line appears, and then double-click.

# You can resize a column or row to ensure the full text is visible.

# Use the TRANSPOSE function
# At the bottom of the spreadsheet, click the sheet labeled New Order to view the record for a single customer.

# Notice that the data is arranged in a column, rather than a row.

# In cell A8, paste or type =TRANSPOSE(A1:A7)
# The TRANSPOSE function reorganizes data so the positions of rows and columns are swapped.

# Copy cells A8:G8.

# Return to the Bulk Orders sheet, click on cell B101, and then paste the data.

# After you paste the data, a clipboard (paste.png) should appear.

# Click the dropdown next to the clipboard, and select Paste values only.

# Paste values only pastes the data shown in the cells, not the underlying functions, or cell references.

# Click Check my progress to verify the objective.
# Upload a spreadsheet and manipulate data.

# Task 2. Find and replace data
# In this task, you help the staff update its records using both the find and replace feature and the SUBSTITUTE function.

# Use the find and replace feature
# On the Rise Bakery staff members are adding new muffin flavors to the menu. All existing orders are for blueberry muffins. Help the staff update the Bulk Orders sheet to specify the muffin flavor.

# To open the search box, press Control+F on your keyboard (or Command+F if you're using a Mac computer).
# Note: You can also use shortcuts for spreadsheets made by other companies in Google Sheets. At the top, click Help > Keyboard shortcuts > Enable compatible spreadsheet shortcuts.
# Click More options (more-icon.png).
# For Find, type Muffin, and for Replace with, type Blueberry Muffin.
# For Search, select This sheet, click Replace all, and then click Done.
# The find and replace feature is distinct from the FIND and SEARCH functions, which provide the position at which a string is first found within text.

# Use the SUBSTITUTE function
# On the Rise Bakery is closing early on the November 6th due to a bank holiday. All orders scheduled for that date must be rescheduled to the seventh.

# In cell I1, paste or type Adjusted Delivery Date

# In cell I2, paste or type =SUBSTITUTE(F2,"Nov-6","Nov-7")

# The SUBSTITUTE function searches for the specified text, which is in cell F2. If an exact match for Nov-6 is found, the date changes to Nov-7. If a match is not found, the value of the corresponding cell from column F is displayed.

# Apply the formula to the remaining cells in column I.

# Click Check my progress to verify the objective.
# Find and replace data.

# Task 3. Retrieve data using VLOOKUP and QUERY
# The bakery staff must search the sheet to answer customer inquiries and complete other business functions. In this task, you use the VLOOKUP and QUERY functions to retrieve data in the spreadsheet.

# VLOOKUP
# A customer called On the Rise Bakery to confirm the expected delivery date. VLOOKUP can be used to search for related information in a row.

# In cell J2, paste or type Georgia Nkosi

# In cell K2, paste or type =VLOOKUP(J2, G2:I100, 3, False)

# The VLOOKUP function requires three parameters: the key to search by, the range to search, and the column number of the information being searched. The fourth, and optional parameter,

# The column number is relative to the range provided. Adjusted Delivery Date is designated as the third column in the formula because the range used with VLOOKUP starts at column G.

# Note: In this task, you use VLOOKUP to retrieve data in a sheet. Google Sheets also supports functions like HLOOKUP and XLOOOKUP. To learn more, see LOOKUP.
# QUERY
# On the Rise Bakery wants to email a discount code for a future purchase to all customers who spent at least $500. In this task, you get a list of email addresses.

# In the lower-left of your spreadsheet, click Add Sheet (+) to add another sheet.

# Right-click the new sheet name, click Rename, and type Discount

# In cell A1 of the Discount sheet, paste or type =QUERY('Bulk Orders'!$B$2:$I$100, "select H where E > 500")

# The QUERY function uses the Google Visualization API Query Language and requires both a range and the search criteria.

# When referencing data contained in a different sheet, include the name of the source sheet, followed by an exclamation mark. If a sheet name contains spaces or other non-alphanumeric symbols, include single quotes around it (as shown in the provided query statement).

# (Optional) Modify the query statement to only retrieve email addresses if the customer spent more than $750.

# Click Check my progress to verify the objective.
# Use VLOOKUP and QUERY.

# Task 4. Use VLOOKUP with IF and ISERROR
# You used VLOOKUP to successfully retrieve information about an order in task three. In this task, you explore what you can do when you search for data with VLOOKUP and the record is not found.

# Debug errors in Sheets
# In cell J3 of the Bulk Orders sheet, type the name Alexander Jorgenson

# In cell K3, paste or type =VLOOKUP(J3, B2:I100)

# The text in the cell should show #N/A and a red error flag should appear in the upper-right corner of the cell.

# Hold your pointer over the red error flag to see the error message.

# The formula in cell K3 results in an error because it uses fewer arguments, or inputs, than required.

# In cell K3, paste or type =VLOOKUP(J3, B2:I100, 8)

# This updated formula includes three arguments, the last of which is the column number of the data that must be retrieved.

# Hold your pointer over the red error flag again.

# An updated error message should appear.


# Which of the following is the new error message?

# #REF!

# Wrong number of arguments to VLOOKUP. Expected between 3 and 4 arguments, but got 2 arguments.

# Alexander Jorgenson not found.

# Did not find value Alexander Jorgenson in VLOOKUP evaluation.

# When you use functions and formulas in Sheets, many errors can occur. When you encounter an error, be sure to read the full message so you can understand the problem. You can also reference the Google Sheets function list for function usage instructions.

# Handle errors with IFERROR
# In cell K4, paste or type =ISERROR(K3)

# The ISERROR function checks whether the provided value is an error.

# In cell K3, paste or type to =IFERROR(VLOOKUP(J3, B3:I100, 8), "Record not found")

# Notice that the red error flag does not appear in the cell. Also, observe how the values of cells K3 and K4 have changed.

# IFERROR evaluates whether the first argument is an error value. If it is not an error value, it returns that argument. Otherwise, IFERROR returns the second argument, so the text "Record not found" is displayed.

# Click Check my progress to verify the objective.
# Use IFERROR and ISERROR.

# Congratulations!
# In this lab, you learned how to rearrange, search, and substitute data using functions. You also learned how to debug errors in your spreadsheet.

# Finish your quest
# This self-paced lab is part of the Use Functions, Formulas and Charts in Google Sheets quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge, to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you've taken this lab. See other available quests.

# Take your next lab
# Continue your quest with Use Google Forms with Google Sheets and Pivot Tables in Google Sheets.

# Next steps/Learn more
# Check out the following for more information on Google Sheets:

# See the handy Sheets Cheat Sheet.
# Look like a pro when you know all the Workspace keyboard shortcuts.
# Did you know you could do this? See 21 Awesome Things Google Sheets Can Do – Tips & Tricks.
# See the Productivity Guides for what else you can do with Sheets.
# Visit the Google Workspace Learning Center to view Sheets tips, templates and more.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated 6 October, 2022
# Lab Last Tested 30 August, 2022
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.