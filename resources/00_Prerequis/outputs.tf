output "vpc_id" {
    description = "VPC ID"
    value = module.vpc.vpc_id
}

output "public_subnet_id" {
    description = "Subnet ID"
    value = module.vpc.public_subnets
}

output "public_subnet_cidr_blocks" {
    description = "Public Subnets CIDR Blocks"
    value = module.vpc.public_subnets_cidr_blocks
}

output "private_subnet_id" {
    description = "Subnet ID"
    value = module.vpc.private_subnets
}

output "private_subnet_cidr_blocks" {
    description = "Private Subnets CIDR Blocks"
    value = module.vpc.private_subnets_cidr_blocks
}

output "natgateway_ids" {
  description = "Natgateway IDs"
  value = module.vpc.natgw_ids
}

output "natgateway_public_ip" {
  description = "Natgateway public IP"
    value = module.vpc.nat_public_ips
}
