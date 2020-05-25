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
# retrieve the TFState for Prometheus
#######################################
data "terraform_remote_state" "prometheus" {
  backend = "s3"

  config = {
    bucket = "tf-jparnaudeau-demo-prometheus"
    key    = "service-99.tfstate"
    region = var.region
  }
}


