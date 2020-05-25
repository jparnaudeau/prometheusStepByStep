locals {
  # resource name pattern 
  resource_name_pattern  = "%s-${var.environment}-${var.product_name}-${var.short_description}"
  basic_execution_policy = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  vpc_execution_policy   = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  inside_vpc             = length(var.vpc_subnet_ids) > 0 ? true : false

  full_role_policy_arns = concat(
    var.role_policy_arns,
    [
      local.inside_vpc ? local.vpc_execution_policy : local.basic_execution_policy,
    ]
  )
}