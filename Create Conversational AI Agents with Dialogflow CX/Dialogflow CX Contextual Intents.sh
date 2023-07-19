# Dialogflow CX: Contextual Intents
# 1 hour 10 minutes
# 5 Credits
# GSP986
# Google Cloud self-paced labs logo

# Overview
# In the Dialogflow CX: Parameter Manipulation lab, you learned how to implement some advanced features of Dialogflow CX in order to make your agent even more conversational. In this lab you'll learn how to use more of the advanced features of Dialogflow CX to enhance the conversational experience of your virtual agent.

# First, you'll add the ability for a user to ask the agent to repeat what it said.

# Then, you'll add the ability for a user to ask common questions from your FAQ, even in the middle of another part of the conversation.

# Next, you'll add the ability for the agent to handle a new flight status conversation flow with deviations to frequently asked questions as well as context-sensitive questions related to the flight.

# Last, you'll add additional conversational branching and looping capabilities based on the current values in session parameters.

# Objectives
# By the end of this lab, you will be able to:

# Add a Repeat intent and add an intent route for it to the Confirm flight page, which is especially useful for voice interactions where the user may not have heard all of the details.

# Create FAQ intents that can be used to match user's general questions to the generic answers.

# Create route groups to handle contextual questions (e.g., FAQs asked in the middle of another part of the conversation). These will be useful for answering user's questions more specifically once there is more context.

# Create a session parameter called last_page that will be used to determine the flow of the conversation between Default Start Flow and the Upgrade flow.

# Prerequisites
# This lab builds upon the more advanced Flight Booker agent developed in Dialogflow CX: Parameter Manipulation and therefore assumes knowledge of Dialogflow CX elements such as intents, entities, training phrases, flows, and pages. Building upon these basics, this lab will implement more advanced conversational techniques using some advanced features of Dialogflow CX. Taking the earlier lab first is recommended, but you may proceed without it if you are already familiar with Dialogflow CX and its fundamental features and usage.

# Setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# How to start your lab and sign in to the Google Cloud Console
# Click the Start Lab button. If you need to pay for the lab, a pop-up opens for you to select your payment method. On the left is the Lab Details panel with the following:

# The Open Google Console button
# Time remaining
# The temporary credentials that you must use for this lab
# Other information, if needed, to step through this lab
# Click Open Google Console. The lab spins up resources, and then opens another tab that shows the Sign in page.

# Tip: Arrange the tabs in separate windows, side-by-side.

# Note: If you see the Choose an account dialog, click Use Another Account.
# If necessary, copy the Username from the Lab Details panel and paste it into the Sign in dialog. Click Next.

# Copy the Password from the Lab Details panel and paste it into the Welcome dialog. Click Next.

# Important: You must use the credentials from the left panel. Do not use your Google Cloud Skills Boost credentials.
# Note: Using your own Google Cloud account for this lab may incur extra charges.
# Click through the subsequent pages:

# Accept the terms and conditions.
# Do not add recovery options or two-factor authentication (because this is a temporary account).
# Do not sign up for free trials.
# After a few moments, the Cloud Console opens in this tab.

# Note: You can view the menu with a list of Google Cloud Products and Services by clicking the Navigation menu at the top-left. Navigation menu icon
# Task 1. Getting started with Dialogflow CX
# In this task, you'll get logged into Dialogflow CX and create a new agent.

# Name your virtual agent 'Flight Booker - Contextual Intents' when you get to that point in the steps.

# Assumption: You've already logged into Google Cloud before continuing with the steps below.

# In an new incognito window, navigate to dialogflow.cloud.google.com.

# Click on Sign-in with Google.

# Select the student account that you started the lab with.

# Next, you explicitly specify that you want to use Dialogflow CX instead of Dialogflow ES.

# In the menu bar at the left, click on Dialogflow CX.

# A new page for Dialogflow CX opens and a blue Dialogflow icon appears. On this page, you should see a pop-up asking you to select a project.

# Search the list in the pop-up for the project that matches your assigned Project ID for this lab. Click on your project ID.

# Note: If you don't see your Project ID listed, look at the user on the right side to confirm that you are using Dialogflow CX as "student".
# Dialogflow CX title bar highlighting the project box and the user avatar

# You will now see a page telling you "To use Dialogflow CX with this project, enable the following APIs".

# Click on Enable API.

# It shouldn't take more than half a minute or so for this activity to complete.

# If it seems this task is taking a long time, refresh the page.

# Once complete, you will be on the Dialogflow CX Agents page.

