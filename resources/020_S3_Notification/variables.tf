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
# Variables
# ===========================================================
variable "s3_prefix" {
  description = "A Prefix used when created S3 Bucket. Need to be uniq on the world"
  default     = "ippevent-jparnaudeau"
}

# ===========================================================
# lambda - Variables
# ===========================================================
variable "lambda_short_description" {
  description = "The lambda function used for prometheus config reloading"
  default     = "prom-configs-reloading"
}

variable "lambda_package" {
  description = "Lambda package name"
  default     = "reload_config.zip"
}

variable "lambdas_runtime" {
  description = "Lambda runtime"
  default     = "python3.7"
}

variable "lambdas_memory_size" {
  description = "Lambdas allocated memory"
  default     = "256"
}

variable "lambdas_exec_timeout" {
  description = "Lambdas max execution time"
  default     = "300"
}

variable "lambda_concurrency" {
  description = "The unit of scale for AWS Lambda is a concurrent execution"
  default     = 1
}

variable "prometheus_url" {
  description = "The url of prometheus"
}

variable "cloudwatch_retention_days" {
  description = "Number of days to keep logs in cloudwatch. Default 30"
  default     = 30
}

