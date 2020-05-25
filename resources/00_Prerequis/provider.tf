provider "aws" {
  region = "eu-west-3"
}

terraform {
  required_version = ">= 0.12"

  backend "s3" {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "tf-demo.tfstate"
    region = "eu-west-3"
  }
}

