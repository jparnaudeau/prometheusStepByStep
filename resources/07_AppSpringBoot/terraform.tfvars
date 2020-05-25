##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "springboot"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-app"
service_protocol   = "HTTP"
service_port       = 8080 # port exposed on ALB
service_name       = "springboot"
desired_count      = 3

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port      = 8080
backend_image      = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/springboot:v1.0.0"


###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 512  # 1/4 CPU
fargate_total_memory   = 1024 # Mo

