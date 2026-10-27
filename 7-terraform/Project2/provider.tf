terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.68.0"
    }
    cloudinit = { # not necessary to delare as it is implicitly detected, but good practice to pin versions
      source  = "hashicorp/cloudinit"
      version = "2.4.1"
    }
  }
  backend "s3" {
    bucket = "terraform-state-905765460615"
    key    = "project2/terraform.tfstate"
    region = "eu-north-1"
  }
}
provider "aws" {
  region = "eu-north-1"
}
