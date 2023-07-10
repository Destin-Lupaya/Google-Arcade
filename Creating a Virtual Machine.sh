# SP001
# Google Cloud self-paced labs logo

# Overview
# Compute Engine allows you to create virtual machines (VMs) that run different operating systems, including multiple flavors of Linux (Debian, Ubuntu, Suse, Red Hat, CoreOS) and Windows Server, on Google infrastructure. You can run thousands of virtual CPUs on a system that is designed to be fast and to offer strong consistency of performance.

# In this hands-on lab, you create VM instances of various machine types using the Google Cloud console and the gcloud command line in Cloud Shell. You also learn how to connect an NGINX web server to your VM.

# Although you can easily copy and paste commands from the lab to the appropriate place, it is recommended that you type the commands yourself to reinforce your understanding of the core concepts.

# What you'll do
# Create a VM with the Cloud console.

# Create a VM with the gcloud command line.

# Deploy a web server and connect it to a VM.

# Prerequisites
# Familiarity with standard Linux text editors such as vim, emacs, or nano.

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

 gcloud auth list

# Click Authorize.

# Your output should now look like this:

# Output:

# ACTIVE: *
# ACCOUNT: student-01-xxxxxxxxxxxx@qwiklabs.net
# To set the active account, run:
#     $ gcloud config set account `ACCOUNT`
# (Optional) You can list the project ID with this command:

 gcloud config list project

# Output:

# [core]
# project = <project_ID>
# Example output:

# [core]
# project = qwiklabs-gcp-44776a13dea667a6
# Note: For full documentation of gcloud, in Google Cloud, refer to the gcloud CLI overview guide.
# Understanding Regions and Zones
# Certain Compute Engine resources live in regions or zones. A region is a specific geographical location where you can run your resources. Each region has one or more zones. For example, the us-central1 region denotes a region in the Central United States that has zones us-central1-a, us-central1-b, us-central1-c, and us-central1-f.

# Regions	Zones
# Western US	us-west1-a, us-west1-b
# Central US	us-central1-a, us-central1-b, us-central1-d, us-central1-f
# Eastern US	us-east1-b, us-east1-c, us-east1-d
# Western Europe	europe-west1-b, europe-west1-c, europe-west1-d
# Eastern Asia	asia-east1-a, asia-east1-b, asia-east1-c
# Resources that live in a zone are referred to as zonal resources. Virtual machine Instances and persistent disks live in a zone. To attach a persistent disk to a virtual machine instance, both resources must be in the same zone. Similarly, if you want to assign a static IP address to an instance, the instance must be in the same region as the static IP.

# Learn more about regions and zones and see a complete list in the Compute Engine page, Regions and zones documentation).
# Set the region and zone
# Set the project region for this lab:
 gcloud config set compute/region "region=$REGION"

# Create a variable for region:
export REGION=region=$REGION

# Create a variable for zone:
 export ZONE=Zone

# Learn more from the Regions & Zones documentation.

# Note: When you run gcloud on your own machine, the config settings are persisted across sessions. But in Cloud Shell, you need to set this for every new session or reconnection.
# Task 1. Create a new instance from the Cloud console
# In this section, you create new predefined machine types with Compute Engine from the Cloud console.

# In the Cloud console, on the Navigation menu (Navigation menu icon), click Compute Engine > VM Instances.

# This may take a minute to initialize for the first time.

# To create a new instance, click CREATE INSTANCE.

# There are many parameters you can configure when creating a new instance. Use the following for this lab:

