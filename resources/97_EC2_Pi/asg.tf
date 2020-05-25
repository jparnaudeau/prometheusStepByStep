locals {
  userdata = <<-USERDATA
    #!/bin/bash
    cat <<"__EOF__" > /home/ec2-user/.ssh/config
    Host *
      StrictHostKeyChecking no
    __EOF__
    chmod 600 /home/ec2-user/.ssh/config
    chown ec2-user:ec2-user /home/ec2-user/.ssh/config
  USERDATA
}

module "autoscale_group" {
  source = "git::https://github.com/cloudposse/terraform-aws-ec2-autoscale-group.git?ref=0.4.0"

  namespace = var.application
  stage     = var.environment
  name      = "pi-calculation"

  image_id                    = "ami-00077e3fed5089981"
  instance_type               = "t2.small"
  security_group_ids          = [aws_security_group.ec2_asg_sg.id]
  subnet_ids                  = data.terraform_remote_state.infra-stack.outputs.private_subnet_id
  health_check_type           = "EC2"
  min_size                    = var.min_size
  max_size                    = var.max_size
  wait_for_capacity_timeout   = "5m"
  associate_public_ip_address = false
  user_data_base64            = "${base64encode(local.userdata)}"
  #key_name                    = var.key_name


  iam_instance_profile_name   = aws_iam_instance_profile.ec2-profile.id
  

  # Auto-scaling policies and CloudWatch metric alarms
  autoscaling_policies_enabled           = "false"
  cpu_utilization_high_threshold_percent = "70"
  cpu_utilization_low_threshold_percent  = "20"

  tags = merge(var.additional_tags,local.common_tags)
}