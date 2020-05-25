# This file manage the exposition of our service on the ALB created at the step "01_LoadBalancer"
# We have choose to :
# - Create a HTTP Listener dedicated to our service. So each service will be available from a specific port
# - if we want https, we need to generate a certificate dedicated to our service
# - http or https, we will register the service in the ippon hosted zone

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = data.terraform_remote_state.alb_and_cluster.outputs.lb_arn
  port              = var.service_port
  protocol          = var.service_protocol
  ssl_policy        = var.service_protocol == "HTTPS" ? "ELBSecurityPolicy-2016-08" : ""
  certificate_arn   = ""

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_service_name_tgt_grp.id
  }
}