# Click on Create agent.

# Enter a name for the agent (e.g., "Cloudio-cx").

# Accept the default location.

# Ensure timezone and default language are set appropriately.

# Click Create.

# Once the agent is created, you will see the design and configuration portion of the Dialogflow CX UI.

# After creating the agent, navigate to Agent Settings > General > Logging settings.
# Click on Enable Cloud Logging and Enable interaction logging option. It will generate logs for this agent.
# Click Save.
# Click Check my progress to verify the objective.
# Create an Agent

# Task 2. Importing a .blob virtual agent file
# In this task, you will import a virtual agent from an earlier lab.

# Select View all agents in the Agent dropdown menu at the top.

# From the context menu (three vertical dots) to the right of your virtual agent, click on Restore.

# Select the Cloud Storage radio button if not already selected.

# Enter the following for the URI:

# gs://spls/DialogflowCX_agents/gsp986-start-agent.blob
# Copied!
# Click Restore.

# Refer to the Dialogflow CX "restore" documentation as needed.

# Now you have a virtual agent that has everything completed from the earlier lab.

# If you'd like to retain a copy of the sample agent, click to download gsp986-start-agent.blob to your local hard drive.

# Click Check my progress to verify the objective.
# Importing a virtual agent file

# Verify the restored agent
# For this lab, you will notice an Upgrade flow has been added in addition to the output from the earlier lab. The purpose is to allow you to jump ahead to implement some more advanced features during the time allotted for the lab.

# Confirm the following pages and intents appear in your virtual agent:

# Pages:

# Start
# Ticket information
# Confirm trip
# Check flight status
# Confirm flight status
# Anything else?
# End Session
# Flows:

# Default Start Flow
# Upgrade
# The Default Start Flow page

# Intents:

# Default Welcome Intent
# Default Negative Intent
# main.flight_status
# main.book_a_flight
# confirmation.no
# confirmation.yes
# The Intents page

# Add the ability to repeat information
# In conversations, sometimes you ask the other person to repeat what they just said. In the same way, you would like to have this capability for your virtual agent. This scenario is more likely to happen with a voice-enable virtual agent than in a chat bot. For a lab that addresses this interactive voice recognition (IVR) setup, please see the Dialogflow CX: Enable IVR Features for your Voice Agent lab.

# Add a new user.request.repeat intent with the following configuration:

# Config item	Value
# New intent name	user.request.repeat
# Sample training phrases	'say again', 'repeat', 'please repeat that', and 'can you say that again?'
# Next, you'll add the repeat option to selected parts of the conversation including the flight status and booking scenarios.

# Add a new user.request.repeat route in the Confirm flight status page with the following configuration:

# Config item	Value
# Page	Confirm flight status
# Add Route, Intent name	user.request.repeat
# Fulfillment, i.e., Agent says	'Sure, let me repeat that:'
# Transition page	Check flight status
# Note: You want to transition to the Check flight status page (away from the Confirm flight status page) because the entry fulfillment message should be triggered by a repeat request.
# By transitioning to the previous page, Check flight status, with all parameters already filled will automatically move the flow from Check flight status to Confirm flight status.
# Test the repeat functionality
# Test the functionality you added to repeat the data the user requested. For instance, try testing with the following:

# Who	Message
# User	I want to check flight status
# Agent	What is your flight booking reference please?
# User	ND48PQ
# Agent	Looking up your flight reference ND48PQ, ...
# User	Please repeat
# Agent	Sure, let me repeat that: Looking up your flight reference ND48PQ, ...
# Click Check my progress to verify the objective.
# Testing your virtual agent

# Adding repeat to the Flight Booking flow
# Add the repeat functionality to the flight booking conversational flow.
# Note: You'll configure everything in the Confirm trip page in the same way you did for the Confirm flight status page except that it will go back to the page that tells the user the ticketing information.
# Knowledge check


# When might you enable repeat capability within a conversational flow?

# When the end user may want the virtual agent to repeat a piece of information, especially in voice-enabled agents.

# When the virtual agent wants the end user to repeat a piece of information.

# Never. Just get the end user to restart the conversation.

# Task 3. Grouping FAQs
# Frequently Asked Questions (FAQs) may happen at any stage of a conversation. For instance, FAQs include questions about store opening hours, refund policies, etc. In an airline scenario, some FAQs are about carry-on baggage limits and flight upgrades.

