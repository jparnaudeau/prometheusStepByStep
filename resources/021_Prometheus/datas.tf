#######################################
# retrieve the TFState for the Infra (Step 00_Prerequis)
#######################################
data "terraform_remote_state" "infra-stack" {
  backend = "s3"

  config = {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "tf-demo.tfstate"
    region = var.region
  }
}

#######################################
# retrieve the TFState for the ALB & ECS Cluster (Step 01_LoadBalancer)
#######################################
data "terraform_remote_state" "alb_and_cluster" {
  backend = "s3"

  config = {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "lb-tf-demo.tfstate"
    region = var.region
  }
}

#######################################
# retrieve the TFState for the S3 bucket for hotReloading (Step 020_S3_Notification)
#######################################
data "terraform_remote_state" "s3_reload" {
  backend = "s3"

  config = {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "s3-notification.tfstate"
    region = var.region
  }
}
