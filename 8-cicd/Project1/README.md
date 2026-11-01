# Project 1: Check Terraform with GitHub Actions

## Read first

- [GitHub Actions: Triggering a workflow](https://docs.github.com/en/actions/how-tos/write-workflows/choose-when-workflows-run/trigger-a-workflow): Read the sections on push events and path filters.
- [Terraform: `fmt`](https://developer.hashicorp.com/terraform/cli/commands/fmt): Read how to check formatting without rewriting files.
- [Terraform: `validate`](https://developer.hashicorp.com/terraform/cli/commands/validate): Read this if you also want to catch configuration errors. Formatting and validation check different things.

## Challenge

Create a small Terraform example, such as an S3 bucket or EC2 instance. Add a GitHub Actions workflow that checks the Terraform code automatically when you push a change to it. Use `terraform fmt` or another linting tool for the check.

Introduce a formatting issue deliberately so you can see the workflow report a failure. Then correct it and confirm that a later run passes. The check should run in GitHub Actions, not only on your computer.

## Done when

- The repository contains a Terraform example and a workflow for its checks.
- A push that changes the Terraform code triggers the workflow.
- You have observed a failed run for the deliberate issue and a passing run after fixing it.
- You can explain what your chosen check catches and what it does not catch.

You do not need to create cloud resources for this challenge.