# In this section, you will create a few FAQs and explore the use of route groups to group these FAQs. This will enable your virtual agent to deviate from a conversational flow, quickly answer these side queries, and then return to the main flow of the conversation.

# Create some FAQ intents
# Create three new intents with training phrases as follows:
# Intent>>	faq.miles.upgrade	faq.cabin.limits	faq.cabin.batteries
# Phrase 1	Can I upgrade to 1st class using my frequent flyer miles?	How many bags can I bring into the cabin with me?	What about Power Banks?
# Phrase 2	First class upgrade with miles	What is the limit on carry-on baggage?	Can I bring portable batteries on board?
# Phrase 3	Business class upgrade with miles	Can I bring more than 2 bags into the cabin?	Is there a limit on the power bank I can bring into the cabin?
# Phrase 4	Request upgrade	Am I limited to two?	Power bank
# Phrase 5	I want an upgrade	What's the max on bags?	Lithium batteries
# Create a general route group
# Select Route Groups under the Manage tab.

# Click + Create.

# Enter General FAQs for the Display name.

# Click Continue.

# Click into the newly created General FAQs route group.

# Next, you'll add all three of the FAQ intents you created.

# For each intent in the list, click Add route, select the intent, and add the following for the fulfillment messages and click Save:

# Intent	Message
# faq.miles.upgrade	Yes, depending on the flight and availability, we can put in a request for an upgrade from Economy.
# faq.cabin.limits	It depends on the destination airport. Generally, you are allowed a maximum of 1 cabin bag, not exceeding 7kg and with the Sum of L + W + H (including the wheels) must be no more than 115cm (45 inches).
# faq.cabin.batteries	For Lithium batteries (includes Power Banks), no more than two spare batteries exceeding 100Wh and up to 160Wh, are permitted.
# Add general route group to the Default Start Flow
# Next, you need to add the route group to the Start page in the Default Start Flow so that Dialogflow knows you want the intents/routes defined in the route group triggered any time it finds a match during the flow.

# Go to the Build tab.

# Click on the Start page.

# Click Add state handler.

# Click on the checkbox to enable Route groups then click on Apply.

# Click + to the right of Route groups to add a new route group.

# Select General FAQs from the route group dropdown.

# Click Save.

# Notice the General FAQs route group shows (3) next to it indicating that it contains three routes.

# Test the General FAQs side query scenario
# For testing purposes, use the following as a guide to explore each turn of the conversation where an FAQ pops up.

# Who	Message
# User	How many bags can I bring into the cabin?
# Agent	It depends on the destination airport. Generally, you are allowed ...
# User	Book a flight
# Agent	What city would you like the flight to depart from?
# User	Sydney
# Agent	What is the month and day of the departure?
# User	What about Power Banks?
# Agent	For Lithium batteries (includes Power Banks), ... What is the month and day of the departure?
# User	Tomorrow
# Agent	What is your destination city?
# User	Can I get an upgrade?
# Agent	Yes, depending on the flight and availability, ... What is your destination city?
# Feel free to test additional scenarios to be satisfied that General FAQs will work from any page now that you have the General FAQs route group in the Start page of the Default Start Flow.

# Knowledge check

# A group of intents in a route group has been added to the Start page of the Default Start Flow. These intents can be triggered at:

# all pages within the Default Start Flow.

# the Start page of the Default Start Flow only.

# only at the beginning and end of a conversation.

# Click Check my progress to verify the objective.
# Testing general FAQs side query scenario

# Task 4. Add context sensitive answers
# Depending on the stage of a conversation, a question may result in a general answer or a more specific answer. Context is key. For instance, if you enquire about upgrading your flight with your frequent flyer points, the answer could be general in the sense that you can upgrade the flight based on points and seat availability. If you have a booked flight, asking the same question would result in a more specific answer because you would know the points required and if there are seats available.

# In this section, you will use the same route group feature to create a context-sensitive route group.

# Repeat the steps to create a new route group, this time calling it FAQs during Flight Status.

# Add only one FAQ intent, faq.cabin.limits, to this route group for now.

# Enter a fulfillment message for faq.cabin.limits such as:

# For this flight: You are only allowed a small cabin bag not exceeding 3kg and with the Sum of L + W + H (including the wheels) must be no more than 90cm (35 inches).
# Copied!
# Note: Notice the intent's response message is different from the one in the General FAQ route group. For this specific scenario, you would typically use a webhook to call an API to get the specific information for a given flight. However, coding a webhook is outside the scope of this lab.
# Set the transition target for faq.cabin.limits route to the Check flight status page.

