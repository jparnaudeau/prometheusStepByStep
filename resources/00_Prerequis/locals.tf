locals {
  common_tags = {
    "environment" = var.environment
    "owner"       = var.owner
    "application" = var.application
  }
}
