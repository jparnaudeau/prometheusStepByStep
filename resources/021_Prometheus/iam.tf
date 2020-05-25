
#====> Create IAM role for task
resource "aws_iam_policy" "ecs_task_policy" {
  name        = "policy-${var.environment}-${var.application}-${var.service_name}-ecs_task"
  path        = "/"
  description = "Policy for the ECS Task Prometheus Service"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
           "Effect": "Allow",
           "Action": [
                "ecs:ListClusters",
                "ecs:ListTasks",
                "ecs:DescribeTask",
                "ec2:DescribeInstances",
                "ecs:DescribeContainerInstances",
                "ecs:DescribeTasks",
                "ecs:DescribeTaskDefinition",
                "ecs:DescribeClusters"
           ],
           "Resource": "*"
      },
      {
           "Effect": "Allow",
           "Action": [
                "cloudwatch:ListMetrics",
                "cloudwatch:GetMetricStatistics"
           ],
           "Resource": "*"
      },
      {
        "Effect": "Allow",
        "Action": ["s3:GetObject", "s3:ListObjectsV2"],
        "Resource": [
          "arn:aws:s3:::${data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id}/*"
        ]
      },
      {
        "Effect": "Allow",
        "Action": ["s3:ListBucket", "s3:ListObjectsV2"],
        "Resource": [
          "arn:aws:s3:::${data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id}"
        ]
      }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_id
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}


##################################################################
# Create S3 Bucket Policy to allow Prometheus Service to push files on S3 Bucket
##################################################################
resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id

  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "policy-${var.environment}-${var.application}-ecs-task-allow-push",
  "Statement": [
    {
      "Sid": "Allow-push",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_arn}"
        ]
      },
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::${data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id}",
        "arn:aws:s3:::${data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id}/*"
      ]
    },
    {
      "Sid": "DenyUnSecureRequest",
      "Action": "*",
      "Effect": "Deny",
      "Resource": "arn:aws:s3:::${data.terraform_remote_state.s3_reload.outputs.s3_bucket_prom_config_id}/*",
      "Condition": {
        "Bool": {
          "aws:SecureTransport": "false"
        }
      },
      "Principal": "*"
    }
  ]
}
POLICY

}