# Click Save.

# Add context sensitive route group to the Confirm flight status page
# Navigate to the Confirm flight status page.

# Click Add state handler.

# Click on the checkbox to enable Route groups and then click on Apply.

# Click + to the right of Route groups to add a new route group.

# Add the new FAQs during Flight Status route group.

# Click Save.

# Click on the FAQs during Flight Status route group.

# Your configuration should look like the following: The Route group tabbed page displaying the Display name and search parameters such as intent, condition, fulfillment, and transition

# Testing general FAQs vs context-sensitive FAQs
# For testing purposes, use the following as a guide to explore each turn of the conversation.

# Who	Message
# User	Cabin bags as carry-on?
# Agent	It depends on the destination airport. Generally, you are allowed ...
# User	Check flight status
# Agent	What is your flight booking reference please?
# User	PNR235
# Agent	Looking up your flight reference PNR235, ...
# User	Cabin bags limit?
# Agent	For this flight: You are only allowed a small cabin bag not exceeding ...
# Note: Notice the cabin bags response was different this time. The FAQs during Flight Status route group was triggered, rather than the General FAQs, when the user was in the flight status flow.
# Add flight upgrade to context-sensitive route group
# Now you'll add another route to the FAQs during Flight Status route group. This time the route will call another flow that will be reused in the "Flight Booking" conversational flow later.

# Navigate back to the Confirm flight status page as needed.

# Select the FAQs during Flight Status route group.

# Click Add route.

# Select the faq.miles.upgrade intent.

# Select the Flow radio button in the Transition section.

# Select the Upgrade flow.

# Click Save.

# Testing the context-sensitive flight upgrade query
# Now you will test the new upgrade scenario.

# Test with the following:

# Who	Message
# User	Check flight
# Agent	What is your flight booking reference please?
# User	PNR987
# Agent	Looking up your flight reference PNR987, ...
# User	I want an upgrade
# Agent	What is your frequent flyer number please?
# User	098765
# Agent	Thank you. Confirming request for upgrade has been received...
# User	Ok, Great.
# Agent	Can you say that again?
# Note: Did you notice any peculiar behavior? Why didn't the agent understand the last part of the conversation or return to the main flow again?
# Notice the page and parameter information in the simulator. You can see that you are still in the upgrade flow and in the Upgrade request received page. It appears the upgrade flow did not return to the Confirm flight status page from the Default Start Flow.

# Click Check my progress to verify the objective.
# Add and test flight upgrade to context-sensitive route group

# The Simulator page displaying the parameters and values

# One way to fix this is to change the Upgrade request received page in the upgrade flow to end the flow so that control can be returned to the calling Confirm flight status page.

# Navigate to the Upgrade request received page in the Upgrade flow.

# Open the configuration pane of the only route there. It has a label, true and it's a condition type of route. Note that you may have to click on Routes first.

# Note: The word true is a reserved word which Dialogflow treats as an expression evaluated to true. When a route condition is configured this way, Dialogflow will always take the route, that is except if there is another route in the list before it that takes precedence over it.
# Scroll down to the Transition section.

# Change the transition page, selecting End Flow from the flow drop-down.

# Click Save.

# Repeat the test with the following:

# Who	Message
# User	Check flight
# Agent	What is your flight booking reference please?
# User	PNR888
# Agent	Looking up your flight reference PNR888, ...
# User	upgrade
# Agent	What is your frequent flyer number please?
# User	12341324
# Agent	Thank you. Confirming request for upgrade has been received...
# User	Great!
# Agent	Sorry, could you say that again?
# User	Yes, please go ahead.
# Agent	Our agents will be in touch soon for your request ...
# Review the data in the test simulator and note the agent has successfully transferred control from the upgrade flow back to the Confirm flight status page in the Default Start Flow and finally the Anything else? page. That's good.

# But wait! For the routes of the Confirm flight status page, you are only expecting three possible intent responses: confirmation.yes, confirmation.no, and user.request.repeat. This is precisely why the virtual agent does not understand the "Great" response from the end user.

# One way to fix this is to change the behavior of the upgrade flow and also make it more reusable for other parts of the Default Start Flow. You'll use a custom session parameter to achieve this slightly more sophisticated routing next.

# Task 5. Conversation routing with a session parameter
# In this section you'll introduce a new session parameter named last_page and see how this will help route between Default Start Flow and the Upgrade flow more seamlessly.

# Introduce a last_page session parameter
# Navigate back into the FAQs during Flight Status route group. You can get to it either from the Confirm flight status page or from Route Groups under the Manage tab.

