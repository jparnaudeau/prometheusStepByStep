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
# ECS Service HealthCheck - Variables
# ===========================================================
variable "health_check_path" {
  description = "path for health check"
  default     = "/"
}

variable "health_check_interval" {
  description = "Time Interval for health check in seconds"
  default     = "100"
}

variable "health_check_grace_period" {
  default     = "500"
  description = "Grace period in seconds for the load balancer delay to not shut down our task"
}

variable "health_check_timeout" {
  description = "The amount of time, in seconds, during which no response means a failed health check. For Application Load Balancers, the range is 2 to 60 seconds and the default is 5 seconds"
  default     = "5"
}

variable "health_check_healthy_threshold" {
  description = "The number of consecutive health checks successes required before considering an unhealthy target healthy. Defaults to 3."
  default     = "3"
}

variable "health_check_unhealthy_threshold" {
  description = "The number of consecutive health check failures required before considering the target unhealthy . For Network Load Balancers, this value must be the same as the healthy_threshold. Defaults to 3."
  default     = "3"
}

variable "health_check_matcher" {
  description = "The HTTP codes to use when checking for a successful response from a target. You can specify multiple values (for example, '200,202') or a range of values (for example, '200-299')"
  default     = "200,302"
}

variable "deregistration_delay" {
  description = "Time in seconds before remove the container in target group"
  default     = "100"
}

# ===========================================================
# ECS Service - Variables
# ===========================================================
variable "service_name" {
  description = "ECS Service Name"
}

variable "container_protocol" {
  description = "The protocol to use by the TargetGroup with the front container (nginx)"
  default     = "HTTPS"
}

variable "desired_count" {
  type        = number
  description = "Number of desired ECS task"
  default     = 1
}

# ===========================================================
# ECS Service - custom Variables for custom task definition
# ===========================================================
variable "cloudwatch_loggroup_retention_days" {
  description = "retention days for the custom cloudwatch loggroup referenced into the custom task definition"
  default     = 30
}

# ===========================================================
# ECS Service - Backend Container Variables
# ===========================================================
variable "service_dns_prefix" {
  type = string
  description = "the service will available from the LoadBalancer with FQDN <service_dns_prefix>.sbx.aws.ippon.fr"
}

variable "service_protocol" {
  type        = string
  description = "the protocol defined at the ALB Level (HTTP or HTTPS)"
  default     = "HTTP"
}

variable "service_port" {
  description = "The Port used to reach the service deployed on the ALB"
  default     = 8080
}

variable "backend_image" {
  description = "Backend Image repository"
  default = ""
}

variable "container_port" {
  description = "The port on wich the traffic from ALB will routed on"
  default     = 8080
}

# ===========================================================
# Fargate Tuning - Variables
# ===========================================================
variable "fargate_total_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  default     = 512
}

variable "fargate_total_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  default     = 1024
}

# ===========================================================
# Other Prometheus Container - Variables
# ===========================================================
variable "prometheus_reloader_image" {
  description = "Prometheus Reloader Image"
  default = ""
}

variable "ecs_discovery_service_image" {
  description = "Prometheus ECS Discovery Image"
  default = ""
}

variable "custom_exporter_image" {
  description = "Custom Exporter Image"
  default = ""
}