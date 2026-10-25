# Terraform Project 1: Deploy WordPress Using Terraform

## Objective

Use Terraform to deploy a full WordPress stack on AWS.

The setup should include:

- EC2 instance running WordPress
- Security groups
- User data or cloud-init to install dependencies
- A working public endpoint
- All resources provisioned via Terraform

This project shows how Terraform manages real infrastructure end-to-end.

## Minimum requirements

- `main.tf` with the AWS provider, EC2 resource, and required settings
- `variables.tf` for inputs
- `outputs.tf` for instance details
- User data script embedded or referenced
- A successful WordPress installation

Take screenshots of the working WordPress site and include them in the repo.
