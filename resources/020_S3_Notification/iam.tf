#######################################
# Iam for lambda execution
#######################################
resource "aws_iam_role" "iam_for_lambda" {
  name        = "iam-lambda-${var.environment}-${var.application}"
  description = "role use by lambda which reload prometheus configuration"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF

}

#######################################################
# retrieve official AWS Policy AWSLambdaBasicExecutionRole
# and associate to the service role
#######################################################

resource "aws_iam_role_policy_attachment" "lambda_cloudwatch" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

######################################
# Declare the policy for the lambda execution role :
# - Allow to manage ENI
# - Allow to push logs in CloudWatch
######################################
resource "aws_iam_policy" "lambda_cloudwatch_prom_hotreload_policy" {
  name        = "policy-${var.environment}-${var.application}-lambda-prometheus-hotreload"
  path        = "/"
  description = "Policy used by the lambda for prometheus configuration hot reloading"
  policy      = <<EOF
{
   "Version": "2012-10-17",
   "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface"
      ],
        "Resource": [
          "*"
        ]
    }
   ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "attach_lambda_policy" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_prom_hotreload_policy.arn
}

#######################################################
# retrieve official AWS Policy AWSXRayDaemonWriteAccess
# and associate to the lambda execution role
#######################################################
# data "aws_iam_policy" "awsXrayDaemonWriteAccess_policy" {
#   arn = "arn:aws:iam::aws:policy/AWSXRayDaemonWriteAccess"
# }
# resource "aws_iam_role_policy_attachment" "allow_lambda_send_xray" {
#   role       = "${aws_iam_role.lambda_cloudwatch_logs_processor_execution_role.name}"
#   policy_arn = "${data.aws_iam_policy.awsXrayDaemonWriteAccess_policy.arn}"
# }
