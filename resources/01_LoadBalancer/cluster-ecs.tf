# #######################################
# Create Cluster ECS Fargate 
# #######################################
module "my-cluster-ecs-fargate" {
  source = "../../modules/tf-aws-ippon-fargate/cluster"

  environment = var.environment
  application = var.application
  owner       = var.owner

  # cluster Settings
  cluster_name = var.cluster_name
}

