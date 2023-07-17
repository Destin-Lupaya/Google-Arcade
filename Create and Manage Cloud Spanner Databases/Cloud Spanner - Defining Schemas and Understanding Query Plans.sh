# Cloud Spanner - Defining Schemas and Understanding Query Plans
# 1 hour 30 minutes
# 1 Credit
# GSP1050
# Google Cloud self-paced labs logo

# Overview
# Cloud Spanner is Google’s fully managed, horizontally scalable relational database service. Customers in financial services, gaming, retail and many other industries trust it to run their most demanding workloads, where consistency and availability at scale are critical.

# In this lab you review schema related features of Cloud Spanner and apply those to a Banking Operations database. You also review the methods and rules by which Cloud Spanner creates query plans.

# Objectives
# In this lab, you learn to modify schema related attributes of a Cloud Spanner instance.

# Load data into tables

# Use pre-defined Python client library code to load data

# Query data with client libraries

# Make updates to the database schema

# Add a Secondary Index

# Examine Query plans

# Setup and requirements
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
# Cloud Spanner instance
# In order to allow you to move more quickly through this lab a Cloud Spanner instance, database, and tables were automatically created for you.

# Here are some details for your reference:

# Item	Name	Details
# Cloud Spanner Instance	banking-ops-instance	This is the project-level instance
# Cloud Spanner Database	banking-ops-db	This is the instance specific database
# Table	Portfolio	Contains top-level bank offerings
# Table	Category	Contains second-tier bank offering groupings
# Table	Product	Contains specific line-item bank offerings
# Table	Campaigns	Contains details on marketing initiatives
# Task 1. Load data into tables
# The banking-ops-db was created with empty tables. Follow the steps below to load data into three of the tables (Portfolio, Category, and Product).

# From the Cloud Console, open the navigation menu (console_nav_small.png), under Databases click Spanner.
# The instance name is banking-ops-instance, click on it to explore the databases. The associated database is named banking-ops-db. Click on it and you will see there are four tables already in place.

# On the left pane of the Console, click Query.

# This takes you to the Query page. Paste the insert statements below as a single block to load the Portfolio table. Spanner will execute each in succession. Click Run:

# insert into Portfolio (PortfolioId, Name, ShortName, PortfolioInfo) values (1, "Banking", "Bnkg", "All Banking Business");
# insert into Portfolio (PortfolioId, Name, ShortName, PortfolioInfo) values (2, "Asset Growth", "AsstGrwth", "All Asset Focused Products");
# insert into Portfolio (PortfolioId, Name, ShortName, PortfolioInfo) values (3, "Insurance", "Ins", "All Insurance Focused Products");
# Copied!
# The lower page of the screen shows the results of inserting the data one row at a time. The Portfolio table now has three rows.

# Click Clear Query in the top portion of the page.

# Paste the insert statements below as a single block to load the Category table. Click Run:

# insert into Category (CategoryId,PortfolioId,CategoryName) values (1,1,"Cash");
# insert into Category (CategoryId,PortfolioId,CategoryName) values (2,2,"Investments - Short Return");
# insert into Category (CategoryId,PortfolioId,CategoryName) values (3,2,"Annuities");
# insert into Category (CategoryId,PortfolioId,CategoryName) values (4,3,"Life Insurance");
# Copied!
# The lower page of the screen shows the results of inserting the data one row at a time. The Category table now has four rows.

# Click Clear Query in the top portion of the page.

# Paste the insert statements below as a single block to load the Product table. Click Run:

# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (1,1,1,"Checking Account","ChkAcct","Banking LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (2,2,2,"Mutual Fund Consumer Goods","MFundCG","Investment LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (3,3,2,"Annuity Early Retirement","AnnuFixed","Investment LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (4,4,3,"Term Life Insurance","TermLife","Insurance LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (5,1,1,"Savings Account","SavAcct","Banking LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (6,1,1,"Personal Loan","PersLn","Banking LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (7,1,1,"Auto Loan","AutLn","Banking LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (8,4,3,"Permanent Life Insurance","PermLife","Insurance LOB");
# insert into Product (ProductId,CategoryId,PortfolioId,ProductName,ProductAssetCode,ProductClass) values (9,2,2,"US Savings Bonds","USSavBond","Investment LOB");
# Copied!
# The lower page of the screen shows the results of inserting the data one row at a time. The Product table now has nine rows.

# Click Check my progress to verify the objective.

# Load Data into Portfolio, Category, and Product Tables
# Task 2. Use pre-built Python client library code to load data
# You will be using the client libraries written in Python for the next several steps.

# Open the Cloud Shell and paste the commands below to create and change into a new directory to hold the required files.

# mkdir python-helper
# cd python-helper
# Copied!
# Next download two files. One is used to setup the environment. The other is the lab code.