# Field	Value	Additional Information
# Name	gcelab	Name for the VM instance
# Region	____	For more information about regions, see the Compute Engine guide, Regions and Zones.
# Zone	____	Note: Remember the zone that you selected to use later. For more information about zones, see the Compute Engine guide, Regions and Zones.
# Series	E2	Name of the series
# Machine Type	2 vCPU	This is an (e2-medium), 2-CPU, 4GB RAM instance. Several machine types are available, ranging from micro instance types to 32-core/208GB RAM instance types. For more information, see the Compute Engine guide, About machine families. Note: A new project has a default resource quota, which may limit the number of CPU cores. You can request more when you work on projects outside this lab.
# Boot Disk	New 10 GB balanced persistent disk OS Image: Debian GNU/Linux 11 (bullseye)	Several images are available, including Debian, Ubuntu, CoreOS, and premium images such as Red Hat Enterprise Linux and Windows Server. For more information, see Operating System documentation.
# Firewall	Allow HTTP traffic	Select this option in order to access a web server that you install later. Note: This automatically creates a firewall rule to allow HTTP traffic on port 80.
# Click Create.

# Equivalent CODE

gcloud compute instances create gcelab --project=qwiklabs-gcp-00-8ad9ce9e6e94 --zone=us-east4-a --machine-type=e2-medium --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default --metadata=enable-oslogin=true --maintenance-policy=MIGRATE --provisioning-model=STANDARD --service-account=338910399066-compute@developer.gserviceaccount.com --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append --tags=http-server --create-disk=auto-delete=yes,boot=yes,device-name=gcelab,image=projects/debian-cloud/global/images/debian-11-bullseye-v20230629,mode=rw,size=10,type=projects/qwiklabs-gcp-00-8ad9ce9e6e94/zones/us-east4-a/diskTypes/pd-balanced --no-shielded-secure-boot --shielded-vtpm --shielded-integrity-monitoring --labels=goog-ec-src=vm_add-gcloud --reservation-affinity=any

# Equivalent REST

POST https://www.googleapis.com/compute/v1/projects/qwiklabs-gcp-00-8ad9ce9e6e94/zones/us-east4-a/instances
{
  "canIpForward": false,
  "confidentialInstanceConfig": {
    "enableConfidentialCompute": false
  },
  "deletionProtection": false,
  "description": "",
  "disks": [
    {
      "autoDelete": true,
      "boot": true,
      "deviceName": "gcelab",
      "diskEncryptionKey": {},
      "initializeParams": {
        "diskSizeGb": "10",
        "diskType": "projects/qwiklabs-gcp-00-8ad9ce9e6e94/zones/us-east4-a/diskTypes/pd-balanced",
        "labels": {},
        "sourceImage": "projects/debian-cloud/global/images/debian-11-bullseye-v20230629"
      },
      "mode": "READ_WRITE",
      "type": "PERSISTENT"
    }
  ],
  "displayDevice": {
    "enableDisplay": false
  },
  "guestAccelerators": [],
  "instanceEncryptionKey": {},
  "keyRevocationActionType": "NONE",
  "labels": {
    "goog-ec-src": "vm_add-rest"
  },
  "machineType": "projects/qwiklabs-gcp-00-8ad9ce9e6e94/zones/us-east4-a/machineTypes/e2-medium",
  "metadata": {
    "items": [
      {
        "key": "enable-oslogin",
        "value": "true"
      }
    ]
  },
  "name": "gcelab",
  "networkInterfaces": [
    {
      "accessConfigs": [
        {
          "name": "External NAT",
          "networkTier": "PREMIUM"
        }
      ],
      "stackType": "IPV4_ONLY",
      "subnetwork": "projects/qwiklabs-gcp-00-8ad9ce9e6e94/regions/us-east4/subnetworks/default"
    }
  ],
  "params": {
    "resourceManagerTags": {}
  },
  "reservationAffinity": {
    "consumeReservationType": "ANY_RESERVATION"
  },
  "scheduling": {
    "automaticRestart": true,
    "onHostMaintenance": "MIGRATE",
    "provisioningModel": "STANDARD"
  },
  "serviceAccounts": [
    {
      "email": "338910399066-compute@developer.gserviceaccount.com",
      "scopes": [
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring.write",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/trace.append"
      ]
    }
  ],
  "shieldedInstanceConfig": {
    "enableIntegrityMonitoring": true,
    "enableSecureBoot": false,
    "enableVtpm": true
  },
  "tags": {
    "items": [
      "http-server"
    ]
  },
  "zone": "projects/qwiklabs-gcp-00-8ad9ce9e6e94/zones/us-east4-a"
}


