resource "aws_cloudwatch_log_group" "docker-stack" {
  name              = "ippevent-prometheus"
  retention_in_days = 14
}

