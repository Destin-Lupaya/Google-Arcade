# Importing Data to a Firestore Database
# 30 minutes
# 1 Credit
# GSP642
# Google Cloud self-paced labs logo

# Pet Theory banner

# Overview
# For the labs in the Google Cloud Serverless Workshop: Pet Theory Quest, you will read through a fictitious business scenario and assist the characters with their serverless migration plan.

# Twelve years ago, Lily started the Pet Theory chain of veterinary clinics. The Pet Theory chain has expanded rapidly over the last few years. However, their old appointment scheduling system is not able to handle the increased load, so Lily is asking you to build a cloud-based system that scales better than the legacy solution.

# Pet Theory's Ops team is a single person, Patrick, so they need a solution that doesn't require lots of ongoing maintenance. The team has decided to go with serverless technology.

# Ruby has been hired as a consultant to help Pet Theory make the transition to serverless. After comparing serverless database options, the team decides to go with Cloud Firestore. Since Firestore is serverless, capacity doesn't have to be provisioned ahead of time which means that there is no risk of running into storage or operations limits. Firestore keeps your data in sync across client apps through real-time listeners and offers offline support for mobile and web, so a responsive app can be built that works regardless of network latency or Internet connectivity.

# In this lab you will help Patrick upload Pet Theory's existing data to a Cloud Firestore database. He will work closely with Ruby to accomplish this.

# Architecture
# This diagram gives you an overview of the services you will be using and how they connect to one another:

# Migrating to a Firestore Database architecture diagram

# What you'll learn
# In this lab, you will learn how to:

# Set up Firestore in Google Cloud.
# Write database import code.
# Generate a collection of customer data for testing.
# Import the test customer data into Firestore.
# Prerequisites
# This is a fundamental level lab. This assumes familiarity with the Cloud Console and shell environments. Experience with Firebase will be helpful, but is not required.

# You should also be comfortable editing files. You can use your favorite text editor (like nano, vi, etc.) or you can launch the code editor from Cloud Shell, which can be found in the top ribbon:

# Open Editor button

# Once you're ready, scroll down and follow the steps below to set up your lab environment.

# Setup and requirements
# Note: This lab provisions two usernames. One to login to Google Cloud. Another for learning how to add a developer to a Google Cloud project without giving them Firestore access. While following the setup instructions, use Username 1 as your login.
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
# Activate Cloud Shell
# Cloud Shell is a virtual machine that is loaded with development tools. It offers a persistent 5GB home directory and runs on the Google Cloud. Cloud Shell provides command-line access to your Google Cloud resources.

# Click Activate Cloud Shell Activate Cloud Shell icon at the top of the Google Cloud console.
# When you are connected, you are already authenticated, and the project is set to your PROJECT_ID. The output contains a line that declares the PROJECT_ID for this session:

# Your Cloud Platform project in this session is set to YOUR_PROJECT_ID
# gcloud is the command-line tool for Google Cloud. It comes pre-installed on Cloud Shell and supports tab-completion.

# (Optional) You can list the active account name with this command:

# gcloud auth list
# Copied!
# Click Authorize.

# Your output should now look like this:

# Output:

# ACTIVE: *
# ACCOUNT: student-01-xxxxxxxxxxxx@qwiklabs.net
# To set the active account, run:
#     $ gcloud config set account `ACCOUNT`
# (Optional) You can list the project ID with this command:

# gcloud config list project
# Copied!
# Output:

# [core]
# project = <project_ID>
# Example output:

# [core]
# project = qwiklabs-gcp-44776a13dea667a6
# Note: For full documentation of gcloud, in Google Cloud, refer to the gcloud CLI overview guide.
# Task 1. Set up Firestore in Google Cloud
# Patrick's task is to upload Pet Theory's existing data to a Cloud Firestore database. He will work closely with Ruby to accomplish this goal. Ruby receives a message from Patrick in IT...

# Patrick

# Patrick, IT Administrator

# Hi Ruby,

# Our first step in going serverless is creating a Firestore database with Google Cloud. Can you help with this task? I am not very familiar with setting this up.

# Patrick

# Ruby

# Ruby, Software Consultant

# Hey Patrick,

# Sure, I would be happy to help with that. I'll send you some resources to get started, let's get in touch once you're done creating the database.

# Ruby

# Help Patrick set up a Firestore database through the Cloud Console.

