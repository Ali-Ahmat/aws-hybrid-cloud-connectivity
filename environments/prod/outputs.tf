output "vpc_id" {
  description = "VPC ID for the prod environment"
  value       = module.vpc.vpc_id
}

output "vpc_cidr" {
  description = "CIDR block for the prod VPC"
  value       = var.vpc_cidr
}

output "private_app_subnet_ids" {
  description = "Private app subnet IDs used for TGW attachment"
  value       = module.vpc.private_app_subnet_ids
}