# Equivalent TERRAFORM
# # This code is compatible with Terraform 4.25.0 and versions that are backwards compatible to 4.25.0.
# # For information about validating this Terraform code, see https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build#format-and-validate-the-configuration

resource "google_compute_instance" "gcelab" {
  boot_disk {
    auto_delete = true
    device_name = "gcelab"

    initialize_params {
      image = "projects/debian-cloud/global/images/debian-11-bullseye-v20230629"
      size  = 10
      type  = "pd-balanced"
    }

    mode = "READ_WRITE"
  }

  can_ip_forward      = false
  deletion_protection = false
  enable_display      = false

  labels = {
    goog-ec-src = "vm_add-tf"
  }

  machine_type = "e2-medium"

  metadata = {
    enable-oslogin = "true"
  }

  name = "gcelab"

  network_interface {
    access_config {
      network_tier = "PREMIUM"
    }

    subnetwork = "projects/qwiklabs-gcp-00-8ad9ce9e6e94/regions/us-east4/subnetworks/default"
  }

  scheduling {
    automatic_restart   = true
    on_host_maintenance = "MIGRATE"
    preemptible         = false
    provisioning_model  = "STANDARD"
  }

  service_account {
    email  = "338910399066-compute@developer.gserviceaccount.com"
    scopes = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
  }

  shielded_instance_config {
    enable_integrity_monitoring = true
    enable_secure_boot          = false
    enable_vtpm                 = true
  }

  tags = ["http-server"]
  zone = "us-east4-a"
}


# It should take about a minute for the VM, gcelab, to be created. After gcelab is created, the VM Instances page lists it in the VM instances list.

# To use SSH to connect to the VM, click SSH to the right of the instance name, gcelab.

# This launches an SSH client directly from your browser.

# Note: Learn more about how to use SSH to connect to an instance from the Compute Engine guide, Connect to Linux VMs using Google tools.
# Task 2. Install an NGINX web server
# Now you install an NGINX web server, one of the most popular web servers in the world, to connect your VM to something.

# Update the OS:

# sudo apt-get update
# Copied!
# Expected output:

#  Get:1 http://security.debian.org stretch/updates InRelease [94.3 kB]
#  Ign http://deb.debian.org strech InRelease
#  Get:2 http://deb.debian.org strech-updates InRelease [91.0 kB]
#  ...
# Install NGINX:

# sudo apt-get install -y nginx
# Copied!
# Expected output:

#  Reading package lists... Done
#  Building dependency tree
#  Reading state information... Done
#  The following additional packages will be installed:
#  ...
# Confirm that NGINX is running:

# ps auwx | grep nginx
# Copied!
# Expected output:

#  root      2330  0.0  0.0 159532  1628 ?        Ss   14:06   0:00 nginx: master process /usr/sbin/nginx -g daemon on; master_process on;
#  www-data  2331  0.0  0.0 159864  3204 ?        S    14:06   0:00 nginx: worker process
#  www-data  2332  0.0  0.0 159864  3204 ?        S    14:06   0:00 nginx: worker process
#  root      2342  0.0  0.0  12780   988 pts/0    S+   14:07   0:00 grep nginx
# To see the web page, return to the Cloud console and click the External IP link in the row for your machine, or add the External IP value to http://EXTERNAL_IP/ in a new browser window or tab.

# This default web page should open:

# Default nginx page; Welcome to nginx!

# To check your progress in this lab, click Check my progress below. A checkmark means you're successful.

