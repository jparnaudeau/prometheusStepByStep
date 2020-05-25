#######################################
# Create The Target Group for ALB
#######################################
resource "aws_alb_target_group" "alb_service_name_tgt_grp" {
  name                 = local.final_targetgroup_name
  port                 = var.container_port
  protocol             = var.container_protocol
  deregistration_delay = var.deregistration_delay
  vpc_id               = data.terraform_remote_state.infra-stack.outputs.vpc_id
  target_type          = "ip"

  dynamic "health_check" {
    for_each = var.container_protocol != "TLS" ? [1] : []
    content {
      port                = var.container_port
      path                = var.health_check_path
      interval            = var.health_check_interval
      protocol            = var.container_protocol
      timeout             = var.health_check_timeout
      healthy_threshold   = var.health_check_healthy_threshold
      unhealthy_threshold = var.health_check_unhealthy_threshold
      matcher             = var.health_check_matcher
    }
  }

  # See https://docs.aws.amazon.com/elasticloadbalancing/latest/network/load-balancer-target-groups.html
  # And https://github.com/terraform-providers/terraform-provider-aws/issues/2708
  dynamic "health_check" {
    for_each = var.container_protocol == "TLS" ? [1] : []
    content {
      port     = var.container_port
      path     = var.health_check_path
      protocol = "HTTPS"
    }
  }

  lifecycle {
    create_before_destroy = true
  }

  tags = merge(
    merge(
      {
        "Name" = local.final_targetgroup_name
      },
      var.additional_tags,
    ),
    local.common_tags,
  )
}

