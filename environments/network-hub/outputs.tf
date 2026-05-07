output "transit_gateway_id" {
  description = "Transit Gateway ID"
  value       = aws_ec2_transit_gateway.core.id
}

output "transit_gateway_route_table_ids" {
  description = "TGW route table IDs keyed by environment"
  value = {
    for env, rt in aws_ec2_transit_gateway_route_table.per_env : env => rt.id
  }
}

output "dx_gateway_id" {
  description = "Direct Connect Gateway ID"
  value       = aws_dx_gateway.core.id
}

output "dx_gateway_association_id" {
  description = "DX Gateway association ID"
  value       = aws_dx_gateway_association.tgw.id
}

output "vpc_cidrs" {
  description = "VPC CIDRs keyed by environment"
  value = {
    for env, vpc in locals.vpcs : env => vpc.cidr_block
  }
}

output "allowed_routes" {
  description = "Allowed destination environments keyed by source environment"
  value       = var.allowed_routes
}

output "transit_vif_id" {
  description = "Transit VIF ID (if created)"
  value       = try(aws_dx_transit_virtual_interface.equinix[0].id, null)
}
