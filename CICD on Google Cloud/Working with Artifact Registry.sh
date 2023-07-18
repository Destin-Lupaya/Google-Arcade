# Working with Artifact Registry
# 1 hour 30 minutes
# 1 Credit
# GSP1076
# Google Cloud self-paced labs logo

# Overview
# As the evolution of Container Registry, Artifact Registry is a single place for your organization to manage container images and language packages (such as Maven and npm). It is fully integrated with Google Cloud's tooling and runtimes and comes with support for native artifact protocols. This makes it simple to integrate it with your CI/CD tooling to set up automated pipelines.

# In this lab you will learn about some of the features available in Artifact Registry.

# What you will learn
# Create repositories for Containers and Language Packages

# Manage container images with Artifact Registry

# Integrate Artifact Registry with Cloud Code

# Configure Maven to use Artifact Registry for Java Dependencies

# Setup and requirement
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
# You must wait for the lab to provision before making any changes to the environment! The pre-configured parts of the environment that you need to work with will be available to you as soon as the lab indicates it is ready.

# Task 1. Prepare the lab environment
# Set up variables
# In Cloud Shell, set your project ID and project number. Save them as PROJECT_ID and PROJECT_NUMBER variables:
# export PROJECT_ID=$(gcloud config get-value project)
# export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
# export REGION="REGION"
# gcloud config set compute/region $REGION
# Copied!
# Enable Google services
# Run the following to enable necessary Google services:

# gcloud services enable \
#   cloudresourcemanager.googleapis.com \
#   container.googleapis.com \
#   artifactregistry.googleapis.com \
#   containerregistry.googleapis.com \
#   containerscanning.googleapis.com
# Copied!
# Get the source code
# The source code for this lab is located in the GoogleCloudPlatform org on GitHub.

# Clone the source code with the command below, then change into the directory.

# git clone https://github.com/GoogleCloudPlatform/cloud-code-samples/
# cd ~/cloud-code-samples
# Copied!
# Provision the infrastructure used in this lab
# In this lab you will deploy code to Kubernetes Engine (GKE).

# Run the setup script below to prepare this infrastructure:
# gcloud container clusters create container-dev-cluster --zone="ZONE"
# Copied!
# Click Check my progress to verify the objective.

# Enable Google Services and create GKE cluster
# Task 2. Working with container images
# Create a Docker Repository on Artifact registry
# Artifact Registry supports managing container images and language packages. Different artifact types require different specifications. For example, the requests for Maven dependencies are different from requests for Node dependencies.

# To support the different API specifications, Artifact Registry needs to know what format you want the API responses to follow. To do this you will create a repository and pass in the --repository-format flag indicating the type of repository desired.

# From Cloud Shell run the following command to create a repository for Docker images:

# gcloud artifacts repositories create container-dev-repo --repository-format=docker \
#   --location=$REGION \
#   --description="Docker repository for Container Dev Workshop"
# Copied!
# Click Authorize if the Cloud Shell authorization prompt appears.

# In the Cloud console, go to Artifact Registry > Repositories and notice your newly created Docker repository named container-dev-repo. If you click on it you can see that it's empty at the moment.
# Click Check my progress to verify the objective. (It may take a minute to validate. If you have completed successfully and it is not validating, wait a minute and try again.)

# Working with container images
# Configure Docker Authentication to Artifact Registry
# When connecting to Artifact Registry credentials are required in order to provide access. Rather than set up separate credentials, Docker can be configured to use your gcloud credentials seamlessly.

# From Cloud Shell run the following command to configure Docker to use the Google Cloud CLI to authenticate requests to Artifact Registry in the <filled in at lab start> region:
# gcloud auth configure-docker "Filled in at lab start"-docker.pkg.dev
# Copied!
# The command will prompt for a confirmation to change the Cloud Shell docker configuration, click ENTER.

# Explore the sample Application
# A sample application is provided in the git repository you cloned.

# Change into the java directory and review the application code:

# cd ~/cloud-code-samples/java/java-hello-world
# Copied!
# The folder contains an example Java application that renders a simple web page: in addition to various files not relevant for this specific lab, it contains the source code, under the src folder, and a Dockerfile you will use to build a container image locally.

# Build the Container Image
# Before you can store container images in Artifact Registry you need to create one.

# Run the following command to build the container image and tag it properly:
# docker build -t "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo/java-hello-world:tag1 .
# Copied!
# Push the Container Image to Artifact Registry
# Run the following command to push the container image to the repository you created:
# docker push "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo/java-hello-world:tag1
# Copied!
# Review the image in Artifact Registry
# In Artifact Registry > Repositories, click into container-dev-repo and check that the java-hello-world image is there.

# Click on the image and note the image tagged tag1. You can see that Vulnerability Scanning is running or already completed and the number of vulnerabilities detected is visible.

# Artifact Registry

# Click on the number of vulnerabilities and you will see the list of vulnerabilities detected in the image, with the CVE bulletin name and the severity. Click VIEW on each listed vulnerability to get more details:

# CVE Readout

