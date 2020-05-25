
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
      }
  ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "ecs_task_policy_attachment" {
  role       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_id
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}