# In the Cloud Console, go to the Navigation menu and select Firestore.

# Click the Select Native Mode button.

# Note: Both modes are high performing with strong consistency, but they look different and are optimized for different use cases.
# Native Mode is good for letting lots of users access the same data at the same time (plus, it has features like real-time updates and direct connection between your database and a web/mobile client
# Datastore Mode puts an emphasis on high throughput (lots of reads and writes).
# In the Select a location dropdown, choose a database region closest to your location and then click Create Database.
# On completion of the task, Ruby emails Patrick...

# Ruby

# Ruby, Software Consultant

# Hey Patrick,

# Great work setting up the Firestore database! To manage database access, we will use a Service Account that has been automatically created with the necessary privileges.

# We are now ready to migrate from the old database to Firestore.

# Ruby

# Patrick

# Patrick, IT Administrator

# Hey Ruby,

# Thanks for the help, setting up the Firestore database was straightforward.

# I hope the database import process will be easier than it is with the legacy database, which is quite complex and requires a lot of steps.

# Patrick

# Task 2. Write database import code
# The new Cloud Firestore database is in place, but it's empty. The customer data for Pet Theory still only exists in the old database.

# Patrick sends a message to Ruby...

# Patrick

# Patrick, IT Administrator

# Hi Ruby,

# My manager would like to begin migrating the customer data to the new Firestore database.

# I have exported a CSV file from our legacy database, but it's not clear to me how to import this data into Firestore.

# Any chance you can lend me a hand?

# Patrick

# Ruby

# Ruby, Software Consultant

# Hey Patrick,

# Sure, let's set up a meeting to discuss what needs to be done.

# Ruby

# As Patrick said, the customer data will be available in a CSV file. Help Patrick create an app that reads customer records from a CSV file and writes them to Firestore. Since Patrick is familiar with Javascript, build this application with the Node.js JavaScript runtime.

# In Cloud Shell, run the following command to clone the Pet Theory repository:

# git clone https://github.com/rosera/pet-theory
# Copied!
# Use the Cloud Shell Code Editor (or your preferred editor) to edit your files. From the top ribbon of your Cloud Shell session, click Open Editor, it will open a new tab. If prompted, click Open in a new window to launch the code editor:
# Open Editor button

# Then change your current working directory to lab01:

# cd pet-theory/lab01
# Copied!
# In the directory you can see Patrick's package.json. This file lists the packages that your Node.js project depends on and makes your build reproducible, and therefore easier to share with others.

# An example package.json is shown below:

# {
# 	"name": "lab01",
# 	"version": "1.0.0",
# 	"description": "This is lab01 of the Pet Theory labs",
# 	"main": "index.js",
# 	"scripts": {
# 		"test": "echo \"Error: no test specified\" && exit 1"
# 	},
# 	"keywords": [],
# 	"author": "Patrick - IT",
# 	"license": "MIT",
# 	"dependencies": {
# 		"csv-parse": "^4.4.5"
# 	}
# }
# Now that Patrick has his source code imported, he gets in touch with Ruby to see what packages he needs to make the migration work.

# Patrick

# Patrick, IT Administrator

# Hi Ruby,

# The code I use for the legacy database is pretty basic, it just creates a CSV ready for the import process. Anything I need to download before I get started?

# Patrick

# Ruby

# Ruby, Software Consultant

# Hi Patrick,

# I would suggest using one of the many @google-cloud Node packages to interact with Firestore.

# We should then only need to make small changes to the existing code since the heavy lifting has been taken care of.

# Ruby

# To allow Patrick's code to write to the Firestore database, you need to install some additional peer dependencies.

# Run the following command to do so:

# npm install @google-cloud/firestore
# Copied!
# To enable the app to write logs to Cloud Logging, install an additional module:

# npm install @google-cloud/logging
# Copied!
# After successful completion of the command, the package.json will be automatically updated to include the new peer dependencies, and will look like this.

# ...
# "dependencies": {
#   "@google-cloud/firestore": "^6.4.1",
#   "@google-cloud/logging": "^10.3.1",
#   "csv-parse": "^4.4.5"
# }
# Now it's time to take a look at the script that reads the CSV file of customers and writes one record in Firestore for each line in the CSV file. Patrick's original application is shown below:

# const { promisify } = require("util");
# const parse = promisify(require("csv-parse"));
# const { readFile } = require("fs").promises;
# if (process.argv.length < 3) {
# 	console.error("Please include a path to a csv file");
# 	process.exit(1);
# }
# function writeToDatabase(records) {
# 	records.forEach((record, i) => {
# 		console.log(
# 			`ID: ${record.id} Email: ${record.email} Name: ${record.name} Phone: ${record.phone}`
# 		);
# 	});
# 	return;
# }
# async function importCsv(csvFileName) {
# 	const fileContents = await readFile(csvFileName, "utf8");
# 	const records = await parse(fileContents, { columns: true });
# 	try {
# 		await writeToDatabase(records);
# 	} catch (e) {
# 		console.error(e);
# 		process.exit(1);
# 	}
# 	console.log(`Wrote ${records.length} records`);
# }
# importCsv(process.argv[2]).catch((e) => console.error(e));
# It takes the output from the input CSV file and imports it into the legacy database. Next, update this code to write to Firestore.

# Open the file pet-theory/lab01/importTestData.js.
# To reference the Firestore API via the application, you need to add the peer dependency to the existing codebase.

# Add the following Firestore dependency on line 4 of the file:

# const { Firestore } = require("@google-cloud/firestore");
# Copied!
# Ensure that the top of the file looks like this:

# const { promisify } = require("util");
# const parse = promisify(require("csv-parse"));
# const { readFile } = require("fs").promises;
# const { Firestore } = require("@google-cloud/firestore"); // add this
# Integrating with the Firestore database can be achieved with a couple of lines of code. Ruby has shared some template code with you and Patrick for exactly that purpose.

# Add the following code underneath line 9, or the if (process.argv.length < 3) conditional:

# const db = new Firestore();
# function writeToFirestore(records) {
# 	const batchCommits = [];
# 	let batch = db.batch();
# 	records.forEach((record, i) => {
# 		var docRef = db.collection("customers").doc(record.email);
# 		batch.set(docRef, record);
# 		if ((i + 1) % 500 === 0) {
# 			console.log(`Writing record ${i + 1}`);
# 			batchCommits.push(batch.commit());
# 			batch = db.batch();
# 		}
# 	});
# 	batchCommits.push(batch.commit());
# 	return Promise.all(batchCommits);
# }
# Copied!
# The above code snippet declares a new database object, which references the database created earlier in the lab. The function uses a batch process in which each of the records is processed in turn and sets a document reference based on the identifier added. At the end of the function, the batch content is written to the database.

# Finally, you need to add a call to the new function. Update the importCsv function to add the function call to writeToFirestore and remove the call to writeToDatabase. It should look like this:

# async function importCsv(csvFileName) {
# 	const fileContents = await readFile(csvFileName, "utf8");
# 	const records = await parse(fileContents, { columns: true });
# 	try {
# 		await writeToFirestore(records);
# 		// await writeToDatabase(records);
# 	} catch (e) {
# 		console.error(e);
# 		process.exit(1);
# 	}
# 	console.log(`Wrote ${records.length} records`);
# }
# Next, add logging for the application. To reference the Logging API via the application, add the peer dependency to the existing codebase. Add the line following line just below the other require statements at the top of the file:

# const {Logging} = require('@google-cloud/logging');
# Copied!
# Ensure that the top of the file looks like this:

# const { promisify } = require("util");
# const parse = promisify(require("csv-parse"));
# const { readFile } = require("fs").promises;
# const { Firestore } = require("@google-cloud/firestore");
# const { Logging } = require("@google-cloud/logging"); //add this
# Add a few constant variables and initialize the Logging client. Add those just below the above lines in the file (~line 5), like this:

# const logName = "pet-theory-logs-importTestData";
# // Creates a Logging client
# const logging = new Logging();
# const log = logging.log(logName);
# const resource = {
# 	type: "global",
# };
# Copied!
# Add code to write the logs in importCsv function just below the line console.log(Wrote ${records.length} records); which should look like this:

# // A text log entry
# success_message = `Success: importTestData - Wrote ${records.length} records`;
# const entry = log.entry(
# 	{ resource: resource },
# 	{ message: `${success_message}` }
# );
# log.write([entry]);
# Copied!
# After these updates, your importCsv function code block should look like the following:

