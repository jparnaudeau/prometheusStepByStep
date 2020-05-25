##########################
# Tag variables
###########################
environment = "sandbox"
application = "ippevent"
owner       = "jparnaudeau"

additional_tags = {
    Component = "monitoring"
    Stack = "grafana"
}

###########################
# ECS Service - Variables
###########################
service_dns_prefix = "ippenvent-grafana"
service_protocol   = "HTTP"
service_port       = 9200 # port exposed on ALB
service_name       = "grafana"
desired_count      = 1

###########################
# Container - Variables
###########################
container_protocol = "HTTP"
container_port      = 3000
#backend_image      = "grafana/grafana"
backend_image       = "448878779811.dkr.ecr.eu-west-3.amazonaws.com/ippevent/grafana:6.7.3"


###########################
# Fargate Tuning - Variables
###########################
fargate_total_cpu      = 256  # 1/4 CPU
fargate_total_memory   = 512 # Mo


