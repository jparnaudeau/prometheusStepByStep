locals {

  common_tags = {
    "ippon:environment" = var.environment
    "ippon:customer"    = "ippon"
    "ippon:owner"       = var.owner
  }
}