# wget https://storage.googleapis.com/cloud-training/OCBL373/requirements.txt
# wget https://storage.googleapis.com/cloud-training/OCBL373/snippets.py
# Copied!
# Create an isolated Python environment and install dependencies for the Cloud Spanner client.

# virtualenv env
# source env/bin/activate
# pip install -r requirements.txt
# Copied!
# The snippets.py is a consolidated file with multiple Cloud Spanner DDL, DML, and DCL functions that you are going to use as a helper during this lab. Execute snippets.py using the insert_data argument to populate the Campaigns table.

# python snippets.py banking-ops-instance --database-id  banking-ops-db insert_data
# Copied!
# Click Check my progress to verify the objective.
# Load Data into Campaigns Table
# Task 3. Query data with client libraries
# The query_data() function in snippets.py can be used to query your database. In this case you use it to confirm the data loaded into the Campaigns table. You will not change any code, the section is shown here for your reference.

# def query_data(instance_id, database_id):
#     """Queries sample data from the database using SQL."""
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     with database.snapshot() as snapshot:
#         results = snapshot.execute_sql(
#             "SELECT CampaignId,PortfolioId,CampaignStartDate,CampaignEndDate,CampaignName,CampaignBudget FROM Campaigns"
#         )
#         for row in results:
#             print(u"CampaignId: {}, PortfolioId: {}, CampaignStartDate: {}, CampaignEndDate: {}, CampaignName: {}, CampaignBudget: {}".format(*row))
# Execute snippets.py using the query_data argument to query the Campaigns table.

# python snippets.py banking-ops-instance --database-id  banking-ops-db query_data
# Copied!
# The result should look like the following

# CampaignId: 1, PortfolioId: 1, CampaignStartDate: 2022-06-07, CampaignEndDate: 2022-06-07, CampaignName: New Account Reward, CampaignBudget: 15000
# CampaignId: 2, PortfolioId: 2, CampaignStartDate: 2022-06-07, CampaignEndDate: 2022-06-07, CampaignName: Intro to Investments, CampaignBudget: 5000
# CampaignId: 3, PortfolioId: 2, CampaignStartDate: 2022-06-07, CampaignEndDate: 2022-06-07, CampaignName: Youth Checking Accounts, CampaignBudget: 25000
# CampaignId: 4, PortfolioId: 3, CampaignStartDate: 2022-06-07, CampaignEndDate: 2022-06-07, CampaignName: Protect Your Family, CampaignBudget: 10000
# Task 4. Updating the database schema
# As part of your DBA responsibilities you are required to add a new column called MarketingBudget to the Category table. Adding a new column to an existing table requires an update to your database schema. Cloud Spanner supports schema updates to a database while the database continues to serve traffic. Schema updates do not require taking the database offline and they do not lock entire tables or columns; you can continue reading and writing data to the database during the schema update.

# Adding a column using Python
# The update_ddl() method of the Database class is used to modify the schema.

# Use the add_column() function in snippets.py which implements that method. You will not change any code, the section is shown here for your reference.

