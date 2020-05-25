#!/bin/bash

echo "create Terraform tfstate bucket"
aws s3api create-bucket --bucket tf-jparnaudeau-demo-prometheus --region eu-west-3 --create-bucket-configuration LocationConstraint=eu-west-3

echo "create ECR Repositories"
aws ecr create-repository --repository-name ippevent/prometheus
aws ecr create-repository --repository-name ippevent/blackbox
aws ecr create-repository --repository-name ippevent/grafana
aws ecr create-repository --repository-name ippevent/alertmanager
aws ecr create-repository --repository-name ippevent/prometheus_reloader
aws ecr create-repository --repository-name ippevent/springboot
aws ecr create-repository --repository-name ippevent/prometheus_ecs_discovery
aws ecr create-repository --repository-name ippevent/custom_exporter
