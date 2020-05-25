##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "blackbox"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-blackbox"
service_protocol   = "HTTP"
service_port       = 9115 # port exposed on ALB
service_name       = "blackbox"
desired_count      = 1

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port      = 9115
#backend_image      = "prom/blackbox-exporter"
backend_image       = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/blackbox:v0.16.0"

###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 256  # 1/4 CPU
fargate_total_memory   = 512 # Mo


