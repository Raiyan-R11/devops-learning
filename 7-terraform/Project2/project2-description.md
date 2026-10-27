# Terraform Project 2: EC2 Deployment with Cloud-Init

## Objective

Configure a cloud-init file and use Terraform to automate an EC2 deployment.

Tasks:

- Write a cloud-init YAML file
- Install and configure software on boot (e.g. NGINX or Apache)
- Pass cloud-init to the EC2 instance through Terraform
- Ensure the instance comes online fully configured with no manual steps

## What to demonstrate

- How Terraform uses `user_data` or `user_data_base64`
- How cloud-init automates instance configuration
- How to structure Terraform for clarity (variables, outputs, modules if needed)

Document the cloud-init and Terraform workflow clearly in the repo.