# Task 3. Integration with Cloud Code
# In this section you use the Artifact Registry Docker image repository with Cloud Code.

# Deploy the Application to GKE Cluster from Cloud Code
# From the java-hello-world folder run the following command to open Cloud Shell Editor and add the application folder to this workspace:

# cloudshell workspace .
# Copied!
# The Cloud Shell editor will open with the explorer in the application folder.

# If you get a pop-up asking to exclude Java project settings files from the workspace, click on Exclude in workspace .

# The following steps will require you to enter your Artifact Registry repository location. The format for the location is:

# "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo
# Click on the Cloud Code status bar (in the lower left corner) and then select Run on Kubernetes:

# Cloud Code Status

# When prompted choose Yes to use the current context in kubeconfig that points to the container-dev-cluster GKE cluster provisioned for the lab.

# If Prompted for a Skaffold configuration, choose the java/java-hello-world project and choose to build via Dockerfile.

# If Prompted for a context, select Yes to use the current context.

# In the prompt for the image registry choose to specify a location manually and put the address location you located before.

# "REGION"-docker.pkg.dev/"PROJECT_ID"/container-dev-repo
# Copied!
# When you execute Run on Kubernetes for the first time Cloud Code prompts you for the target image repository location. Once provided, the repository url is stored in the file .vscode/launch.json which is created in the application folder.
# In the output pane you see that the build starts for the application image java-hello-world, the image is uploaded to the Artifact Registry repository configured previously.

# In Artifact Registry > Repositories click into container-dev-repo and check that the java-hello-world image and note a new image tagged latest.

# Review the Deployed Application
# Go back to Cloud Shell Editor. When deployment is complete Skaffold/Cloud Code will print the exposed url where the service have been forwarded, click on the link - Open Web Preview:
# URL Location

# In the new browser window you see the hello world app page.

# Hello World

# Update application code
# Now update the application to see the change implemented immediately in the deployment on the cluster:

# Open the HelloWorldController.java in src/main/java/cloudcode/helloworld/web folder in Cloud Shell Editor.

# Change the text in row 20 from "It's running!" to "It's updated!". You should see the build and deployment process starting immediately.

# At the end of the deploy click again on the forwarded url or refresh the browser window with the application to see your change deployed:

# Hello World Updated

# In the Cloud console go to Navigation Menu > Artifact Registry > Repositories and click into container-dev-repo to check that the java-hello-world image and note the new image.
# Click Check my progress to verify the objective.

# Integration with Cloud Code
# Task 4. Working with language packages
# In this section you will set up an Artifact Registry Java repository and upload packages to it, leveraging them in different applications.

# Create a Java package repository
# From Cloud Shell run the following command to create a repository for Java artifacts:
# gcloud artifacts repositories create container-dev-java-repo \
#     --repository-format=maven \
#     --location="REGION" \
#     --description="Java package repository for Container Dev Workshop"
# Copied!
# Click Authorize if the Cloud Shell authorization prompt appears

# In the Cloud console go to Artifact Registry > Repositories and notice your newly created Maven repository named container-dev-java-repo, if you click on it you can see that it's empty at the moment.

# Click Check my progress to verify the objective.

# Create a Java package repository
# Set up authentication to Artifact Repository
# Use the following command to update the well-known location for Application Default Credentials (ADC) with your user account credentials so that the Artifact Registry credential helper can authenticate using them when connecting with repositories:

# gcloud auth login --update-adc
# Copied!
# If prompted to authenticate:

# Choose Y.

# Paste the code into a browser window.

# Select Google Sign In and sign in using the credentials in the lab.

# Copy the authentication code from the browser back into the console to complete the authentication.

# Configure Maven for Artifact Registry
# Run the following command to print the repository configuration to add to your Java project:
# gcloud artifacts print-settings mvn \
#     --repository=container-dev-java-repo \
#     --location="REGION"
# Copied!
# Open the pom.xml in Cloud Shell Editor and add the returned settings to the appropriate sections in the file:

# Add the distributionManagement section.
#   <distributionManagement>
#     <snapshotRepository>
#       <id>artifact-registry</id>
#       <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#     </snapshotRepository>
#     <repository>
#       <id>artifact-registry</id>
#       <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#     </repository>
#   </distributionManagement>
# Copied!
# Add the repositories section.
#  <repositories>
#    <repository>
#      <id>artifact-registry</id>
#      <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#      <releases>
#        <enabled>true</enabled>
#      </releases>
#      <snapshots>
#        <enabled>true</enabled>
#      </snapshots>
#    </repository>
#  </repositories>
# Copied!
# Update the extensions in the Builds section.
# <extensions>
#      <extension>
#        <groupId>com.google.cloud.artifactregistry</groupId>
#        <artifactId>artifactregistry-maven-wagon</artifactId>
#        <version>2.1.0</version>
#      </extension>
#    </extensions>
# Copied!
# Here's an example of the complete file for your reference. Ensure that the <PROJECT> is replaced in the code.

