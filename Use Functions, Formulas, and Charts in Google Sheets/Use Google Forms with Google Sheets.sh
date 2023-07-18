# Use Google Forms with Google Sheets
# 1 hour
# Free
# GSP1064
# Google Cloud self-paced labs logo

# Overview
# For the labs in the Use Functions, Formulas and Charts in Google Sheets Quest, you read through a fictitious business scenario. By completing the various lab activities, you assist the characters with their Google Sheets usage.

# on-the-rise-bakery-logo.png

# Thomas Omar and Seroja Malone started On the Rise Bakery as a small family business to share their love of international flavors and nostalgic baked goods. They expanded from New York City to across North America and now have bakeries around the world. As the company has grown, they have hired staff to help oversee daily operations for multiple locations.

# Google Forms lets you easily create and share online forms and surveys and analyze responses in real time.

# In this lab, you learn how to create, edit, and share an online survey using Google Forms. You learn how to implement validation and conditional logic in surveys. You also use Google Sheets to analyze survey responses.

# Objectives
# In this lab, you learn how to perform the following tasks:

# Create a Google Form.

# Use branching logic and response validation in a Google Form.

# Analyze data in Google Sheets using functions such as OR and COUNTIF.

# Prerequisites
# If you're new to Google Sheets, the following courses are recommended: Google Sheets, Google Sheets - Advanced Topics.

# You might also find it helpful to complete the following lab: Google Sheets: Getting Started.

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

# Task 1. Create a survey using Google Forms
# On the Rise Bakery is expanding to a new city and wants to conduct market research. Help the staff to create a survey for prospective customers to share which foods they are interested in.

# Open Google Forms
# To open Google Drive, click drive.google.com.

# In the left panel, click + New, and then click Google Forms icon Google Forms > Blank form.

# A new web page containing a blank Google Form should open.

# To name the form, in the upper-left corner, click Untitled form, and type On the Rise Bakery Survey

# Notice the updated file name also appears on the form.

# For Form description, type The purpose of this survey is to gauge the pastries and other food items of interest to our potential customers.

# Create survey questions
# Click Untitled Question, and then type First Name (required)
# Change the question type from the default to Short answer.
# To create a second question, click Duplicate (content-copy).
# Change the text to Last Name (required)
# Click Add question (add-circle), and then create three additional questions with these parameters:
# Question	Answer Format
# Email Address	Short Answer
# What are your favorite items to buy at a bakery? (Choose up to three)	Checkboxes with these five options:
# Muffin
# Donuts
# Donut Holes
# Plain Bagel
# Bagel with Egg and Cheese
# What time do you expect a bakery to open/close?	Short answer
# Question Types
# Google Forms supports several question types. You can:

# Type an answer using short answer or paragraph text

# Choose a response from a list using multiple choice, checkboxes, or dropdown options

# Upload files

# Choose from a grid

# Select a date and time

# To learn more, check out Choose a question for your form.

# Click Check my progress to verify the objective.
# Create a Google Form.

# Task 2. Submit survey responses
# In this task, you submit sample entries to the Google Form to analyze in a later step.

# Review sharing options
# Click Send.

# The checkbox lets you automatically collect the email address of a respondent if they are in your same domain.

# For Send via, there are three options:

# Email (mail.png): This option lets you specify email addresses, a subject, and message text. It also lets you include the form in the email itself, instead of sending a link to the form.
# Hyperlink (hyperlink-icon.png): This option provides a link to share. You can check the Shorten URL box to create a shorter link and click Copy to add the link to your clipboard.
# HTML code (code-icon.png): This option provides code for embedding this Google Form into a web page.
# Note: You can also share a form for others to edit. See Share your form with collaborators.
# To close this window, click Cancel.

# View and answer the survey
# To view and respond to the survey in a new tab, click Preview (eye-icon.png).
# Provide the following information:
# Question	Response
# First Name	Chigo
# Last Name	Williams
# Email Address	cwilliams@mail.com
# Favorite items	Bagel with Egg and Cheese
# Preferred bakery hours	5am-3pm
# Click Submit.

# To provide a second sample, click Submit another response.

