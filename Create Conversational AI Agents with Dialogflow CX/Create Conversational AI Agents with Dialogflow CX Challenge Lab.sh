# Create Conversational AI Agents with Dialogflow CX: Challenge Lab
# 1 hour 30 minutes
# 1 Credit
# GSP353
# Google Cloud self-paced labs logo

# Overview
# In a challenge lab you’re given a scenario and a set of tasks. Instead of following step-by-step instructions, you will use the skills learned from the labs in the quest to figure out how to complete the tasks on your own! An automated scoring system (shown on this page) will provide feedback on whether you have completed your tasks correctly.

# When you take a challenge lab, you will not be taught new Google Cloud concepts. You are expected to extend your learned skills, like changing default values and reading and researching error messages to fix your own mistakes.

# To score 100% you must successfully complete all tasks within the time period!

# This lab is recommended for students who have enrolled in the Create Conversational AI Agents with Dialogflow CX quest. Are you ready for the challenge?

# Setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Challenge scenario
# You are a Conversational Architect building a voice virtual assistant for a car rental company. To create this agent, you need to set up intents to understand user requests and configure the conversational flow of the virtual agent in Dialogflow CX to guide the user through the car booking process. You'll need to set up a parameter collection form for the pickup location, start date, and end date and walk the user through the reservation flow.

# To complete the Lab, you'll need to connect a phone number to your virtual agent and set up handling for unrecognized requests and silence (no input) from users.

# Your challenge
# Your task is to build a virtual agent that will understand requests like "I want to book a car" and collect the information from the user to understand location, start date and end date of the reservation. An example agent with basic functionality will be shared with you to get you started.

# During the lab, you will work on adding a new flow to confirm user reservation, set up test cases, check test coverage and test your agent with your voice. Good luck!

# Set up your agent in Dialogflow CX
# Task 1. Create your Dialogflow CX agent
# Navigate to the Dialogflow CX console and click Create agent. If you do not see this page, refresh your browser.
# The Agents page displaying the highlighted Create agent button
# Call your agent CL - Car Rental - start. (CL stands for Challenge Lab).
# Note: Before saving your agent, double check that your agent's Location is set to global. It will allow you to use the agent with Google Telephony Gateway later in this Lab.
# Click Check my progress to verify the objective.
# Create the agent

# You'll be downloading an agent to use for this lab.

# In the Dialogflow CX console, in the drop-down menu with the list of your agents, click to View all agents.

# Now, click the CL - Car Rental - start context menu (three vertical dots More icon) and select Restore.

# Add the Cloud Storage location of the agent as the source:

# gs://spls/DialogflowCX_agents/car_rental_start
# Copied!
# After creating and restoring the agent, navigate to Agent Settings > General > Logging settings and click on Enable cloud logging option. It will generate logs for this agent.

# Click Save.

# Click Check my progress to verify the objective. If you have successfully created an agent, you will see an assessment score.
# Restore the agent

# Task 2. Create an entity to capture a 4 digit authorization pin
# Entity name: pin.

# Use regular expressions to catch 4 digits.

# Task 3. Create an authorization flow for users registered in the system
# Assume a very simple authentication process - when a user makes a call to the virtual agent, their phone number is known and the agent can send an authentication pin as a text message.

# Create a new flow called Authorization and connect the flow to 2 pages of the Default start flow - Confirmed and Drop off location.
# Note: To ensure that you don't need user input to continue to the Authorization flow, once you have collected basic information about their reservation, create a parameter route with a custom expression that simply says "true" on the "Confirmed" page (It will move the state machine forward).
# Here's a sample conversation that we're looking to support in your agent:

# User: I need a car

# Agent: Where do you want to pick up your car?

# User: in LA

# Agent: What's the pick-up date?

# User: tomorrow

# Agent: Great! When are you planning to drop it off?

# User: Sunday

# Agent: Thank you for this information. Are you planning to return the car at your pickup location?

# User: yes

# Agent [Default start flow, Page: Confirmed]: Thank you for confirming! Now, to complete the booking process, I'll take you through the reservation steps.

