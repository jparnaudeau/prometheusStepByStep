##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "pushgateway"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-pushgateway"
service_protocol   = "HTTP"
service_port       = 9091 # port exposed on ALB
service_name       = "pushgateway"
desired_count      = 1

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port      = 9091
backend_image      = "prom/pushgateway"


###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 256  # 1/4 CPU
fargate_total_memory   = 512 # Mo


