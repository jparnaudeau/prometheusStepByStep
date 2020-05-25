#######################################
# Create The security Group in front of
# the ecs tasks
#######################################
resource "aws_security_group" "ecs_tasks" {
  name        = "sgr-${var.application}-${var.service_name}"
  description = "Security Group for service ${var.application}-${var.service_name}"
  vpc_id      = data.terraform_remote_state.infra-stack.outputs.vpc_id

  tags = merge(
    merge(
      {
        "Name" = "sgr-${var.application}-${var.service_name}"
      },
      var.additional_tags,
    ),
    local.common_tags,
  )
}

#######################################
# Create The security Group Rule
# Allow ALB to reach our container
#######################################
resource "aws_security_group_rule" "alb_ecs_ingress_https" {
  type        = "ingress"
  from_port   = var.container_port
  to_port     = var.container_port
  protocol    = "tcp"
  description = "Allow ALB Access to communicate with ECS Service ${var.application}-${var.service_name}"

  source_security_group_id = data.terraform_remote_state.alb_and_cluster.outputs.alb_security_group_id
  security_group_id        = aws_security_group.ecs_tasks.id
}

#######################################
# Create The security Group Rule
# For Outboud Traffic on ECS Task : no Restriction
#######################################
resource "aws_security_group_rule" "ecs_www_egress_all" {
  type        = "egress"
  from_port   = "-1"
  to_port     = "-1"
  protocol    = "all"
  description = "Allow all Outbound Traffic for ECS"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ecs_tasks.id
}
