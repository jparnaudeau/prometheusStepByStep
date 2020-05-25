##############################################################
#
# Lambda Function
#
##############################################################
resource "aws_lambda_function" "lambda" {
  depends_on = [aws_cloudwatch_log_group.lambda_cloudwatch_log_group]

  filename                       = var.filename
  function_name                  = format(local.resource_name_pattern, "lbd")
  role                           = var.provided_role ? var.role_arn : element(concat(aws_iam_role.lambda_role.*.arn, [""]), 0)
  handler                        = var.handler
  source_code_hash               = var.source_code_hash != false ? var.source_code_hash : filebase64sha256(var.filename)
  runtime                        = var.runtime
  memory_size                    = var.memory
  timeout                        = var.timeout
  reserved_concurrent_executions = var.concurrency
  description                    = var.description
  kms_key_arn                    = var.kms_key_arn
  tags                           = var.tags
  publish                        = true
  layers                         = var.lambda_layers

  tracing_config {
    mode = var.tracing_config
  }

  vpc_config {
    subnet_ids         = var.vpc_subnet_ids
    security_group_ids = var.security_group_ids
  }

  dynamic "environment" {
    for_each = length(keys(var.env)) == 0 ? [] : [var.env]

    content {
      variables = var.env
    }
  }
}

##############################################################
#
# Lambda Alias
#
##############################################################
resource "aws_lambda_alias" "lambda_alias" {
  function_name    = aws_lambda_function.lambda.function_name
  function_version = aws_lambda_function.lambda.version
  name             = var.lambda_alias
}

##############################################################
#
# Lambda permissions
#
##############################################################

resource "aws_lambda_permission" "lambda_permission" {
  count = length(var.source_services)

  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda.function_name

  principal  = "${var.source_services[count.index]}.amazonaws.com"
  source_arn = var.source_arns[count.index]
}

