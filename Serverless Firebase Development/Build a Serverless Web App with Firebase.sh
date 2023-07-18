# Build a Serverless Web App with Firebase
# 1 hour
# 1 Credit
# GSP643
# Google Cloud self-paced labs logo

# Pet Theory logo
# Overview
# For the labs in the Google Cloud Run Serverless Workshop, you will read through a fictitious business scenario and assist the characters with their serverless migration plan.

# Twelve years ago, Lily started the Pet Theory chain of veterinary clinics. The Pet Theory chain has expanded rapidly over the last few years. Their old appointment system is not able to handle the increased load or allow clients to schedule their own appointments, so Lily asked Patrick, in IT, and Ruby, a consultant, to build a cloud-based system that easily scale.

# In the previous lab, Migrating Data to a Firestore Database, you learned how to leverage Firestore to host customer data. In this lab you will build a fully fledged Firebase web app that allows users to log information and schedule appointments in real time.

# Architecture
# This diagram gives you an overview of the services you will be using and how they connect to one another:

# Architecture diagram

# What you'll learn
# In this lab, you will learn how to:

# Enable the Firebase API in your Google Cloud project.
# Create and configure a Firebase project.
# Configure Firestore Security to automate server-side authentication and authorization.
# Add Google sign-in to your web app.
# Configure your database so users can add their contact information.
# Explore and deploy code that allows users to schedule appointments.
# Explore Firebase's real time updates in your web app.
# Prerequisites
# This is a fundamental level lab. This assumes familiarity with the Cloud Console and shell environments. Experience with Firebase will be helpful, but it is not required. Before taking this lab it is recommended that you have completed the following Qwiklab:

# Importing Data to a Firestore Database
# You should also be comfortable editing files. You can use your favorite text editor (like nano, vi, etc.) or you can launch the code editor from Cloud Shell, which can be found in the top ribbon:

# Open Editor button

# Once you're ready, scroll down and follow the steps below to setup your lab environment.

# Task 1. Provisioning the Firebase environment
# Ruby sends Patrick an email:

# Ruby

# Ruby, Software Consultant

# Hi Patrick,

# Awesome work last week. Great to see that the clinic's data has been migrated to Firestore!

# It looks like the next task is to use Firebase to host the Pet Theory website.

# Ruby

# Patrick

# Patrick, IT Administrator

# Hi Ruby,

# I haven't heard of Firebase hosting before, what are the benefits? Where would I get started?

# Patrick

# Ruby

# Ruby, Software Consultant

# Hi Patrick

# The primary benefit of Firebase hosting is that it is serverless, so there is no infrastructure to manage. Security rules are also embedded within the application, so permissions can be restricted to minimize issues when handling customer data.

# It also has a "pay as you use" model, which means Firebase is a comprehensive mobile development platform for our use case.

# Ruby

# Patrick

# Patrick, IT Administrator

# Hi Ruby

# Sounds like Firebase will make security and infrastructure management (a big part of my job) a whole lot easier. I'm excited to not be billed for idle servers either!

# Patrick

# Ruby sends Patrick some background information in an email, and they hold a meeting to work out the key activities. From this meeting they determine that he needs to:

# Add the Firestore CLI to the Google Cloud project.
# Create a Firestore Database.
# Configure a Firebase project.
# Establish security policies.
# Next, help Patrick accomplish these tasks.

# Task 2. Install the Firebase CLI
# Note: The development environment has been preconfigured with Firebase Tools.
# Copy the IDE link from the Lab Details panel and paste it into a new browser tab to open Cloud Code.

# Open a terminal to access the command line. In the left panel, click the Application menu (Application menu icon) > Terminal > New terminal.

# Clone the GitHub repository from the command line:

# git clone https://github.com/rosera/pet-theory.git
# Copied!
# In the left panel, click the Explorer icon, and then Open Folder > pet-theory > lab02. Click OK.

# Open a terminal

# Install the necessary node packages:

# npm i && npm audit fix --force
# Copied!
# Output:

# + firebase-tools@10.7.0
# added 3 packages from 11 contributors, removed 1 package and updated 8 packages in 79.808s
# You are now ready to create a Firestore database.

# Task 3. Setup a Firestore Database
# In the terminal prepare the environment to use a Firestore Database.

# Set your project region to us-central1:

# gcloud config set compute/region us-central1
# Copied!
# Enable App Engine applications:
# gcloud app create --region=us-central
# Copied!
# Create a Firestore database:
# gcloud firestore databases create --region=us-central
# Copied!
# You are now ready to create a Firestore project and link it to your Google Cloud account.

