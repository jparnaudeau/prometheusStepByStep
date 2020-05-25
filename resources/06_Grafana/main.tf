#######################################
# define provider
#######################################
provider "aws" {
  region = "eu-west-3"
}

#######################################
# Configure the Backend
#######################################
terraform {
  backend "s3" {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "service-grafana.tfstate"
    region = "eu-west-3"
  }
}

#######################################
# Define the current caller
#######################################
data "aws_caller_identity" "current" {
}

#######################################
# Define the ELB service account
#######################################
data "aws_elb_service_account" "main" {
}
