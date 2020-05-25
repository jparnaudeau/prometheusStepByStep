########################################################################################################################
#
# GLOBAL
#
########################################################################################################################

variable "tags" {
  type        = map(string)
  description = "A list of tags to apply to resources that handles it"
}

variable "short_description" {
  type        = string
  description = "A short description without spaces and letters or -"
}

variable "product_name" {
  type        = string
  description = "Short application name"
}

variable "environment" {
  type        = string
  description = "Environment"
}

########################################################################################################################
#
# Lambda
#
########################################################################################################################
variable "description" {
  type        = string
  description = "A description of the function"
}

variable "filename" {
  type        = string
  description = "The path of the function's deployment package."
}

variable "role_arn" {
  type        = string
  description = "Lambda Execution role ARN attached to lambda, if empty basic execution role is created. Default: empty"
  default     = ""
}

# We need to provide an explicit count because of terraform issue
variable "provided_role" {
  type        = string
  description = "This flag ditermine whether `role_arn is provided or not `. Default: false"
  default     = false
}

variable "role_policy_arns" {
  type        = list(string)
  description = "List of policy ARN to attach to lambda execution role. Default: []"
  default     = []
}

# We need to provide an explicit count because of terraform issue
variable "role_policy_count" {
  type        = number
  description = "Number of policies to attach to lambda execution role (Required if role_policy_arns is provided). Default: 0"
  default     = 0
}

variable "vpc_subnet_ids" {
  type        = list(string)
  description = "List of subnets for lambda VPC config. Default: []"
  default     = []
}

variable "security_group_ids" {
  type        = list(string)
  description = "List of security groups for lambda VPC config. Default: []"
  default     = []
}

variable "handler" {
  type        = string
  description = "Code entrypoint. (function name usually)"
}

variable "runtime" {
  description = "Execution runtime (See https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime)"
}

variable "memory" {
  type        = number
  description = "Amount of memory in MB lambda can use at runtime. Default: 128"
  default     = 128
}

variable "timeout" {
  type        = number
  description = "Max execution time in seconds. Default: 3"
  default     = 3
}

variable "concurrency" {
  type        = number
  description = "Amount of reserved  concurrent executions, 0 desable lambda from being triggered, -1 no limitation. Default -1"
  default     = -1
}

variable "kms_key_arn" {
  type        = string
  description = "The ARN for the KMS encryption key."
  default     = ""
}

variable "tracing_config" {
  type        = string
  description = "Tracing settings of the function. Default: PassThrough"
  default     = "PassThrough"
}

variable "env" {
  type        = map(string)
  description = "Lambda environment variables. Default: {}"
  default     = {}
}

variable "source_services" {
  type        = list(string)
  description = "The services who is getting the permissions to invoke the lambda. Default []"
  default     = []
}

variable "source_arns" {
  type        = list(string)
  description = "The ARNs of the resources whoservices who is getting the permissions to invoke the lambda. Default []"
  default     = []
}

variable "cloudwatch_retention_days" {
  type        = number
  description = "Number of days to keep logs in cloudwatch. Default 30"
  default     = 30
}

variable "cloudwatch_log_group_description" {
  type        = string
  description = "Description of the CloudWatch Log Group"
  default     = "Cloudfront log group for Lambda"
}

variable "lambda_alias" {
  type        = string
  description = "Alias name of lambda latest version."
  default     = "PROD"
}

variable "lambda_layers" {
  type        = list(string)
  description = "List of lambda layer version ARN. length(lambda_layers) <= 5"
  default     = []
}

variable "source_code_hash" {
  type        = bool
  description = "Check base64-encoded sha256 of the package to trigger updates. Default: false"
  default     = false
}