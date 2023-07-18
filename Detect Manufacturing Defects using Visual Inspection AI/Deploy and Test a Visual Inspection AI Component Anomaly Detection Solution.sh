# Deploy and Test a Visual Inspection AI Component Anomaly Detection Solution
# 1 hour 30 minutes
# 1 Credit
# GSP896
# Google Cloud self-paced labs logo

# Overview
# Visual Inspection AI Assembly Inspection inspects products when components come together during some stage of assembling a product. For such inspections, Visual Inspection AI can help you to ensure that components are in the correct location within the overall object, and that each component is not damaged or defective.

# PCBs (printed circuit boards) in general are assemblies of components, including through-hole and surface-mounted. Components can be discrete parts placed within the assembly or physical features created within the assembly such as solder joints, glue, or welds. For subassemblies of electronic products, components can be screws, other hardware parts, or whole other subassemblies.

# In this lab you will deploy and serve the exported Assembly Inspection solution using sample images.

# Model training can take a long time so this lab is paired with Create a Component Anomaly Detection Model using Visual Inspection AI. You are provided with a trained Assembly Inspection model and solution artifact that was created using the same dataset that is used in that lab.

# What you'll learn
# In this lab you will learn how to complete the following tasks:

# Deploy a trained Assembly Inspection solution artifact.

# Perform a batch prediction using an Assembly Inspection solution artifact.

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
# Task 1. Deploy the exported Assembly Inspection solution artifact
# A Visual Inspection AI Assembly Inspection solution artifact container has been created and stored in the Container Registry (gcr.io) for use in this lab. You can deploy these exported solution containers in your own environment, whether that is a Google Cloud VM, an on-premise compute unit, or any other suitable environment that can run Docker containers.

# Run and test a CPU based solution artifact locally
# In this task you will run a CPU based solution artifact as a docker container locally in the Google Cloud VM. The process shown here uses docker commands to pull, or start the Docker compatible solution artifact container.

# The exported solution artifact container uses port 8601 for grpc traffic, port 8602 for http traffic, and port 8603 for Prometheus metric traffic. You can map these ports to locally available ports in the VM environment when starting the container with Docker using the command line switches -v 9000:8602 or -v 3006:8603. You need to map a local port to port 8602 for sending http requests, and another local port to port 8603 if you want to see the metrics logs locally.

# Your first step is to connect to the Google Cloud VM. In Cloud Shell, enter the following command to connect to the VM:

# gcloud compute ssh vm_name --zone vm_zone
# Copied!
# For any prompts, click Enter key to continue.

# Define an environment variable to store the name of the Visual Inspection solution artifact Docker image that is stored in Container Registry.

# In the VM terminal, define a variable named DOCKER_TAG using the full image name of the docker container:

# export DOCKER_TAG=gcr.io/ql-shared-resources-test/resistance_solution@sha256:d9095cbd6f7ca69b1a30c58c4272b68062d2004ed259ff0dcb9af0ceb92b393b
# Copied!
# This is the Container Registry image ID of a Visual Inspection Assembly Inspection solution artifact that was created using the resistance component demo dataset. This solution artifact will identify resistance components in images.

# Define variables for ports used by the solution artifact container:
# export VISERVING_CPU_DOCKER_WITH_MODEL=${DOCKER_TAG}
# export HTTP_PORT=8602
# export LOCAL_METRIC_PORT=8603
# Copied!
# Pull the docker image from the Google Source Repository using the following command:
# docker pull ${VISERVING_CPU_DOCKER_WITH_MODEL}
# Copied!
# Start the solution artifact locally using Docker in the VM:
# docker run -v /secrets:/secrets --rm -d --name "test_cpu" \
# --network="host" \
# -p ${HTTP_PORT}:8602 \
# -p ${LOCAL_METRIC_PORT}:8603 \
# -t ${VISERVING_CPU_DOCKER_WITH_MODEL} \
# --metric_project_id="${PROJECT_ID}" \
# --use_default_credentials=false \
# --service_account_credentials_json=/secrets/assembly-usage-reporter.json
# Copied!
# The reported usage metrics uploaded from the container include:

# num_request_processed: the total number of processed requests.

# prediction_latency: the prediction latency in one request.

# average_prediction_latency: the average prediction latency.

# Confirm that the container is running:
# docker container ls
# Copied!
# You should see a container listed that has the image name for your solution artifact.