# def add_column(instance_id, database_id):
#     """Adds a new column to the Albums table in the example database."""
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     operation = database.update_ddl(
#         ["ALTER TABLE Category ADD COLUMN MarketingBudget INT64"]
#     )
#     print("Waiting for operation to complete...")
#     operation.result(OPERATION_TIMEOUT_SECONDS)
#     print("Added the MarketingBudget column.")
# Execute snippets.py using the add_column argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db add_column
# Copied!
# Click Check my progress to verify the objective.
# Add column to Category table
# Other options to add a column to an existing table include the following:
# Issuing a DDL command via the gcloud CLI.
# Note: This option is shown as an alternate example. Do not issue this command.
# The code sample below completes the same task you just executed via Python.

# gcloud spanner databases ddl update banking-ops-db --instance=banking-ops-instance --ddl='ALTER TABLE Category ADD COLUMN MarketingBudget INT64;'
# Issuing a DDL command in the Cloud Console.
# Note: This option is shown as an alternate example. Do not perform this action.
# Click the table name in the Database listing.
# Click Write DDL in the top right corner of the page.
# Paste the appropriate DDL in the DDL Templates box.
# Click Submit.
# AddColumnUI.png

# Write data to the new column
# The following code writes data to the new column. It sets MarketingBudget to 100000 for the row with a CategoryId of 1 and a PortfolioId of 1 and to 500000 for the row with a CategoryId of 3 and a PortfolioId of 2. You will not change any code, the section is shown here for your reference.

# def update_data(instance_id, database_id):
#     """Updates sample data in the database.
#     This updates the `MarketingBudget` column which must be created before
#     running this sample. You can add the column by running the `add_column`
#     sample or by running this DDL statement against your database
#     """
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     with database.batch() as batch:
#         batch.update(
#             table="Category",
#             columns=("CategoryId", "PortfolioId", "MarketingBudget"),
#             values=[(1, 1, 100000), (3, 2, 500000)],
#         )
#     print("Updated data.")
# Execute snippets.py using the update_data argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db update_data
# Copied!
# Query the table again to see the update. Execute snippets.py using the query_data_with_new_column argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db query_data_with_new_column
# Copied!
# The result should be:

# CategoryId: 1, PortfolioId: 1, MarketingBudget: 100000
# CategoryId: 2, PortfolioId: 2, MarketingBudget: None
# CategoryId: 3, PortfolioId: 2, MarketingBudget: 500000
# CategoryId: 4, PortfolioId: 3, MarketingBudget: None
# Task 5. Add a Secondary Index
# Suppose you wanted to fetch all rows of Categories that have CategoryNames values in a certain range. You could read all values from the CategoryName column using a SQL statement or a read call, and then discard the rows that don't meet the criteria, but doing this full table scan is expensive, especially for tables with a lot of rows. Instead you can speed up the retrieval of rows when searching by non-primary key columns by creating a secondary index on the table.

# Adding a secondary index to an existing table requires a schema update. Like other schema updates, Cloud Spanner supports adding an index while the database continues to serve traffic. Cloud Spanner populates the index with data (also known as a "backfill") under the hood. Backfills might take several minutes to complete, but you don't have to take the database offline or avoid writing to certain tables or columns during this process.

# Add a secondary index using the Python client library
# Use the add_index() method to create a secondary index. You will not change any code, the section is shown here for your reference.

# def add_index(instance_id, database_id):
#     """Adds a simple index to the example database."""
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     operation = database.update_ddl(
#         ["CREATE INDEX CategoryByCategoryName ON Category(CategoryName)"]
#     )
#     print("Waiting for operation to complete...")
#     operation.result(OPERATION_TIMEOUT_SECONDS)
#     print("Added the CategoryByCategoryName index.")
# Execute snippets.py using the add_index argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db add_index
# Copied!
# Click Check my progress to verify the objective.
# Add secondary index to Category table
# Read using the index
# To read using the index, invoke a variation of the read() method with an index included. You will not change any code, the section is shown here for your reference.

# def read_data_with_index(instance_id, database_id):
#     """Reads sample data from the database using an index.
#     """
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     with database.snapshot() as snapshot:
#         keyset = spanner.KeySet(all_=True)
#         results = snapshot.read(
#             table="Category",
#             columns=("CategoryId", "CategoryName"),
#             keyset=keyset,
#             index="CategoryByCategoryName",
#         )
#         for row in results:
#             print("CategoryId: {}, CategoryName: {}".format(*row))
# Execute snippets.py using the read_data_with_index argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db read_data_with_index
# Copied!
# The result should look like this:

# CategoryId: 3, CategoryName: Annuities
# CategoryId: 1, CategoryName: Cash
# CategoryId: 2, CategoryName: Investments - Short Return
# CategoryId: 4, CategoryName: Life Insurance
# Add an index with a STORING clause
# You might have noticed that the read example above did not include reading the MarketingBudget column. This is because Cloud Spanner's read interface does not support the ability to join an index with a data table to look up values that are not stored in the index.

# To bypass this restriction, create an alternate definition of the CategoryByCategoryName index that stores a copy of MarketingBudget in the index.

# Use the update_ddl() method of the Database class to add an index with a STORING clause. You will not change any code, the section is shown here for your reference.

# def add_storing_index(instance_id, database_id):
#     """Adds an storing index to the example database."""
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     operation = database.update_ddl(
#         [
#             "CREATE INDEX CategoryByCategoryName2 ON Category(CategoryName)"
#             "STORING (MarketingBudget)"
#         ]
#     )
#     print("Waiting for operation to complete...")
#     operation.result(OPERATION_TIMEOUT_SECONDS)
#     print("Added the CategoryByCategoryName2 index.")
# Execute snippets.py using the add_storing_index argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db add_storing_index
# Copied!
# Now you can execute a read that fetches the CategoryId, CategoryName, and MarketingBudget columns while using the CategoryByCategoryName2 index. You will not change any code, the section is shown here for your reference.

# def read_data_with_storing_index(instance_id, database_id):
#     """Reads sample data from the database using an index with a storing
#     clause.
#     """
#     spanner_client = spanner.Client()
#     instance = spanner_client.instance(instance_id)
#     database = instance.database(database_id)
#     with database.snapshot() as snapshot:
#         keyset = spanner.KeySet(all_=True)
#         results = snapshot.read(
#             table="Category",
#             columns=("CategoryId", "CategoryName", "MarketingBudget"),
#             keyset=keyset,
#             index="CategoryByCategoryName2",
#         )
#         for row in results:
#             print(u"CategoryNameId: {}, CategoryName: {}, " "MarketingBudget: {}".format(*row))
# Execute snippets.py using the read_data_with_storing_index argument.

# python snippets.py banking-ops-instance --database-id  banking-ops-db read_data_with_storing_index
# Copied!
# The result should be

# CategoryNameId: 3, CategoryName: Annuities, MarketingBudget: 500000
# CategoryNameId: 1, CategoryName: Cash, MarketingBudget: 100000
# CategoryNameId: 2, CategoryName: Investments - Short Return, MarketingBudget: None
# CategoryNameId: 4, CategoryName: Life Insurance, MarketingBudget: None
# Task 6. Examine Query plans
# In this section, you will explore Cloud Spanner Query Plans.

# Return to the Cloud Console, it should still be on the Query tab. Clear any existing query, paste, and Run the following query.

# SELECT Name, ShortName, CategoryName
# FROM Portfolio
# INNER JOIN Category
# ON Portfolio.PortfolioId = Category.PortfolioId;
# Copied!
# The result should look like this:
# SPNQuery1.png

# Life of a query
# A SQL query in Cloud Spanner is first compiled into an execution plan, then it is sent to an initial root server for execution. The root server is chosen so as to minimize the number of hops to reach the data being queried. The root server then:

# Initiates remote execution of subplans (if necessary)
# Waits for results from the remote executions
# Handles any remaining local execution steps such as aggregating results
# Returns results for the query
# Remote servers that receive a subplan act as the "root" server for their subplan, following the same model as the top-most root server. The result is a tree of remote executions. Conceptually, query execution flows from top to bottom, and query results are returned from bottom to top. The following diagram shows this pattern:

# SPNPlan.png

# Aggregate Query
# Now take look at the query plan for an aggregated query.

# On the Query tab of Spanner, clear the existing query, paste, and Run the following query.

# SELECT pr.ProductId, COUNT(*) AS ProductCount
# FROM Product AS pr
# WHERE pr.ProductId < 100
# GROUP BY pr.ProductId;
# Copied!
# Once the query completes click on the Explanation tab to examine the query plan.
# Cloud Spanner sends the execution plan to a root server that coordinates the query execution and performs the remote distribution of subplans.

# This execution plan starts with a serialization which orders all values returned. Then the plan completes an initial hash aggregate operator to preliminarily calculate results. Then a distributed union is executed which distributes subplans to remote servers whose splits satisfy ProductId < 100. The distributed union sends results to a final hash aggregate operator. The aggregate operator performs the COUNT aggregation by ProductId and returns results to a serialize result operator. Finally a scan is conducted to order the results to be returned.

# The result should look like this:

# SPNAggPlan.png

# Tip:To get more details for each step in the query plan, click on any of the operators and the right side of the screen will change accordingly.
# SPNPlanDetail.png

# Co-located join queries
# Interleaved tables are physically stored with their rows of related tables co-located. A join between interleaved tables is known as a co-located join. Co-located joins can offer performance benefits over joins that require indexes or back joins.

# On the Query tab of Spanner, clear the existing query, paste, and Run the following query.

# SELECT c.CategoryName, pr.ProductName
# FROM Category AS c, Product AS pr
# WHERE c.PortfolioId = pr.PortfolioId AND c.CategoryId = pr.CategoryId;
# Copied!
# Once the query completes click on the Explanation tab to examine the query plan.
# This execution plan starts with a distributed union, which distributes subplans to remote servers that have splits of the table Category. Because Product is an interleaved table of Category, each remote server is able to execute the entire subplan on each remote server without requiring a join to a different server.

# The subplans contain a cross apply. Each cross apply performs a table scan on table Category to retrieve PortfolioId, CategoryId, and CategoryName. The cross apply then maps output from the table scan to output from an index scan on index CategoryByCategoryName, subject to a filter of the PortfolioId in the index matching the PortfolioId from the table scan output. Each cross apply sends its results to a serialize result operator which serializes the CategoryName and ProductName data and returns results to the local distributed unions. The distributed union aggregates results from the local distributed unions and returns them as the query result.

# SPNColocated.png

# Congratulations!
# You now have now a solid understanding of schema related features of Cloud Spanner as well as the methods by which Spanner creates query plans.

# Finish your quest
# This self-paced lab is part of the Create and Manage Cloud Spanner Databases quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. You can make your badge (or badges) public and link to them in your online resume or social media account. Enroll in this quest and get immediate completion credit if you have successfully completed this lab. Search for other available quests in the Cloud Skills Boost catalog.

# Manual Last Updated: June 21, 2022
# Lab Last Tested: March 24, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# # Here's another lab we think you'll like.