output "target_group_arn" {
  value       = aws_alb_target_group.alb_service_name_tgt_grp.id
  description = "The target Group arn pointing to the service deploy into our ecs cluster"
}

output "service_ecs_tasks_securitygroup_id" {
  description = "The security group associated to the service"
  value       = aws_security_group.ecs_tasks.id
}

output "service_ecs_tasks_role_id" {
  description = "The execution role id associated to the ecsservice"
  value       = module.ecs-fargate-task-definition.aws_iam_role_ecs_task_execution_role_id
}

output "service_id" {
  description = "The id of the service deployed into the ecs cluster"
  value       = module.ecs-fargate-service.aws_ecs_service_service_id
}

output "service_name" {
  description = "The name of the service deployed into the ecs cluster"
  value       = module.ecs-fargate-service.aws_ecs_service_service_name
}

output "application_name" {
  description = "The application name"
  value       = var.application
}


output "service_url_amazonaws_dns" {
  description = "the service URL using the original Amazon aws.com fqdn"
  value = format("%s://%s%s/",local.print_protocol,data.terraform_remote_state.alb_and_cluster.outputs.alb_dns_name,local.print_port)
}