# <?xml version="1.0" encoding="UTF-8"?>
# <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
#        xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
#  <modelVersion>4.0.0</modelVersion>
#  <artifactId>hello-world</artifactId>
#  <packaging>jar</packaging>
#  <name>Cloud Code Hello World</name>
#  <description>Getting started with Cloud Code</description>
#  <version>1.0.0</version>
# <distributionManagement>
#    <snapshotRepository>
#      <id>artifact-registry</id>
#      <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#    </snapshotRepository>
#    <repository>
#      <id>artifact-registry</id>
#      <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#    </repository>
#  </distributionManagement>
#  <repositories>
#    <repository>
#      <id>artifact-registry</id>
#      <url>artifactregistry://"REGION"-maven.pkg.dev/"PROJECT_ID"/container-dev-java-repo</url>
#      <releases>
#        <enabled>true</enabled>
#      </releases>
#      <snapshots>
#        <enabled>true</enabled>
#      </snapshots>
#    </repository>
#  </repositories>
#  <parent>
#    <groupId>org.springframework.boot</groupId>
#    <artifactId>spring-boot-starter-parent</artifactId>
#    <version>2.6.3</version>
#  </parent>
#  <properties>
#    <java.version>1.8</java.version>
#    <checkstyle.config.location>./checkstyle.xml</checkstyle.config.location>
#  </properties>
#  <build>
#    <plugins>
#      <plugin>
#        <groupId>com.google.cloud.tools</groupId>
#        <artifactId>jib-maven-plugin</artifactId>
#        <version>3.2.0</version>
#      </plugin>
#      <plugin>
#        <groupId>org.springframework.boot</groupId>
#        <artifactId>spring-boot-maven-plugin</artifactId>
#      </plugin>
#      <plugin>
#        <groupId>org.apache.maven.plugins</groupId>
#        <artifactId>maven-checkstyle-plugin</artifactId>
#        <version>3.1.2</version>
#      </plugin>
#    </plugins>
#    <extensions>
#      <extension>
#        <groupId>com.google.cloud.artifactregistry</groupId>
#        <artifactId>artifactregistry-maven-wagon</artifactId>
#        <version>2.1.0</version>
#      </extension>
#    </extensions>
#  </build>
#  <!-- The Spring Cloud GCP BOM will manage spring-cloud-gcp version numbers for you. -->
#  <dependencyManagement>
#    <dependencies>
#      <dependency>
#        <groupId>org.springframework.cloud</groupId>
#        <artifactId>spring-cloud-gcp-dependencies</artifactId>
#        <version>1.2.8.RELEASE</version>
#        <type>pom</type>
#        <scope>import</scope>
#      </dependency>
#    </dependencies>
#  </dependencyManagement>
#  <dependencies>
#    <dependency>
#      <groupId>org.springframework.boot</groupId>
#      <artifactId>spring-boot-starter</artifactId>
#    </dependency>
#    <dependency>
#      <groupId>org.springframework.boot</groupId>
#      <artifactId>spring-boot-starter-jetty</artifactId>
#    </dependency>
#    <dependency>
#      <groupId>org.springframework</groupId>
#      <artifactId>spring-webmvc</artifactId>
#    </dependency>
#    <dependency>
#      <groupId>org.springframework.boot</groupId>
#      <artifactId>spring-boot-starter-thymeleaf</artifactId>
#    </dependency>
#    <dependency>
#      <groupId>org.springframework.boot</groupId>
#      <artifactId>spring-boot-starter-test</artifactId>
#      <scope>test</scope>
#    </dependency>
#    <dependency>
#      <groupId>org.springframework.cloud</groupId>
#      <artifactId>spring-cloud-gcp-starter-logging</artifactId>
#    </dependency>
#  </dependencies>
# </project>
# Copied!
# Upload your Java package to Artifact Registry
# With Artifact Registry configured in Maven, you can now use Artifact Registry to store Java Jars for use by other projects in your organization.

# Run the following command to upload your Java package to Artifact Registry:

# mvn deploy
# Copied!
# Check the Java package in Artifact Registry
# In the Cloud console go to Artifact Registry > Repositories and click into container-dev-java-repo to check that the hello-world binary artifact is there:

# Artifact Registry

# Congratulations!
# You now have a solid understanding of features available in Artifact Registry.

# What you've covered
# Created Repositories for Containers and Language Packages

# Managed container images with Artifact Registry

# Integrated Artifact Registry with Cloud Code

# Configured Maven to use Artifact Registry for Java Dependencies

# Finish your quest
# This self-paced lab is part of the CI/CD on Google Cloud skill badge quest. A quest is a series of related labs that form a learning path. Completing this quest will earn you a badge to recognize your achievement. You can make your badges public and link to them in your online résumé or social media account. Enroll in this quest to get immediate credit for completing this lab.
# See other available quests.

# This skill badge quest is part of Google Cloud’s Cloud Developer learning path. Continue your learning journey here Cloud Developer Learning Path!

# Take your next lab
# Continue your quest with one of these labs:

# Google Kubernetes Engine Pipeline using Cloud Build

# Cloud Run Canary Deployments

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated July 4, 2023

# Lab Last Tested July 4, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.