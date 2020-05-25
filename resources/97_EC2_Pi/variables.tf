# ===========================================================
# Global variables - TFState
# ===========================================================
variable "region" {
  default     = "eu-west-3"
  description = "AWS Region"
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

variable "additional_tags" {
  type        = map(string)
  description = "A list of additional tags to apply to resources that handles it"
  default     = {}
}

# ===========================================================
# ASG - Variables
# ===========================================================
variable "service_name" {
  description = "ECS Service Name"
}

variable "min_size" {
  type        = number
  description = "Number ec2 in the autoscaling group"
  default     = 1
}

variable "max_size" {
  type        = number
  description = "Number max ec2 in the autoscaling group"
  default     = 1
}

# variable "key_name" {
#   type        = string
#   description = "KeyName."
# }