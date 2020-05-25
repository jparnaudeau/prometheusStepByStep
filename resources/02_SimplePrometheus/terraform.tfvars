##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "prometheus"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-prometheus"
service_protocol   = "HTTP"
service_port       = 9090 # port exposed on ALB
service_name       = "prometheus"
desired_count      = 1

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port     = 9090
backend_image      = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/prometheus:v1.0.0"

# ecs_discovery_service_image = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/prometheus_ecs_discovery:v1.3.1"
# custom_exporter_image       = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/custom_exporter:v1.0.0"

###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 1024  # 1 CPU
fargate_total_memory   = 2048 # Mo