# Repeat steps 2 and 3 with the following information:

# Question	Response
# First Name	Lauren
# Last Name	Rodriguez
# Email Address	laurenr1980@mailcom
# Favorite items	Donuts, Donut Holes
# Preferred bakery hours	6am
# To provide a third sample, click Submit another response.
# Repeat steps 2 and 3 with the following information:
# Question	Response
# First Name	Josephine
# Last Name	
# Email Address	josieyu@mail.com
# Favorite items	Donuts, Donut Holes, Plain Bagel, Muffin
# Preferred bakery hours	6am-12pm
# Notice that you can submit the surveys despite missing required data such as last name and selecting more than the limit of three bakery items.

# When all the survey responses have been submitted, close this tab.

# Task 3. Analyze survey data in Sheets
# In this task, you explore a few Google Sheets functions. To learn more about functions, visit the Google Workspace Learning Center.

# Review survey responses
# Return to the editor view of your form. If you've exited, visit Google Forms to reopen it.

# In the top pane, click Responses.

# Your form should have three responses.

# Click Summary for an overview of the survey responses in charts and tables.

# Click Question to display the responses grouped by question.

# Click the dropdown or arrows to display the responses to each question.

# Click Individual to display the form submission for each respondent.

# When toggled off, the Accepting responses option closes the survey and prevents any future submissions. Leave this setting toggled on.

# Note: You can insert charts from Google Forms into other Google Workspace products. See Embed linked Google Forms charts into Google Docs, Google Slides, and Google Drawings.
# View responses in Sheets
# On the Responses tab, in the upper-right, click Create Spreadsheet (sheets-icon.png).

# In the Select response destination dialog, accept the default for Create a new spreadsheet, and click Create.

# A new spreadsheet with the filename On the Rise Bakery Survey (Responses) should open.

# At the bottom of the spreadsheet, click the down arrow next to the Form Responses 1 label, and then click Duplicate.

# Click Check my progress to verify the objective.
# Create a spreadsheet with survey responses.

# Analyze responses using OR
# Follow this procedure in the duplicate sheet of your spreadsheet.

# In cell G1, type Missing Full Name?

# In cell G2, type or paste =OR(ISBLANK(B2), ISBLANK(C2))

# This formula flags any rows that are missing a first name or last name.

# Click cell G2, and then point to the small blue box in the lower-right corner of the cell until your cursor appears as a cross (+).

# Drag your mouse down to the remaining rows in the column to apply the formula to those cells.

# Analyze responses using COUNTIF
# In cell H1, type Interest in Donuts

# In cell H2, type or paste =COUNTIF(E2,"*Donuts*")

# This formula counts any cells in column E that contain the word Donuts.

# Click cell H2, and then apply the formula to the remaining rows in the column.

# Click Check my progress to verify the objective.
# Analyze responses using OR and COUNTIF.

# Task 4. Add response validation to a Google Form
# In the earlier section, you bypassed a rule intended to require respondents to provide a first and last name. The response validation feature can help enforce the guidelines that you want respondents to adhere to.

# Require responses to questions
# When a question is required, a red asterisk appears next to the question. If you try to proceed without answering a required question, you’re prompted to provide a response.

# Return to the On the Rise Bakery Survey in Google Forms.

# In the text of the first question, delete (Required), and then click the Required slider (slider-icon.png) to enable it.

# In the text of the second question, delete (Required), and then click the Required slider (slider-icon.png) to enable it.

# In the top pane, click Settings.

# Underneath Question Defaults, click the Make questions required by default slider (slider-icon.png) to enable it.

# Note: This setting only applies to new questions and does not change the requirement for existing questions.
# Add email validation
# In the top pane, click Questions.

# Select the third question to show editing options for email.

# To display additional options, click more (more-icon.png), and then select Response validation.

# In the first dropdown that appears, select Text.

# In the second dropdown, select Email.

# Select "at most" validation
# Select the fourth question to show more editing options.
# Click more (more-icon.png), and then select Response validation.
# In the first dropdown that appears, select Select at most, and then for Number, type 3
# Click Check my progress to verify the objective.
# Make questions required and use response validation.