# Click to edit the faq.miles.upgrade route.

# Scroll down to the Parameter presets section.

# Click Add a parameter.

# Add "last_page" as the parameter name and set the value to "Flight Status". Note that the value needs to be in double quotes.

# Click Save.

# Change upgrade flow to transition to Default Start Flow
# Navigate to the Upgrade flow.

# Click on the Upgrade request received page.

# Click on the only route there (with label true).

# Change the route transition from End Flow to Default Start Flow. (Hint: make sure the Flow radio button is selected.)

# Click Save.

# Routing with last_page session parameter in Default Start Flow
# Navigate back to Default Start Flow.

# Click on the Start page.

# Click + to add a new route.

# Scroll to the Condition section.

# Select the default, Match AT LEAST ONE rule (OR).

# Enter $session.params.last_page in the parameter field.

# Ensure the operator is set to = (it should be by default).

# Enter "Flight Status" in the value field. Note that quotes are required in this case because there are two words.

# Choose the Check flight status page in the Transition section.

# Click Save.

# Up to now, the Start page in the Default Start Flow had only intent routes. Now your Start page has a new route that is based on a condition rather than an intent.

# Add the last_page parameter to the parameter presets of your Anything else? page so that it's set to null again as appropriate, like the other parameters.

# Testing the new last_page routing logic
# Test with the following:

# Who	Message
# User	Check flight
# Agent	What is your flight booking reference please?
# User	By the way, can I get an upgrade?
# Agent	Yes, depending on the flight and availability, ...
# User	PNR888
# Agent	Looking up your flight reference PNR888, ...
# User	I would like to upgrade my flight
# Agent	What is your frequent flyer number please?
# User	1234321
# Agent	Thank you. Confirming request for upgrade has been received...
# Note: Can you explain this new routing behavior? The last_page parameter is set to "Flight Status" when the faq.miles.upgrade route (in the 'FAQs during Flight Status' route group) is triggered. The Upgrade flow is called, which is where the frequent flyer number is requested, and the upgrade request is confirmed.
# The Upgrade flow exits by transitioning to the Start page of the Default Start Flow. The route in the Start page detects the last_page parameter is set to "Flight Status" and routes this automatically to the Check flight status page.
# In the Check flight status page, the required PNR number parameter is already filled and thus it transits automatically back to Confirm flight status, and the loop is complete.
# Can you reuse this flow during flight booking? Certainly!

# For instance, if you were branching from the flight booking part of the conversational flow, specifically at the Confirm trip page, you can assign a booking value to the last_page parameter. That way users can request an upgrade after booking a flight and experience the same flow.

# Task 6. (Optional) Use last_page with flight booking
# Finally, see if you can implement the last_page condition routing for the flight booking part of the conversation.
# For instance, in the booking scenario, the condition would be when last_page = "Booking" and the transition would be to the Ticket information page. Don't forget to create a new route group for 'FAQs during Booking' to handle the new routes and add it to the confirmation stage of your flow.

# Knowledge check


# In terms of reusing intents, the same intent

# should always be configured in its own route group.

# can be placed inside different route groups with different fulfillment methods and different transition targets.

# cannot be placed inside different route groups with different fulfillment methods and different transition targets.


# What does the predefined End Flow page do?

# It does not do anything.

# It ends the flow of the conversation and returns control to the point when the flow was triggered.

# It ends the flow of the conversation and terminates the session.


# Besides the parameters section in a page, where else can you create and set the session parameters values in Dialogflow CX?

# Session parameters cannot be created or changed.

# Just create them with the prefix `$session.params.` at any fulfillment section.

# Where parameter presets is available.

# Export your agent
# If you want to export your virtual agent to use in your own project, use the following steps:

# Select View all agents from the Agent dropdown at the top.

# Click on the context menu (three vertical dots) and choose Export.

# Click on the Download radio button.

# Click Export.

# Congratulations!
# You now know how to add a Repeat intent and route for it, create FAQ intents that can be used to match user's general questions to the generic answers, create route groups to handle contextual questions (FAQs asked in the middle of another part of the conversation), and create a session parameter to determine the flow of the conversation between flows.

# Finish your quest
# This self-paced lab is part of the Create Conversational AI Agents with Dialogflow CX quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in this quest to get immediate credit. Refer to the Google Cloud Skills Boost catalog for all available quests.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated December 13, 2022

# Lab Last Tested December 13, 2022

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.