# async function importCsv(csvFileName) {
# 	const fileContents = await readFile(csvFileName, "utf8");
# 	const records = await parse(fileContents, { columns: true });
# 	try {
# 		await writeToFirestore(records);
# 		//await writeToDatabase(records);
# 	} catch (e) {
# 		console.error(e);
# 		process.exit(1);
# 	}
# 	console.log(`Wrote ${records.length} records`);
# 	// A text log entry
# 	success_message = `Success: importTestData - Wrote ${records.length} records`;
# 	const entry = log.entry(
# 		{ resource: resource },
# 		{ message: `${success_message}` }
# 	);
# 	log.write([entry]);
# }
# Now when the application code is running, the Firestore database will be updated with the contents of the CSV file. The function importCsv takes a filename and parses the content on a line by line basis. Each line processed is now sent to the Firestore function writeToFirestore, where each new record is written to the "customer" database.

# Note: In a production environment, you will write your own version of the import script.
# Task 3. Create test data
# Time to import some data! Patrick contacts Ruby about a concern he has about running a test with real customer data...

# Patrick

# Patrick, IT Administrator

# Hi Ruby,

# I think it would be better if we don't use customer data for testing. We need to maintain customer privacy, but also need to have some confidence that our data import script works correctly.

# Can you think of an alternative way to test?

# Patrick

# Ruby

# Ruby, Software Consultant

# Hey Patrick,

# Fair point, Patrick. This is a tricky area, as customer data may include personal identifiable information, also called PII.

# I'll share some starter code with you to create pseudo customer data. We can then use this data to test the import script.

# Ruby

# Help Patrick get this pseudo-random data generator up and running.

# First, install the "faker" library, which will be used by the script that generates the fake customer data. Run the following command to update the dependency in package.json:

# npm install faker@5.5.3
# Copied!
# Now open the file named createTestData.js with the code editor and inspect the code. Ensure it looks like the following:

# const fs = require("fs");
# const faker = require("faker");
# function getRandomCustomerEmail(firstName, lastName) {
# 	const provider = faker.internet.domainName();
# 	const email = faker.internet.email(firstName, lastName, provider);
# 	return email.toLowerCase();
# }
# async function createTestData(recordCount) {
# 	const fileName = `customers_${recordCount}.csv`;
# 	var f = fs.createWriteStream(fileName);
# 	f.write("id,name,email,phone\n");
# 	for (let i = 0; i < recordCount; i++) {
# 		const id = faker.datatype.number();
# 		const firstName = faker.name.firstName();
# 		const lastName = faker.name.lastName();
# 		const name = `${firstName} ${lastName}`;
# 		const email = getRandomCustomerEmail(firstName, lastName);
# 		const phone = faker.phone.phoneNumber();
# 		f.write(`${id},${name},${email},${phone}\n`);
# 	}
# 	console.log(`Created file ${fileName} containing ${recordCount} records.`);
# }
# recordCount = parseInt(process.argv[2]);
# if (process.argv.length != 3 || recordCount < 1 || isNaN(recordCount)) {
# 	console.error("Include the number of test data records to create. Example:");
# 	console.error("    node createTestData.js 100");
# 	process.exit(1);
# }
# createTestData(recordCount);
# Add Logging for the codebase. On line 3, add the following reference for the Logging API module from the application code:

# const { Logging } = require("@google-cloud/logging");
# Copied!
# The top of the file should now look like this:

# const fs = require("fs");
# const faker = require("faker");
# const { Logging } = require("@google-cloud/logging"); //add this
# Now, add a few constant variables and initialize the Logging client. Add those just below the const statements:

# const logName = "pet-theory-logs-createTestData";
# // Creates a Logging client
# const logging = new Logging();
# const log = logging.log(logName);
# const resource = {
# 	// This example targets the "global" resource for simplicity
# 	type: "global",
# };
# Copied!
# Add code to write the logs in the createTestData function just below the line console.log(Created file ${fileName} containing ${recordCount} records.); which will look like this:

# // A text log entry
# const success_message = `Success: createTestData - Created file ${fileName} containing ${recordCount} records.`;
# const entry = log.entry(
# 	{ resource: resource },
# 	{
# 		name: `${fileName}`,
# 		recordCount: `${recordCount}`,
# 		message: `${success_message}`,
# 	}
# );
# log.write([entry]);
# Copied!
# After updating, the createTestData function code block should look like this:

