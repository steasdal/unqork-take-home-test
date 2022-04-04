# Unqork Take-Home Test

## Requirements
Per the email, requirements for the take-home test are as follows:
* Write an ansible playbook or role that creates an EKS/AKS/GKE cluster. You may use Ansible modules directly or you can choose to use Ansible to call Terraform or Cloudformation, but please do not use `eksctl`.
* Add plays to your role or playbook to create a Deployment in this cluster. You can use any docker container you choose. 
* Configure your deployment such that during an update, it always creates a new pod before terminating the old ones. In other words, the available pod count should not dip below the Replica count during an update.

## Solution
This solution will satisfy the above requirements via an Ansible playbook that performs the following actions:
* Create an **AWS EKS** cluster (and all of its required resources [e.g. VPC, Subnets, Node Group, etc]) by calling **Terraform**
* Write the cluster's **kubeconfig** file into the **/terraform** directory
* Use the **kubeconfig** file to create a namespace in the EKS cluster
* Use the **kubeconfig** file to create an [Nginx](https://hub.docker.com/_/nginx) deployment in the EKS cluster 

## Directories and Files
* **/ansible** - contains the Ansible playbooks for setting up *and* tearing down the EKS cluster and Nginx deployment
* **/terraform** - contains the Terraform configuration (multiple files)
* **/docker** - contains a Dockerfile that includes everything required to create a dockerized environment for successfully running the accompanying Ansible playbooks
* **setup-testenv.sh** - A short *bash* script that builds the **testenv** docker image and then runs it interactively
* **README.md** - This file

## Instructions
Follow these instructions to setup and subsequently tear down the EKS cluster and Nginx deployment:

### Setup:
* Copy the contents of an **.aws** directory containing credentials for programatically accessing an AWS cluster into the **/docker** directory
* Run the **setup-testenv.sh** script to build the **testenv** docker image and spin it up in interactive mode as a docker container named **testenv**
* From within the **testenv** docker environment, run the following command:

    `ansible-playbook ansible/setup.yaml`

### Teardown:
* From within the **testenv** docker environment (which is presumably still running following completion of the setup instructions), run the following command:

    `ansible-playbook ansible/teardown.yaml`
