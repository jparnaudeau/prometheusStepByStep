
module "alb" {
  source  = "umotif-public/alb/aws"
  version = "~> 1.0"

  name_prefix = "lb-ippevent-prometheus"

  load_balancer_type = "application"

  internal = false
  vpc_id   = data.terraform_remote_state.infra-stack.outputs.vpc_id
  subnets  = data.terraform_remote_state.infra-stack.outputs.public_subnet_id

  tags = local.common_tags
}