# Agent [Authorization flow, Page: Pin check]: I see that the number you're dialing from is registered in our system. I'll send you a 4-digit pin to confirm it's you.

# Agent [Authorization flow, Page: Pin check, Parameter: pin]: Your 4-digit pin will get to you shortly. Say it to me when you're ready.

# User: 1234

# Agent[Authorization flow, Page: Success]: Your booking is confirmed.

# To teach the agent to handle this conversation, connect the start page of the authorization flow to a new page. You can call it Pin check. For the purpose of this lab, you won't be validating the user pin with webhooks and will only check if it matches the 4-digit pattern.

# Use parameter collection with the entity you just created for the pin. Don't forget to add Agent says for the parameter.

# On the same Pin check page, configure a new route to check if the pin was successfully collected and jump to a new page - call it Success. On the Success page, confirm the reservation by adding entry fulfillment.

# Here's how the authorization flow should look like when you're done.

# The authorization flow from Start to Pin check to Success. The Pin check section displays fields for Entry fulfillment, Parameters, and Routes
# Task 4. Create test cases
# Now that your agent has all the core components to support a happy path and interact with users, create test cases to ensure that you won't have any regressions in the future and test the agent automatically.

# Test your agent in the Test Agent console and record 2 different test cases to cover the following cases:

# A user says I want to book a car in LA on Monday, their drop off location is the same as pick up.
# A user says I want to book a car, their drop off location is different from the pick up location.
# Once the test cases are created, run them and check test coverage. You don't have to reach 100% coverage to complete this Lab.

# Click Check my progress to verify the objective.
# Test the agent

# Task 5. Create a new version of the agent and save it to a new environment
# Now that your tests are looking green, the agent is stable enough to be saved and promoted to a higher environment.

# Navigate to Manage > Versions and create a new version for all flows in your agent (Default Start flow and Authorization flow). You can use the same version name for both flows - Happy path only.

# Then, create a new environment - call it Stable, and add a description for it. Save a version for both flows in the newly created environment.

# Now go back to Test Cases and run your tests against theStable environment.

# Click Check my progress to verify the objective.
# Create the new version of the agent

# Task 6. Create No Match and No Input event handlers
# Next, configure the agent to re-prompt users when their inputs are not recognized (or matched) by the virtual agent.
# In the Default Start Flow, you can find examples of Event handlers: sys.no-match-default and sys.no-input-default.

# Set up similar event handlers for all parameters on the page Location and Dates in the Default Start Flow.

# Create one No Match and one No Input handler for each of the parameters.

# Parameter	Event	Consider adding the following Fulfillment
# location	No-input 1	Can you speak up a little? What's the pick-up location?
# location	No-match 1	I missed that, what's the pick-up location?
# start-date	No-input 1	Please get a little closer to the mic. When do you want to pick up your car?
# start-date	No-match 1	Ups, I missed that! When do you want to pick up your car?
# end-date	No-input 1	Please get a little closer to the mic. When do you want to drop off your car?
# end-date	No-match 1	Ups, I missed that! When do you want to drop off your car?
# Task 7. Set up a phone number for your agent
# Now that your agent is tested and can be tested with voice, navigate to Manage > Integrations and set up a new phone number.
# You can use any of the available Phone Integrations for this task if you prefer not to use Google Telephony (for example, if you're testing your agent from a non-US region and want more options with various country codes).

# Call your agent and test it. If you don't like how it sounds, you can go back to the agent and change responses as you see fit.

# Additionally, enable Speech Adaptation to improve speech recognition quality. You can do it by navigating to Agent Settings > Speech and IVR > Enable Speech Adaptation.

# Click Check my progress to verify the objective.
# Set up a phone number for agent

# Congratulations!
# You have built a solution that allows you to understand users and talk to them via a virtual agent in Dialogflow CX!

# Create_Conversational_AI_Agents_with_Dialogflow_CX

# Earn your next skill badge
# This self-paced lab is part of the Create Conversational AI Agents with Dialogflow CX skill badge quest. Completing this skill badge quest earns you the badge above, to recognize your achievement. Share your badge achievement with your network and on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated January 16, 2023

# Lab Last Tested January 16, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.