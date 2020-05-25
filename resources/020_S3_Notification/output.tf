output "sg_lambda_id" {
  description = "Security group associated to the Lambdas"
  value = aws_security_group.lambda.id
}

output "s3_bucket_prom_config_id" {
  description = "Bucket ID where to put configuration files and where notifications come from"
  value = aws_s3_bucket.s3_bucket_prom_config.id
}

output "s3_bucket_prom_config_arn" {
  description = "Bucket ARN where to put configuration files and where notifications come from"
  value = aws_s3_bucket.s3_bucket_prom_config.arn
}

output "lambda_prometheus_reload_arn" {
  description = "Lambda Prometheus config reloader name"
  value = module.prom_reload.arn
}
