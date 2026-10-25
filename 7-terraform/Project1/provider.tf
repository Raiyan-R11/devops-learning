terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.68.0"
    }
  }
  backend "s3" {
    bucket = "terraform-state-905765460615"
    key    = "project1/terraform.tfstate"
    region = "eu-north-1"
  }
}
provider "aws" {
  region = "eu-north-1"
}
