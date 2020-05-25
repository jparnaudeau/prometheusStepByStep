locals {

  common_tags = {
    "ippon:environment" = var.environment
    "ippon:customer"    = "ippon"
    "ippon:owner"       = var.owner
    "ippon:resource"    = "asg"
  }

  iam_instance_profile = "profile-${var.application}-${var.service_name}"


}

