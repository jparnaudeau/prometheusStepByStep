output "lb_arn" {
    description = "LoadBalancer ARN"
    value = module.alb.arn
}

output "cluster_id" {
    description = "ECS Cluster ID"
    value = module.my-cluster-ecs-fargate.cluster_id
}

output "cluster_name" {
    description = "ECS Cluster Name"
    value = module.my-cluster-ecs-fargate.cluster_name
}

output "cloudwatch_loggroup_stack_name" {
    description = "The CloudWatch Log Group to used at service level"
    value = aws_cloudwatch_log_group.docker-stack.name
}

output "alb_security_group_id" {
    description = "The Security Group Id associated to the ALB"
    value = module.alb.security_group_id
}


output alb_dns_name {
    description = "return the DNS name of the ALB"
    value = module.alb.dns_name
}
