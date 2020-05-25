
resource "aws_lambda_permission" "prom_allow_bucket" {
  statement_id   = "AllowExecutionFromS3Bucket"
  action         = "lambda:InvokeFunction"
  function_name  = module.prom_reload.arn
  principal      = "s3.amazonaws.com"
  source_arn     = aws_s3_bucket.s3_bucket_prom_config.arn
  source_account = data.aws_caller_identity.current.account_id
}

module "prom_reload" {
  source = "../../modules/lambda"

  environment       = var.environment
  product_name      = var.application
  short_description = var.lambda_short_description

  tags = local.common_tags

  description               = "Prometheus reload lambda"
  filename                  = "src/${var.lambda_package}"
  role_arn                  = aws_iam_role.iam_for_lambda.arn
  handler                   = "reload_conf.lambda_handler"
  runtime                   = var.lambdas_runtime
  memory                    = var.lambdas_memory_size
  timeout                   = var.lambdas_exec_timeout
  concurrency               = var.lambda_concurrency
  cloudwatch_retention_days = var.cloudwatch_retention_days
  provided_role             = "true"
  vpc_subnet_ids            = data.terraform_remote_state.infra-stack.outputs.private_subnet_id
  security_group_ids        = [aws_security_group.lambda.id]

  env = {
    endpoint = var.prometheus_url
  }
}

