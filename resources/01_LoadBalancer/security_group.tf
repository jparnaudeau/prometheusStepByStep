resource "aws_security_group_rule" "humans_to_alb_https" {
  type        = "ingress"
  from_port   = 443
  to_port     = 443
  protocol    = "tcp"
  description = "Allowed human acces on ALB"

  cidr_blocks       = var.allow_cidr_blocks
  security_group_id = module.alb.security_group_id
}

resource "aws_security_group_rule" "humans_to_alb_9090_9200" {
  type        = "ingress"
  from_port   = 9090
  to_port     = 9200
  protocol    = "tcp"
  description = "Allowed human acces on ALB"

  cidr_blocks       = var.allow_cidr_blocks
  security_group_id = module.alb.security_group_id
}


resource "aws_security_group_rule" "humans_to_alb_8080" {
  type        = "ingress"
  from_port   = 8080
  to_port     = 8080
  protocol    = "tcp"
  description = "Allowed human acces on ALB"

  cidr_blocks       = var.allow_cidr_blocks
  security_group_id = module.alb.security_group_id
}

resource "aws_security_group_rule" "natgateway_to_alb_9090_9200" {
  type        = "ingress"
  from_port   = 9090
  to_port     = 9200
  protocol    = "tcp"
  description = "Allowed IP outbound nat to reach ALB"

  cidr_blocks       = formatlist("%s/32", data.terraform_remote_state.infra-stack.outputs.natgateway_public_ip)
  security_group_id = module.alb.security_group_id
}