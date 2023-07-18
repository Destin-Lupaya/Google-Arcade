# Introduction to Convolutions with TensorFlow
# 50 minutes
# 1 Credit
# GSP632
# Google Cloud self-paced labs logo

# Overview
# A convolution is a filter that passes over an image, processes it, and extracts features that show a commonality in the image. In this lab you explore convolution filters. You learn what they are and how they work by processing an image to extract features from it! You also explore pooling, which compresses your image and further emphasizes the features.

# What you'll do
# Load and draw an image from scipy, an open source Python library used for scientific and technical computing

# Create a filter as a 3x3 array and a convolution and see the effects on the image

# Run a pooling to see how it affects the output

# Prerequisite
# Although this is a self-standing lab, to maximize your learning consider taking these labs before taking this one:

# Machine Learning with TensorFlow: Qwik Start

# Introduction to Computer Vision with TensorFlow

# Setup
# Before you click the Start Lab button
# Read these instructions. Labs are timed and you cannot pause them. The timer, which starts when you click Start Lab, shows how long Google Cloud resources will be made available to you.

# This hands-on lab lets you do the lab activities yourself in a real cloud environment, not in a simulation or demo environment. It does so by giving you new, temporary credentials that you use to sign in and access Google Cloud for the duration of the lab.

# To complete this lab, you need:

# Access to a standard internet browser (Chrome browser recommended).
# Note: Use an Incognito or private browser window to run this lab. This prevents any conflicts between your personal account and the Student account, which may cause extra charges incurred to your personal account.
# Time to complete the lab---remember, once you start, you cannot pause a lab.
# Note: If you already have your own personal Google Cloud account or project, do not use it for this lab to avoid extra charges to your account.
# Open Vertex Notebook instance
# For this lab, a Vertex Notebook instance configured with JupyterLab and many machine learning frameworks has been pre-provisioned for you.

# Navigate to it and and open it:

# In the Cloud Console, navigate to Vertex AI > Workbench.

# Click OPEN JUPYTERLAB next to the name of your pre-provisioned Vertex Notebook instance. It may take a few minutes for the OPEN JUPYTERLAB option to appear.

# Clone the lab repository
# Next you'll clone the training-data-analyst notebook in your JupyterLab instance.

# To clone the training-data-analyst repository in your JupyterLab instance:

# In JupyterLab, click the Terminal icon to open a new terminal.
# Open Terminal

# At the command-line prompt, type the following command and press ENTER:

# git clone https://github.com/GoogleCloudPlatform/training-data-analyst
# Copied!
# To confirm that you have cloned the repository, in the left panel, double click the training-data-analyst folder to see its contents.
# Files in the training-data-analyst directory

# Navigate to lab notebook
# In your Vertex Notebook, navigate to the following directory:
# training-data-analyst/self-paced-labs/learning-tensorflow/introduction_to_convolutions/
# Open CLS_Vertex_AI_Intro_to_CNN.ipynb
# f639ae583bb66744.png
# Continue the lab in the notebook, and run each cell by clicking the Run ( run-button.png) icon at the top of the screen. Alternatively, you can execute the code in a cell with SHIFT + ENTER.
# Read the narrative and make sure you understand what's happening in each cell.

# Click Check my progress to verify the objective.
# Run the notebook

# Congratulations!
# This concluded the self-paced lab, Introduction to Convolutions with TensorFlow. You launched the convolutions notebook and explored convolutions and pooling.

# Next steps / learn more
# Learn more about TensorFlow at Getting started: training and prediction with TensorFlow Estimator.

# Check out Google Trends and then try it out.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated July 28, 2022
# Lab Last Tested July 28, 2022
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Ready for more?
# Here's another lab we think you'll like.