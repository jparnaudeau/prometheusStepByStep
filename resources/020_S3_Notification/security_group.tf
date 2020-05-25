
resource "aws_security_group" "lambda" {
  name        = "sgr-${var.environment}-${var.application}-lambda"
  description = "Lambda security group to allows traffic from instances within the VPC."
  vpc_id      = data.terraform_remote_state.infra-stack.outputs.vpc_id

  tags = merge(
    {
      "Name" = "sgr-${var.environment}-${var.application}-lambda"
    },
    local.common_tags,
  )

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
