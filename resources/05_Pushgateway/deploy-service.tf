module "ecs-fargate-service" {
  source  = "../../modules/tf-aws-ecs-fargate"

  # global parameters
  name_preffix = var.service_name
  profile      = "ippon-sandbox-00"
  region       = var.region
  vpc_id       = data.terraform_remote_state.infra-stack.outputs.vpc_id

  # network settings
  private_subnets = data.terraform_remote_state.infra-stack.outputs.private_subnet_id
  public_subnets  = []

  # http/https settings
  lb_arn                  = data.terraform_remote_state.alb_and_cluster.outputs.lb_arn
  lb_http_listeners_arns  = [aws_lb_listener.front_end.arn]
  lb_http_tgs_arns        = [aws_alb_target_group.alb_service_name_tgt_grp.id]
  lb_https_listeners_arns = []
  lb_https_tgs_arns       = []
  load_balancer_sg_id     = data.terraform_remote_state.alb_and_cluster.outputs.alb_security_group_id

  # ecs settings
  container_name          = "pushgateway"
  ecs_cluster_arn         = data.terraform_remote_state.alb_and_cluster.outputs.cluster_id
  ecs_cluster_name        = data.terraform_remote_state.alb_and_cluster.outputs.cluster_name
  task_definition_arn     = module.ecs-fargate-task-definition.aws_ecs_task_definition_td_arn
  desired_count           = var.desired_count
  enable_ecs_managed_tags = true
  propagate_tags          = "TASK_DEFINITION"
  security_groups         = [aws_security_group.ecs_tasks.id]
}

module "ecs-fargate-task-definition" {
  source  = "../../modules/tf-aws-ecs-fargate-task-definition"

  name_preffix = "td-${var.environment}-${var.service_name}"
  profile      = "ippon-sandbox-00"
  region       = var.region

  container_definitions = [module.container_definition_pushgateway.json_map]
  
  container_cpu                = var.fargate_total_cpu
  container_memory             = var.fargate_total_memory
}

# ---------------------------------------------------------------------------------------------------------------------
# Containers Definition
# ---------------------------------------------------------------------------------------------------------------------
module "container_definition_pushgateway" {
  source  = "cloudposse/ecs-container-definition/aws"
  version = "0.23.0"

  container_name               = var.service_name
  container_image              = var.backend_image
  container_cpu                = 256
  essential                    = true

  #container_memory_reservation = var.fargate_total_memory

  port_mappings                = [
    {
      containerPort = 9091,
      hostPort      = 9091,
      protocol      = "tcp"
    }
  ]

  environment = [
    { name = "AWS_REGION", value = var.region },
    { name = "ENVIRONMENT_NAME", value =var.environment },
    { name = "APPLICATION_NAME", value = var.service_name },
  ]
  
  log_configuration = {
    logDriver = "awslogs",
    options = {
      "awslogs-group" : data.terraform_remote_state.alb_and_cluster.outputs.cloudwatch_loggroup_stack_name,
      "awslogs-region" : var.region,
      "awslogs-stream-prefix" : var.service_name
    },
    secretOptions = []
  }
  
  #healthcheck                  = var.healthcheck
  #entrypoint                   = var.entrypoint
  #command                      = var.command
  #working_directory            = var.working_directory
  #secrets                      = var.secrets
  #readonly_root_filesystem     = var.readonly_root_filesystem
  #linux_parameters             = var.linux_parameters
  #firelens_configuration       = var.firelens_configuration

  #dns_servers                  = var.dns_servers
  #ulimits                      = var.ulimits
  #docker_labels                = var.docker_labels
  #repository_credentials       = var.repository_credentials
  #volumes_from                 = var.volumes_from
  #links                        = var.links
  #user                         = var.user
  #container_depends_on         = var.container_depends_on
  #start_timeout                = var.start_timeout
  #stop_timeout                 = var.stop_timeout
  #system_controls              = var.system_controls
}