# Once you have started the solution artifact container with the above Docker run command, you can send requests to the running container using the python script below.

# Copy the file prediction_script.py to run predictions by calling the Visual Inspection AI rest APIs via the solution artifact container:
# gsutil cp gs://cloud-training/gsp895/prediction_script.py .
# Copied!
# The code in this file is displayed below for your reference:

# from __future__ import absolute_import
# from __future__ import division
# from __future__ import print_function
# import base64
# import json
# import time
# import re
# from absl import app
# from absl import flags
# import numpy as np
# import requests
# flags.DEFINE_string('hostname', 'http://localhost', 'The hostname for serving.')
# flags.DEFINE_string('input_image_file', None, 'The input image file name.')
# flags.DEFINE_string('output_result_file', None, 'The prediction output file name.')
# flags.DEFINE_integer('port', None, 'The port of rest api.')
# flags.DEFINE_integer('num_of_requests', 1, 'The number of requests to send.')
# FLAGS = flags.FLAGS
# def create_request_body(input_image_file):
#     """Creates the request body to perform api calls.
#     Args:
#     input_image_file: String, the input image file name.
#     Returns:
#     A json format string of the request body. The format is like below:
#         {"image_bytes":}
#     """
#     with open(input_image_file, 'rb') as image_file:
#         encoded_string = base64.b64encode(image_file.read()).decode('utf-8')
#     request_body = {'image_bytes': str(encoded_string)}
#     return json.dumps(request_body)
# def predict(hostname, input_image_file, port):
#     """Predict results on the input image using services at the given port.
#     Args:
#     hostname: String, the host name for the serving.
#     input_image_file: String, the input image file name.
#     port: Integer, the port that runs the rest api service.
#     Returns:
#     The predicted results in json format. 
#     """
#     url = hostname + ':' + str(port) + '/v1beta1/visualInspection:predict'
#     request_body = create_request_body(input_image_file)
#     response = requests.post(url, data=request_body)
#     return response.json()
# def compute_latency_percentile(hostname, input_image_file, port,
#                              num_of_requests):
#     """Computes latency percentiles of server's prediction endpoint.
#     Args:
#     hostname: String, the host name for the serving.
#     input_image_file: String, the input image file name.
#     port: Integer, the port that runs the rest api service.
#     num_of_requests: The number of requests to send.
#     Returns:
#     The dictionary of latency percentiles of 75%, 90%, 95%, 99%.
#     """
#     latency_list = []
#     for _ in range(num_of_requests):
#         response = predict(hostname, input_image_file, port)
#         latency_in_ms = float(response['predictionLatency'][:-1])
#         latency_list.append(latency_in_ms)
#     latency_percentile = {}
#     percentiles = [75, 90, 95, 99]
#     for percentile in percentiles:
#         latency_percentile[percentile] = np.percentile(latency_list, percentile)
#     return latency_percentile
# def main(_):
#     if FLAGS.num_of_requests > 1:
#         latency_percentile = compute_latency_percentile(FLAGS.hostname,
#                                                         FLAGS.input_image_file,
#                                                         FLAGS.port,
#                                                         FLAGS.num_of_requests)
#         print(latency_percentile)
#         with open(FLAGS.output_result_file, 'w+') as latency_result:
#             latency_result.write(json.dumps(latency_percentile))
#     else:
#         start = time.time()
#         results = predict(FLAGS.hostname, FLAGS.input_image_file, FLAGS.port)
#         end = time.time()
#         print('Processed image {} in {}s.'.format(FLAGS.input_image_file, end - start))
#         print(json.dumps(results, indent=2))
#         with open(FLAGS.output_result_file, 'w+') as prediction_result:
#             prediction_result.write(json.dumps(results, indent=2))
# if __name__ == '__main__':
#     flags.mark_flag_as_required('input_image_file')
#     flags.mark_flag_as_required('port')
#     flags.mark_flag_as_required('output_result_file')
#     app.run(main)
# Deploy the exported Assembly Inspection solution artifact
# Task 2. Serve the exported Assembly Inspection solution artifact
# In this task you use the solution artifact to analyze sample images and review the output data that the model detects.

