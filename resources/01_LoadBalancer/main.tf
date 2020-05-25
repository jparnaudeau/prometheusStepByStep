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
    key    = "lb-tf-demo.tfstate"
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

#######################################
# retrieve the TFState for the Infra (Step 00_Prerequis)
#######################################
data "terraform_remote_state" "infra-stack" {
  backend = "s3"

  config = {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "tf-demo.tfstate"
    region = var.aws_region
  }
}
