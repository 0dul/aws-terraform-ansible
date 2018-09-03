# Terraform file to deploy the lab

# Provider configuration

provider "aws" {
  "region"  = "${var.aws_region}"
  "profile" = "${var.aws_profile}"
}