# Identifying a defective component
# In the VM terminal, run the commands below to copy training images to your Cloud Storage bucket, followed by copying a defective sample image to the VM:
#  export PROJECT_ID=$(gcloud config get-value core/project)
#  gsutil mb gs://${PROJECT_ID}
#  gsutil -m cp gs://cloud-training/gsp895/pcb_images/*.png \
#  gs://${PROJECT_ID}/demo_pcb_images/
#  gsutil cp gs://${PROJECT_ID}/demo_pcb_images/image_275_cx98_cy16_r-5.png .
# Copied!
# Find a defective component from the cloud storage bucket. In cloud console, go to Navigation menu (Navigation menu icon) > Cloud Storage > Bucket.

# In the Cloud Storage Browser, navigate to the bucket named Bucket Name > demo_pcb_images.

# Now find and click on the image named image_275_cx98_cy16_r-5.png from the list of the images. You might have to scroll through the list to find this image.

# Defective component example

# This is a defective component that has a blue rectangle masking the resistor.

# In the terminal, run the following command to send the selected image as a request to the solution artifact container:
#  python3 ./prediction_script.py --input_image_file=./image_275_cx98_cy16_r-5.png  --port=8602 --output_result_file=def_prediction_result.json
# Copied!
# This will print out the JSON result data returned by your Visual Inspection AI model. You can inspect the annotation sets and annotations to see the analysis data that is returned. This sample image is one of the images with a defective resistor that has been artificially masked using a blue rectangle on the image.

# If you look at the annotation results you can see that Visual Inspection AI has assigned a relatively high confidence score (model defect score) of 0.652963758 for one of the components, parentAnnotationId": "localAnnotations/1000000" indicating that it is probably defective.

# The script also stores the prediction result in a file named def_prediction_result.json that is created and saved in the HOME directory of the VM. This file is passed to the script using the flag --output_result_file.

# ...
#         "annotations": [
#           {
#             "name": "localAnnotations/1000000",
#             "annotationSpecId": "9163696043257233408",
#             "annotationSetId": "1247523485060694016",
#             "polygon": {
#               "normalizedBoundingPoly": {
#                 "normalizedVertices": [
#                   {
#                     "x": 0.576829731,
#                     "y": 0.649797797
#                   },
#                   {
#                     "x": 0.671341896,
#                     "y": 0.643206656
#                   },
#                   {
#                     "x": 0.674117,
#                     "y": 0.68300128
#                   },
#                   {
#                     "x": 0.579604864,
#                     "y": 0.689592421
#                   }
#                 ]
#               }
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5557758599523991552/models/7472668050458673152"
#             }
#           },
# ...
#         "annotations": [
#           {
#             "name": "localAnnotations/0",
#             "annotationSpecId": "738868515330588672",
#             "annotationSetId": "2346964744092516352",
#             "parentAnnotationId": "localAnnotations/1000000",
#             "classificationLabel": {
#               "confidenceScore": 0.652963758
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5406888012007079936/models/1192398370090516480"
#             }
#           },
# ...
# Run the following command to send multiple requests to the running container:
# python3 ./prediction_script.py --input_image_file=./image_275_cx98_cy16_r-5.png  --port=8602 --num_of_requests=10 --output_result_file=def_latency_result.json
# Copied!
# The script calls the solution artifact 10 times and reports the distribution of the response latencies that are returned in the response each time the solution artifact processes an image. The script also stores the latency result in a file named def_latency_result.json that is created and saved in the HOME directory of the VM. This file is passed to the script using the flag --output_result_file.

# Identify a defective component
# Identifying a non-defective component
# In this subtask you use the solution artifact to analyze an image that does not contain a defective component to see how the model response differs from the output for an image containing a defective component.

# In the VM terminal, run the commands below to copy a sample image with no defective components to the VM:
# export PROJECT_ID=$(gcloud config get-value core/project)
# gsutil cp gs://${PROJECT_ID}/demo_pcb_images/image_439_cx31_cy-35_r-4.png .
# Copied!
# Find a non-defective component from the cloud storage bucket. If you are not in Cloud Storage browser, in cloud console, go to Navigation menu (Navigation menu icon) > Cloud Storage > Bucket. In the Cloud Storage Browser, navigate to the bucket named Bucket Name > demo_pcb_images.

# Now find and click on the image named image_439_cx31_cy-35_r-4.png from the list of the images. You might have to scroll through the list to find this image.

# Non-defective component example

# This is a non-defective component that does not have any defects.

