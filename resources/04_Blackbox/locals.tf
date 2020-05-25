locals {

  common_tags = {
    "ippon:environment" = var.environment
    "ippon:customer"    = "ippon"
    "ippon:owner"       = var.owner
    "ippon:resource"    = "service-fargate"
  }

  # pretty print url 
  print_port = var.service_port == 443 || var.service_port == 80 ? "" : ":${var.service_port}"
  print_protocol = var.service_protocol == "HTTP" ? "http" : "https"

  final_targetgroup_name = "tg-${var.service_name}-${var.service_port}"

}