# Task 5. Show questions based on answers
# In this task, you set up branching in the Google Forms survey so that respondents only see certain sections based on their answers.

# Use more answer types
# In the text of the fifth question, delete /close, so the question now reads What time do you expect a bakery to open?

# From the dropdown of question types, select time Time.

# Click Add question (add-circle), and add a sixth survey question: What time do you expect a bakery to close?

# From the dropdown of question types, select Dropdown, and then type the following answer choices:

# 11 AM
# 12 PM
# 1 PM
# 2 PM
# 3 PM
# Create a new section
# To create a new section of the form, click Add section (add-section).

# Change the section title to Afternoon Treats

# Click Add question (add-circle), and add a new question: What are your favorite items to buy at a bakery in the afternoon? (Choose up to three)

# From the dropdown of question types, select Checkboxes, and then type the following answer choices:

# Sandwich
# Soup
# Salad
# Donuts
# Plain Bagel
# Click more (more-icon.png), and then select Response validation.

# In the first dropdown that appears, select Select at most, and then for Number, type 3

# Note: Google Forms supports rich text formatting which lets you add emphasis to your survey titles and descriptions. Visit the Google Workspace Updates blog to learn more.
# Customize follow-up questions
# For the sixth question in Section 1 of the survey, which reads What time do you expect a bakery to close?, click more (more-icon.png), and then select Go to section based on answer.

# From the dropdown next to 11 AM, select Submit form.

# To view and respond to the survey in a new tab, click Preview (eye-icon.png).

# Answer the survey questions with responses of your choice, and for the bakery closing time, select 11 AM.

# Click Next, and then click Submit.

# Notice that you are not asked the question about afternoon snacks.

# Click Submit another response.

# Answer the survey questions in Section 1 with responses of your choice, and for the bakery closing time, select 12 PM or later.

# Click Next, and then answer the question in Section 2.

# Click Submit.

# Click Check my progress to verify the objective.
# Show questions based on answers

# (Optional) Analyze data using IF and IFS
# The IF function evaluates a logical expression. You can use IF to display a particular value when the expression is TRUE and another if it's FALSE. The IFS function evaluates multiple logical expressions.

# To make a copy of the spreadsheet with sample survey responses, click On the Rise Bakery Survey (Responses).

# At the top, click File > Make a copy, and then click Make a copy to save the copy of the sheet.

# In cell I1, type Respondents with the same morning and afternoon food preferences

# In cell I2, paste or type =IF(E2=H2,"I enjoy the same foods.")

# This formula identifies the respondents who indicated the same food choices in the morning and afternoon.

# Apply this formula to the rest of the rows in column I.

# In cell J1, type Opening Times

# In cell J2, paste or type =IFS(F2<time(6,0,0), "Very Early Morning",F2<time(8,0,0), "Early Morning",F2<time(10,0,0), "Mid Morning")

# This formula sorts the opening times provided in the survey into three categories:

# For opening times before 6 AM, the text is Very Early Morning.
# For times between 6 AM and 8 AM, the text is Early Morning.
# For times between 8 AM and 10 AM, the text is Mid Morning.
# Apply this formula to the remaining rows in the column.

# Congratulations!
# In this lab, you created a Google Form with required responses and data validation. You also used conditional logic to show questions based on answers and analyze data in Google Sheets.

# Finish your quest
# This self-paced lab is part of the Use Functions, Formulas and Charts in Google Sheets quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge, to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you've taken this lab. See other available quests.

# Take your next lab
# Continue your quest with Pivot Tables in Google Sheets.

# Looking for a hands-on challenge lab to demonstrate your skills and validate your knowledge? On completing this quest, finish this additional challenge lab to receive an exclusive Google Cloud skills badge.

# Next steps / Learn more
# Check out the following for more information on Google Sheets:

# See the handy Sheets Cheat Sheet and Forms Cheat Sheet.
# Look like a pro when you know all the Workspace keyboard shortcuts.
# See the Productivity Guides for what else you can do with Sheets and Forms.
# Visit the Google Workspace Learning Center to view Sheets tips, templates and more
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: October 6, 2022
# Lab Last Tested: September 30, 2022
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.