# Task 4. Create a Firebase project
# Open the Firebase console in an incognito window.

# Note: The lab includes permissions for Firebase. Copy the Firebase Console link to access Firebase. Use the Username/Password provided with the lab to authenticate with Firebase.
# Click the account icon in the upper right-hand corner of the page and ensure that it is the Qwiklabs student account that you have been provisioned for this lab.

# Then click Add project. When prompted for a project name, Use the Project ID from the drop-down menu.

# Accept the Firebase terms and click Continue. Confirm the "Pay as you go" billing plan.

# Click Continue and on the following page disable the Google Analytics for your Firebase Project.

# Then click Add Firebase. Click Continue when you see a prompt that says your new project is ready:

# Project ready prompt

# Test completed task
# Click Check my progress to verify the objective.

# Create a Firebase project
# Task 5. Register your app
# After completing the last step, you should be in the Firebase Console. If you close that page, you open another incognito tab and use the following link to the Firebase Console.

# Select the web icon (highlighted below) from the list of "Get started by adding Firebase to your app" icons:
# Web icon highlighted

# When prompted for an "App nickname", type in Pet Theory.

# Then check the box next to "Also set up Firebase hosting for this app".

# Click on the Register app button.

# Click Next > Next > Continue to console. You should now be on the following page:

# Choose a product to add to your app

# You have now configured Firebase for the project. Next, you will initialize the project to reference your Firebase host.

# Test completed task
# Click Check my progress to verify the objective.

# Register your app
# Task 6. Authenticate to Firebase and Deploy
# Use the IDE to connect to Firebase and deploy your application. Type the commands in the terminal available in the editor.

# Authenticate to Firebase:
# firebase login --no-localhost
# Copied!
# Enter in Y if asked if Firebase can collect error reporting information and press Enter.

# Copy and paste the URL generated in a new incognito browser tab and press Enter (directly clicking on the link results in an error).

# Select your labs account and then click Allow. Click on Yes, I just ran this command to proceed, then confirm your session ID by clicking Yes, this is my session ID. You will then be given an access code:

# Copy the access code, paste it in the Cloud Shell prompt Enter authorization code:, and press Enter. You should receive output similar to the following response:

# Output:

# ✔  Success! Logged in as gcpstaging86673_student@qwiklabs.net
# Now initialize a new Firebase project in your current working directory:

# firebase init
# Copied!
# Running this command will step you through setting up your project directory and Firebase products.

# You will be asked to select the Firebase CLI features you want set up in this folder. Use the arrow keys and the spacebar to select Firestore and Hosting. Ensure your shell matches the following and then hit Enter:
# ? Which Firebase CLI features do you want to set up for this folder? Press Space to select features, then Enter to confirm your choices.
#  ◯ Realtime Database: Configure a security rules file for Realtime Database and (optionally) provision default insta
#  ◉ Firestore: Configure security rules and indexes files for Firestore
#  ◯ Functions: Configure a Cloud Functions directory and its files
# ❯◉ Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys
#  ◯ Hosting: Set up GitHub Action deploys
#  ◯ Storage: Configure a security rules file for Cloud Storage
# Then run through the rest of the steps to configure Firebase:
# Key down to Use an existing project and press Enter.
# Select your Qwiklabs Project ID from the list (it's the one that starts with "qwiklabs-gcp-") then Enter.
# Press Enter and then N to keep your firestore.rules file.
# Press Enter and then Y to keep your firestore.indexes.json file.
# Press Enter to keep your public directory and then N to disallow rewrites to your /index.html file.
# Press Enter to Set up automatic builds and deploys with GitHub? and press N.
# Enter in N when prompted to overwrite your 404.html file.
# Enter in N when prompted to overwrite your index.html file.
# You should receive the following output:

# ✔  Wrote public/404.html
# ✔  Wrote public/index.html
# i  Writing configuration info to firebase.json...
# i  Writing project information to .firebase...
# i  Writing gitignore file to .gitignore...
# ✔  Firebase initialization complete!
# The local configuration is now complete. Now the database authentication step is required to provide access between the services.

# Task 7. Set up authentication and a database
# Return to the Firebase Console to complete this step.

# Click on the Project Overview button in the left-hand navigation menu.

# Select Authentication tile and then click on Get Started:

# From the list of Sign-in Providers, click on the Google item.

# Click the enable toggle in the top right corner and for the Project support email select your lab account from the drop down list. Your page should now resemble the following:

# Enable toggle highlighted and Project support email dropdown menu

# Once you have verified the above, click on the Save button.
# You have now set up Firestore authentication. In the following step you will work on hosting the application with Firebase.

# Test completed task
# Click Check my progress to verify the objective.

# Set up authentication and a database
# Task 8. Scenario: set up the application
# You have assisted Patrick in setting up a working Firebase hosting environment where a web developer can deploy their code. However, Patrick has never enabled Firebase authentication nor has he deployed code to Firebase, so he emails Ruby for some help...

# Patrick

# Patrick, IT Administrator

# Hey Ruby,

# Thanks for all the tips! The Firebase environment looks like it is all set up. My next task is to deploy the website developers' code.

# Can you help me understand what this entails and what I need to do next?

# Patrick

# Ruby

# Ruby, Consultant

# Hi Patrick,

# That's great to hear! I'll send you the instructions on how to run the application and add the following features:

# Set up web authentication for logging in.
# Enable customer details to be logged on the Profile page.
# Create a self service portal for appointments.
# Ruby

# Patrick

# Patrick, DevOps Engineer

# Hi Ruby

# That sounds like it will be quite a bit of work.

# Does that mean I'll have to make structural changes every time I want to add something new? Not to mention the time it will take to see those updates...

# Patrick

# Ruby

# Ruby, Consultant

# Hey Patrick

# You can do most of the heavy lifting with Firebase libraries.

# Seeing your updates in your browser is as simple as calling firebase deploy from the command line.

# Make changes, deploy, and see your changes on the website!

# Ruby

# Patrick

# Patrick, IT Administrator

# Hi Ruby

# Wow, that's very comforting! Firebase hosting just gets better and better :-)

# Patrick

# Now that Patrick has a better understanding of what is required, you will help him deploy Pet Theory as a Firebase application.

# Task 9. Configure Firestore authentication and add sign-in to your web app
# Return to the Terminal for this step. You should still have your command line session open from the previous Firebase initialization.

# Run the following command to list the folders and files in your lab02 directory:

# ls -1
# Copied!
# Make sure that your output resembles the following:
# README.md
# firebase.json
# firestore.indexes.json
# firestore.rules
# node_modules
# package-lock.json
# package.json
# public
# solution
# Use the code editor to open the pet-theory/lab02/firestore.rules:

# rules_version = '2';
# service cloud.firestore {
# match /databases/{database}/documents {
#   match /customers/{email} {
#     allow read, write: if request.auth.token.email == email;
#     }
#   match /customers/{email}/{document=**} {
#     allow read, write: if request.auth.token.email == email;
#     }
#   }
# }
# Copied!
# Note: The configuration will ensure the Firestore database user can only access their own data. The firestore.rules file is used to provide security for the Firestore database. Learn more about Firestore database security.
# Task 10. Deploy your application
# With all the changes made, you are ready to deploy the application. Ensure you are still in the pet-theory/lab02 folder.

# Run the following command to deploy your firebase application:

# firebase deploy
# Copied!
# Output:

# ✔  Deploy complete!
# Project Console: https://console.firebase.google.com/project/qwiklabs-gcp-7d652f8cf1f91cce/overview
# Hosting URL: https://qwiklabs-gcp-01-8be196f95006.web.app
# Copy the hosting URL (should resemble [PROJECT-ID].web.app) and open it in a new tab.
# Click on the Sign in with Google button:
# Note: You see a browser is not supported or 3rd party cookies and data may be disabled error, make sure to enable cookies in your browser. Third-party cookies error message This can be done in Chrome by clicking the eye icon at the far right of the url tab and following the blue links in the popup. Click on the site not working? link to update your browser settings to accept cookies.
# Select your Google account. The following page opens:
# Profile page

# Note: Managing passwords is a difficult task and could expose your company to additional risk. Also, users don't want to create yet another user id and password.
# A small company like Pet Theory doesn't have the resources or requisite skill set to do this. In this instance it is much better to let the application users log in with their existing Google account (or any other identity providers)!
# You have now deployed code to let users use Google authentication to access the appointments app.

# Task 11. Add a customer page to your web app
# Return to the Terminal and use the editor to view the files in the public folder.

# Open the customer.js file and copy and paste the following code:

# let user;
# firebase.auth().onAuthStateChanged(function(newUser) {
#   user = newUser;
#   if (user) {
#     const db = firebase.firestore();
#     db.collection("customers").doc(user.email).onSnapshot(function(doc) {
#       const cust = doc.data();
#       if (cust) {
#         document.getElementById('customerName').setAttribute('value', cust.name);
#         document.getElementById('customerPhone').setAttribute('value', cust.phone);
#       }
#       document.getElementById('customerEmail').innerText = user.email;
#     });
#   }
# });
# document.getElementById('saveProfile').addEventListener('click', function(ev) {
#   const db = firebase.firestore();
#   var docRef = db.collection('customers').doc(user.email);
#   docRef.set({
#     name: document.getElementById('customerName').value,
#     email: user.email,
#     phone: document.getElementById('customerPhone').value,
#   })
# })
# Copied!
# Open the styles.css file and paste in the following code:

# body { background: #ECEFF1; color: rgba(0,0,0,0.87); font-family: Roboto, Helvetica, Arial, sans-serif; margin: 0; padding: 0; }
# #message { background: white; max-width: 360px; margin: 100px auto 16px; padding: 32px 24px 16px; border-radius: 3px; }
# #message h3 { color: #888; font-weight: normal; font-size: 16px; margin: 16px 0 12px; }
# #message h2 { color: #ffa100; font-weight: bold; font-size: 16px; margin: 0 0 8px; }
# #message h1 { font-size: 22px; font-weight: 300; color: rgba(0,0,0,0.6); margin: 0 0 16px;}
# #message p { line-height: 140%; margin: 16px 0 24px; font-size: 14px; }
# #message a { display: block; text-align: center; background: #039be5; text-transform: uppercase; text-decoration: none; color: white; padding: 16px; border-radius: 4px; }
# #message, #message a { box-shadow: 0 1px 3px rgba(0,0,0,0.12), 0 1px 2px rgba(0,0,0,0.24); }
# #load { color: rgba(0,0,0,0.4); text-align: center; font-size: 13px; }
# @media (max-width: 600px) {
#   body, #message { margin-top: 0; background: white; box-shadow: none; }
#   body { border-top: 16px solid #ffa100; }
# }
# Copied!
# From the command line run the following command:

# firebase deploy
# Copied!
# Output:

# ✔  Deploy complete!
# Project Console: https://console.firebase.google.com/project/qwiklabs-gcp-7d652f8cf1f91cce/overview
# Hosting URL: https://qwiklabs-gcp-01-8be196f95006.web.app
# Go to your application tab and hard refresh the page with CMND+SHIFT+R (Mac) or CTRL+SHIFT+R (Windows). Simple refreshing will not display the needed updates. Enter some customer info—make up a name and phone number and click Save profile.
# Profile form

# Return to the Firebase Console and click Build > Firestore Database to view the profile information saved:
# Cloud Firestore, Data tabbed page

# Return to the web app page and click on the Appointments link. You will see a blank page since it has not deployed the appointments code yet.

# Test completed task
# Click Check my progress to verify the objective.

# Add a customer page to your web app
# Task 12. Let users schedule appointments
# Build out the page that allows users to schedule appointments.

# Return to the Code Editor tab. You will add code to two files in the public directory.

# From the side menu, select appointments.html and paste in the following code:

# <!DOCTYPE html>
# <html>
#   <head>
#     <meta charset="utf-8">
#     <meta name="viewport" content="width=device-width, initial-scale=1">
#     <title>Pet Theory appointments</title>
#     <script src="/__/firebase/6.4.2/firebase-app.js"></script>
#     <script src="/__/firebase/6.4.2/firebase-auth.js"></script>
#     <script src="/__/firebase/6.4.2/firebase-firestore.js"></script>
#     <script src="/__/firebase/init.js"></script>
#     <link type="text/css" rel="stylesheet" href="styles.css" />
#   </head>
#   <body>
#     <div id="message">
#       <h2>Scheduled appointments</h2>
#       <div id="appointments"></div>
#       <hr/>
#       <h2>Schedule a new appointment</h2>
#       <select id="timeslots">
#         <option value="0">Choose time</option>
#       </select>
#       <br><br>
#       <button id="makeAppointment">Schedule</button>
#     </div>
#     <script src="appointments.js"></script>
#   </body>
# </html>
# Copied!
# Now open the appointments.js file and paste in the following code:

# let user;
# firebase.auth().onAuthStateChanged(function(newUser) {
#   user = newUser;
#   if (user) {
#     const db = firebase.firestore();
#     const appColl = db.collection('customers').doc(user.email).collection('appointments');
#     appColl.orderBy('time').onSnapshot(function(snapshot) {
#       const div = document.getElementById('appointments');
#       div.innerHTML = '';
#       snapshot.docs.forEach(appointment => {
#         div.innerHTML += formatDate(appointment.data().time) + '<br/>';
#       })
#       if (div.innerHTML == '') {
#         div.innerHTML = 'No appointments scheduled';
#       }
#     });
#   }
# });
# const timeslots = document.getElementById('timeslots');
# getOpenTimes().forEach(time => {
#   timeslots.add(new Option(formatDate(time), time));
# });
# document.getElementById('makeAppointment').addEventListener('click', function(ev) {
#   const millis = parseInt(timeslots.selectedOptions[0].value);
#   if (millis > 0) {
#     const db = firebase.firestore();
#     db.collection('customers').doc(user.email).collection('appointments').add({
#       time: millis
#     })
#     timeslots.remove(timeslots.selectedIndex);
#   }
# })
# function getOpenTimes() {
#   const retVal = [];
#   let startDate = new Date();
#   startDate.setMinutes(0);
#   startDate.setSeconds(0);
#   startDate.setMilliseconds(0);
#   let millis = startDate.getTime();
#   while (retVal.length < 5) {
#     const hours = Math.floor(Math.random() * 5) + 1;
#     millis += hours * 3600 * 1000;
#     if (isDuringOfficeHours(millis)) {
#       retVal.push(millis);
#     }
#   }
#   return retVal;
# }
# function isDuringOfficeHours(millis) {
#   const aDate = new Date(millis);
#   return aDate.getDay() != 0 && aDate.getDay() != 6 &&
#          aDate.getHours() >= 9 && aDate.getHours() <= 17;
# }
# function formatDate(millis) {
#   const aDate = new Date(millis);
#   const days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
#   const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
#                   'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
#   return days[aDate.getDay()] + ' ' + aDate.getDate() + ' ' +
#          months[aDate.getMonth()] + ', ' + aDate.getHours() + ':' +
#          (aDate.getMinutes() < 10? '0'+aDate.getMinutes(): aDate.getMinutes());
# }
# Copied!
# Now that your files have been built, view your changes. Run the following command in Cloud Shell to deploy your application:

# firebase deploy
# Copied!
# Output:

# ✔  Deploy complete!
# Project Console: https://console.firebase.google.com/project/qwiklabs-gcp-7d652f8cf1f91cce/overview
# Hosting URL: https://qwiklabs-gcp-01-8be196f95006.web.app
# Refresh your web app tab, where you previously got the blank page. Go ahead and schedule a couple of appointments:
# Scheduled appointments window

# Now go to the Firebase Console, click Build > Firestore Database and select the appointments collection that you just created under your user.

# You should see a similar collection of appointments codes:

# appointments codes

# Task 13. See Firestore real-time updates
# Firestore is a real-time database. Add real time updates to the application to take advantage of this.

# Open a new browser tab and point it to [PROJECT ID].web.app, then log in using the Google button and click Appointments.

# Arrange the two browser tabs side-by-side. In the first browser window, schedule a new appointment.

# Now look at your other browser tab—you should see the appointment automatically added without having to refresh:

# Scheduled appointments window

# Pretty cool! Firestore updates clients (web apps and native mobile apps) in real time, without the user having to refresh or reload.

# Go to the Firebase Console, click the Data tab in Cloud Firestore, and edit the data. You can even delete the appointments collection under your user record. Both browser windows keep updating in real time.

# Congratulations!
# Throughout the course of this lab, you created a robust serverless web application with Firebase. After creating and configuring a Firebase Project, you added Firestore security to automate server-side authentication and authorization. You then went ahead and added Google Sign-in to your web app and configured your database so users can add contact info and appointments. Finally, you explored and deployed code that allows users to schedule appointments and saw Firebase's real time updates in your web app. You are ready to take more labs in this learning path.

# Finish your quest
# This self-paced lab is part of the Google Cloud Run Serverless Workshop and Build Apps & Websites with Firebase quests. A quest is a series of related labs that form a learning path. Completing a quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in any quest that contains this lab and get immediate completion credit. Refer to the Google Cloud Skills Boost catalog for all available quests.

# Take your next lab
# Continue your quest with the next lab in the series, Build a Serverless App with Cloud Run that Creates PDF Files or Deploy a Hugo Website with Cloud Build and Firebase Pipeline.

# Next steps / Learn more
# Google Cloud - What is Serverless?

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated May 11, 2023

# Lab Last Tested May 11, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# # Here's another lab we think you'll like.