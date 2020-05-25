variable "aws_region" {
  description = "Region used to deploy resources"
  default     = "eu-west-3"
}

# ===========================================================
# Tag - Variables
# ===========================================================
variable "environment" {
  type        = string
  description = "Environment name"
}

variable "application" {
  type        = string
  description = "application name"
}

variable "owner" {
  type        = string
  description = "owner of the resource"
}

