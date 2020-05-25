#######################################
# Create The security Group in front of
# the ecs tasks
#######################################
resource "aws_security_group" "ec2_asg_sg" {
  name        = "sgr-${var.application}-asg-${var.service_name}"
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
  from_port   = 9100
  to_port     = 9100
  protocol    = "tcp"
  description = "Allow Prometheus to reach our nodeExporter process"

  source_security_group_id = data.terraform_remote_state.prometheus.outputs.service_ecs_tasks_securitygroup_id
  security_group_id        = aws_security_group.ec2_asg_sg.id
}

#######################################
# Create The security Group Rule
# For Outboud Traffic on ECS Task : no Restriction
#######################################
resource "aws_security_group_rule" "ec2_egress_all" {
  type        = "egress"
  from_port   = "-1"
  to_port     = "-1"
  protocol    = "all"
  description = "Allow all Outbound Traffic for ECS"

  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_asg_sg.id
}