# async function createTestData(recordCount) {
# 	const fileName = `customers_${recordCount}.csv`;
# 	var f = fs.createWriteStream(fileName);
# 	f.write("id,name,email,phone\n");
# 	for (let i = 0; i < recordCount; i++) {
# 		const id = faker.datatype.number();
# 		const firstName = faker.name.firstName();
# 		const lastName = faker.name.lastName();
# 		const name = `${firstName} ${lastName}`;
# 		const email = getRandomCustomerEmail(firstName, lastName);
# 		const phone = faker.phone.phoneNumber();
# 		f.write(`${id},${name},${email},${phone}\n`);
# 	}
# 	console.log(`Created file ${fileName} containing ${recordCount} records.`);
# 	// A text log entry
# 	const success_message = `Success: createTestData - Created file ${fileName} containing ${recordCount} records.`;
# 	const entry = log.entry(
# 		{ resource: resource },
# 		{
# 			name: `${fileName}`,
# 			recordCount: `${recordCount}`,
# 			message: `${success_message}`,
# 		}
# 	);
# 	log.write([entry]);
# }
# Run the following command to configure your Project ID in Cloud Shell, replacing PROJECT_ID with your Qwiklabs Project ID:

# gcloud config set project PROJECT_ID
# Copied!
# Now set the project ID as an environment variable:

# PROJECT_ID=$(gcloud config get-value project)
# Copied!
# Run the following command in Cloud Shell to create the file customers_1000.csv, which will contain 1000 records of test data:

# node createTestData 1000
# Copied!
# You should receive a similar output:

# Created file customers_1000.csv containing 1000 records.
# Open the file customers_1000.csv and verify that the test data has been created.
# Test completed task

# Click Check my progress to verify your performed task. If you have successfully created a sample test data for the Firestore Database, you will see an assessment score.

# Create test data for the Firestore Database
# Task 4. Import the test customer data
# To test the import capability, use both the import script and the test data created earlier:

# node importTestData customers_1000.csv
# Copied!
# You should receive a similar output:

# Writing record 500
# Writing record 1000
# Wrote 1000 records
# If you get an error that resembles the following:
# Error: Cannot find module 'csv-parse'
# Run the following command to add the csv-parse package to your environment:

# npm install csv-parse
# Copied!
# Then run the command again. You should receive the following output:
# Writing record 500
# Writing record 1000
# Wrote 1000 records
# At this point, if you are feeling adventurous, feel free to create a larger test data file and import it into the Firestore database:

# node createTestData 20000
# node importTestData customers_20000.csv
# Copied!
# You should receive a similar output:

# Writing record 500
# Writing record 1000
# ..
# ..
# Writing record 15000
# Writing record 15500
# Writing record 16000
# Writing record 16500
# Writing record 17000
# Writing record 17500
# Writing record 18000
# Writing record 18500
# Writing record 19000
# Writing record 19500
# Writing record 20000
# Wrote 20000 records
# Over the past couple of sections you have seen how Patrick and Ruby have created test data and a script to import data into Firestore. Patrick now feels more confident about loading customer data into the Firestore database.

# Test completed task

# Click Check my progress to verify your performed task. If you have successfully imported sample test data into the Firestore Database, you will see an assessment score.

# Import test data into the Firestore Database
# Task 5. Inspect the data in Firestore
# With a little help from you and Ruby, Patrick has now successfully migrated the test data to the Firestore database. Open up Firestore and see the results!

# Return to your Cloud Console tab. In the Navigation menu click on Firestore. Once there, click on the pencil icon.
# Pencil icon

# Type in /customers and press Enter.

# Refresh your browser tab and you should see the following list of customers successfully migrated:

# customers list

# Congratulations!
# Throughout the course of this lab, you received hands-on practice with Firestore. After generating a collection of customer data for testing, you ran a script that imported the data into Firestore. You then learned how to manipulate data in Firestore through the Cloud Console.

# Finish your quest
# This self-paced lab is part of the Google Cloud Run Serverless Workshop and Build Apps & Websites with Firebase quests. A quest is a series of related labs that form a learning path. Completing a quest earns you a badge to recognize your achievement. You can make your badge or badges public and link to them in your online resume or social media account. Enroll in any quest that contains this lab and get immediate completion credit. Refer to the Google Cloud Skills Boost catalog for all available quests.

# Take your next lab
# Continue your quest with the next lab in the series, Build a Serverless Web App with Firebase.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated July 5, 2023
# Lab Last Tested July 5, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.