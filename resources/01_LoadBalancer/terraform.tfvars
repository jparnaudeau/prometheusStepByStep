aws_region = "eu-west-3"

# tags 
environment = "sandbox"
application = "prometheus"
owner       = "jparnaudeau"

# ALB settings
#Allowed cidr blocks on the ALB
allow_cidr_blocks=["12.34.56.78/32"]

# ECS Cluster name
cluster_name = "cluster"
