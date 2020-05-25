variable "aws_region" {
  description = "Region used to deploy resources"
  default     = "eu-west-3"
}

# ===========================================================
# Tag - Variables
# ===========================================================
variable "environment" {
  type        = string
  description = "Environment name, should be DEV,INT,UAT,PROD"
}

variable "application" {
  type        = string
  description = "application name"
}

variable "owner" {
  type        = string
  description = "owner of the resource"
}

# ===========================================================
# ALB - Variables
# ===========================================================
variable "allow_cidr_blocks" {
  type = list(string)
  description = "Array of cidr blocks allowed to reach our ALB"
  default = []
}

# ===========================================================
# CLuster - Variables
# ===========================================================
variable "cluster_name" {
  type = string
  description = "Cluster Name"
}