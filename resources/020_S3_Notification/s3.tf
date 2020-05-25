resource "aws_s3_bucket" "s3_bucket_prom_config" {
  bucket        = "${var.s3_prefix}-${var.environment}-${var.application}-prometheus-config"
  acl           = "private"
  region        = var.region
  force_destroy = true
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "AES256"
      }
    }
  }
  tags = merge(
    local.common_tags,
    {
      "Name" = "${var.s3_prefix}-${var.environment}-${var.application}-prometheus-config"
    },
  )
}


resource "aws_s3_bucket_notification" "prom_bucket_notification" {
  bucket = aws_s3_bucket.s3_bucket_prom_config.id

  lambda_function {
    lambda_function_arn = module.prom_reload.arn
    events              = ["s3:ObjectCreated:*", "s3:ObjectRemoved:*"]
    filter_prefix       = "prometheus/"
  }
}
