# Deploy a lambda function

This Terraform module allows deploying a lambda function inside or outside a VPC.

This module creates the following resources:

### 1. Lambda function 

Lambda to be created or updated with all corresponding configuration parameters.

### 2.Lambda alias

The created alias always points to the latest published version, the alias abstract the process of promoting new function version to specific stage when new function is published. 


### 3.Cloudwatch log group

The Cloudwatch log group with the provided `cloudwatch_retention_days`, from 1 to 3653 days (10 years).

### 4.Lambda execution role

A lambda execution role to be created, in the case an existing role is not provided through `role_arn` variable. The role has lambda execution basic default permission (`AWSLambdaBasicExecutionRole` or `AWSLambdaVPCAccessExecutionRole` whether the lambda is created inside the vpc or not), in addition to all managed policies provided through `role_policy_arns` variable, note that, you should provide the number of policies in  `role_policy_count` otherwise, policies would not be attached, this is due to terraform issue.


## Usage

#### Lambda Inside VPC without role 

The use case when you need to create a lambda with specific permissions beside basic execution permissions:

```hcl
module "lambda" {
  source = "../modules/lambda"

  filename    = data.archive_file.lambda_src.output_path
  handler     = "handler.handler"
  runtime     = "python3.7"
  description = "lambda module version 2"

  product_name      = "lambda-v2"
  environment       = "sandbox"
  short_description = "test"

  env {
    "DATABASE_CONNECTION" = "DB_STRING"
    "SQS_ARN"             = "SQS"
  }

  cloudwatch_retention_days = 14

  lambda_alias = "STAGING"

  role_policy_arns = [
    aws_iam_policy.lambda_policy.arn,
  ]

  # We need to provide an explicit count because of terraform issue
  role_policy_count = 1

  vpc_subnet_ids = [
    data.aws_subnet_ids.sandbox_private_subnets.ids,
  ]

  security_group_ids = [aws_security_group.lambda_sg.id]

  source_services = ["events"]
  source_arns     = [aws_cloudwatch_event_rule.hourly_schedule_rule.arn]

  tags {
    "Environment" = "sandbox"
    "Owner"       = "jparnaudeau"
    "Application" = "lambda-v2"
  }
}
```

#### Lambda Inside VPC with provided role

In the case where you need to attach multiple lambda functions with the same role, you can provide the `role_arn` attribute:


```hcl

module "lambda_role" {
  source = "../modules/lambda"

  filename    = data.archive_file.lambda_src.output_path
  handler     = "handler.handler"
  runtime     = "python3.7"
  description = "lambda module version 2"

  product_name      = "lambda-v2"
  environment       = "sandbox"
  short_description = "test-with-role"

  env {
    "DATABASE_CONNECTION" = "DB_STRING"
    "SQS_ARN"             = "SQS"
  }

  cloudwatch_retention_days = 14

  lambda_alias = "STAGING"

  role_arn = data.aws_iam_role.basic_role.arn
  # We need to provide an explicit flag about the role because of terraform issue
  provided_role = true

  vpc_subnet_ids = [
    data.aws_subnet_ids.sandbox_private_subnets.ids,
  ]

  security_group_ids = [aws_security_group.lambda_sg.id]

  tags {
    "Environment" = "sandbox"
    "Owner"       = "jparnaudeau"
    "Application" = "lambda-v2"
  }
}
```

#### Lambda with trigger permission

You can grant specific list of resources arn permissions to invoke the lambda function by setting `source_services` and `source_arns`, this example shows permissions usage with a CW event rule:

```hcl
module "lambda" {
  source = "../modules/lambda"

  # ... some config ...

  source_services = ["events"]
  source_arns     = [aws_cloudwatch_event_rule.hourly_schedule_rule.arn]

  # ... some config ...
}

resource "aws_cloudwatch_event_rule" "hourly_schedule_rule" {
  name                = "lambda_schedule_rule"
  description         = "Triggers  lambda  every hour"
  schedule_expression = "rate(1 hour)"
}

resource "aws_cloudwatch_event_target" "hourly_schedule_target" {
  target_id = "cw-to-lambda"
  rule      = aws_cloudwatch_event_rule.hourly_schedule_rule.name
  arn       = module.lambda.arn
}

```

#### Layer versions

Lambda layers make it possible to decouple lambda code from generic & third party libs, this makes deployment packages small, layers can be shared by differents lambda functions since their runtimis are compatible with the layer. 

```hcl

module "lambda" {
  source = "../modules/lambda"

  # ... some config ...

  lambda_layers = [aws_lambda_layer_version.example.arn]

  # ... some config ...
}

resource "aws_lambda_layer_version" "lambda_layer" {
  filename   = "lambda_layer_payload.zip"
  layer_name = "lambda_layer"

  compatible_runtimes = ["python3.7"]
}

```

#### Encryption 

Encryption at rest is enforced using lambda kms key.

#### Tracing

Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with "sampled=1". If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. 


## Inputs & outputs

You can find all input variables & outputs of the module [here](doc.md).


## Release notes

Release notes are available [here](https://github.com/jparnaudeau/prometheusStepByStep/releases). 


