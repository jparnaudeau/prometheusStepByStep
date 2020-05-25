##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "alertmanager"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-alertmanager"
service_protocol   = "HTTP"
service_port       = 9093 # port exposed on ALB
service_name       = "alertmanager"
desired_count      = 1

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port      = 9093
backend_image      = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/alertmanager:v1.0.0"


###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 256  # 1/4 CPU
fargate_total_memory   = 512 # Mo