# Create a Compute Engine instance and add an NGINX Server to your instance with necessary firewall rules.
# Task 3. Create a new instance with gcloud
# Instead of using the Cloud console to create a VM instance, use the command line tool gcloud, which is pre-installed in Google Cloud Shell. Cloud Shell is an interactive shell environment for Google Cloud loaded with all the development tools you need (gcloud, git, and others) and offers a persistent 5-GB home directory.

# Note: If you want to try this on your own machine, read the gcloud command line tool guide.
# In the Cloud Shell, use gcloud to create a new VM instance from the command line:

# gcloud compute instances create gcelab2 --machine-type e2-medium --zone=$ZONE
# Copied!
# Expected output:

#      Created [...gcelab2].
#      NAME: gcelab2
#      ZONE: {{{project_0.startup_script.project_zone=$ZONE}}} 
#      MACHINE_TYPE: e2-medium
#      PREEMPTIBLE:
#      INTERNAL_IP: 10.128.0.3
#      EXTERNAL_IP: 34.136.51.150
#      STATUS: RUNNING
# To check your progress in this lab, click Check my progress below. A checkmark means you're successful.

# Create a new instance with gcloud.
# The new instance has these default values:

# The latest Debian 11 (bullseye) image.
# The e2-medium machine type.
# A root persistent disk with the same name as the instance; the disk is automatically attached to the instance.
# When working in your own project, you can specify a custom machine type.

# To see all the defaults, run:

# gcloud compute instances create --help
# Copied!
# Note: You can set the default region and zones that gcloud uses if you are always working within one region/zone and you don't want to append the --zone flag every time.
# To do this, run these commands:

# gcloud config set compute/zone ...

# gcloud config set compute/region ...

# To exit help, press CTRL + C.

# In the Cloud console, on the Navigation menu, click Compute Engine > VM instances.
# Your two new instances should be listed.

# You can also use SSH to connect to your instance via gcloud. Make sure to add your zone, or omit the --zone flag if you've set the option globally:

# gcloud compute ssh gcelab2 --zone=$ZONE
# Copied!
# Type Y to continue.

#    Do you want to continue? (Y/n)
# Press ENTER through the passphrase section to leave the passphrase empty.

#    Generating public/private rsa key pair.
#    Enter passphrase (empty for no passphrase)
# After connecting, disconnect from SSH by exiting from the remote shell:

#  exit
# Copied!
# Task 4. Test your knowledge
# Test your knowledge about Google Cloud by taking the quiz. (Please select multiple correct options if necessary.)

# Through which of the following ways can you create a VM instance in Compute Engine?

# The gcloud command line tool

# The Cloud console

# Congratulations!
# Compute Engine is the foundation of Google Cloud's infrastructure as a service. You created a VM with Compute Engine and can now map your existing server infrastructure, load balancers, and network topology to Google Cloud.

# Finish your quest
# This self-paced lab is part of the Google Cloud Essentials quest. A quest is a series of related labs that form a learning path. Enroll in this quest and get immediate completion credit for taking this lab. See other available quests.

# Take your next lab
# Continue your quest with Getting Started with Cloud Shell and gcloud, or check out the following lab:

# Provision Services with Google Cloud Marketplace

# Next steps / Learn more
# For an overview of VMs, see Virtual Machine Instances.
# Check out how to migrate VMs to the Google Cloud.
# Learn more about subnetworks and network topology.
# And then be sure to choose the right VM type by reviewing Choosing a VM Machine.
# Google Cloud training and certification
# ...helps you make the most of Google Cloud technologies. Our classes include technical skills and best practices to help you get up to speed quickly and continue your learning journey. We offer fundamental to advanced level training, with on-demand, live, and virtual options to suit your busy schedule. Certifications help you validate and prove your skill and expertise in Google Cloud technologies.

# Manual Last Updated: June 26, 2023

# Lab Last Tested: June 26, 2023

# Copyright 2023 Google LLC All rights reserved. Google and the Google logo are trademarks of Google LLC. All other company and product names may be trademarks of the respective companies with which they are associated.

# Continue questing