# In the terminal, run the following command to send the selected image as a request to the solution artifact container:
# python3 ./prediction_script.py --input_image_file=./image_439_cx31_cy-35_r-4.png  --port=8602 --output_result_file=non_def_prediction_result.json
# Copied!
# This will print out the JSON result data returned by your Visual Inspection AI model. You can inspect the annotation sets and annotations to see that this returns the same general data structures that were returned in the previous request. However this sample image is one of the non-defective images.

# If you look at the annotation results you can see that Visual Inspection AI has assigned a relatively low confidence score (model defect score) of 0.0180127025 for one of the components, parentAnnotationId": "localAnnotations/1000000", indicating that it is probably non-defective.

# The script also stores the prediction result in a file named non_def_prediction_result.json that is created and saved in the HOME directory of the VM. This file is passed to the script using the flag --output_result_file.

# ...
#         "annotations": [
#           {
#             "name": "localAnnotations/1000000",
#             "annotationSpecId": "9163696043257233408",
#             "annotationSetId": "1247523485060694016",
#             "polygon": {
#               "normalizedBoundingPoly": {
#                 "normalizedVertices": [
#                   {
#                     "x": 0.506466269,
#                     "y": 0.5975281
#                   },
#                   {
#                     "x": 0.600979,
#                     "y": 0.592597
#                   },
#                   {
#                     "x": 0.603055239,
#                     "y": 0.63239187
#                   },
#                   {
#                     "x": 0.508542538,
#                     "y": 0.637322962
#                   }
#                 ]
#               }
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5557758599523991552/models/7472668050458673152"
#             }
#           },
#           {
#             "name": "localAnnotations/1000001",
#             "annotationSpecId": "9163696043257233408",
#             "annotationSetId": "1247523485060694016",
#             "polygon": {
#               "normalizedBoundingPoly": {
#                 "normalizedVertices": [
#                   {
#                     "x": 0.590454638,
#                     "y": 0.461126089
#                   },
#                   {
#                     "x": 0.623952,
#                     "y": 0.459378332
#                   },
#                   {
#                     "x": 0.629263878,
#                     "y": 0.56119138
#                   },
#                   {
#                     "x": 0.595766544,
#                     "y": 0.562939167
#                   }
#                 ]
#               }
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5557758599523991552/models/7472668050458673152"
#             }
#           }
#         ]
#       },
# ...
#         "annotations": [
#           {
#             "name": "localAnnotations/0",
#             "annotationSpecId": "738868515330588672",
#             "annotationSetId": "2346964744092516352",
#             "parentAnnotationId": "localAnnotations/1000000",
#             "classificationLabel": {
#               "confidenceScore": 0.0180127025
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5406888012007079936/models/1192398370090516480"
#             }
#           },
#           {
#             "name": "localAnnotations/1",
#             "annotationSpecId": "738868515330588672",
#             "annotationSetId": "2346964744092516352",
#             "parentAnnotationId": "localAnnotations/1000001",
#             "classificationLabel": {
#               "confidenceScore": 0.0180627704
#             },
#             "source": {
#               "type": "MACHINE_PRODUCED",
#               "sourceModel": "projects/624839602356/locations/us-central1/solutions/1179028308696760320/modules/5406888012007079936/models/1192398370090516480"
#             }
#           }
#         ]
# ...
# Run the following command to send multiple requests to the running container:
# python3 ./prediction_script.py --input_image_file=./image_275_cx98_cy16_r-5.png  --port=8602 --num_of_requests=10 --output_result_file=non_def_latency_result.json
# Copied!
# The script calls the solution artifact 10 times and again reports the distribution of the response latencies that are returned in the response each time the solution artifact processes an image. The script also stores the latency result in a file named non_def_latency_result.json that is created and saved in the HOME directory of the VM. This file is passed to the script using the flag --output_result_file.

# Identify a non-defective component
# Congratulations!
# You've successfully deployed and served a Visual Inspection AI Component Anomaly Detection Solution.

# Finish your quest
# This self-paced lab is part of the Detect Manufacturing Defects using Visual Inspection AI skill badge quest. A quest is a series of related labs that form a learning path. Completing this quest earns you a badge to recognize your achievement. Share your badge on your resume and social platforms, and announce your accomplishment using #GoogleCloudBadge. You can make your badge public and link to it in your online resume or social media account. Enroll in a quest and get immediate completion credit if you've taken this lab. Refer to the Google Cloud Skills Boost catalog for all available quests.

# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: January 03, 2023
# Lab Last Tested: January 03, 2023
# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.