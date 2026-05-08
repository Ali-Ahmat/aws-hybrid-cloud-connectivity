provider "aws" {
  region = var.region
}

data "terraform_remote_state" "dev" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.dev_state_key
    region = var.region
  }
}

data "terraform_remote_state" "test" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.test_state_key
    region = var.region
  }
}

data "terraform_remote_state" "prod" {
  backend = "s3"
  config = {
    bucket = var.state_bucket
    key    = var.prod_state_key
    region = var.region
  }
}

locals {
  vpcs = {
    dev = {
      vpc_id     = data.terraform_remote_state.dev.outputs.vpc_id
      cidr_block = data.terraform_remote_state.dev.outputs.vpc_cidr
      subnet_ids = data.terraform_remote_state.dev.outputs.private_app_subnet_ids
    }
    test = {
      vpc_id     = data.terraform_remote_state.test.outputs.vpc_id
      cidr_block = data.terraform_remote_state.test.outputs.vpc_cidr
      subnet_ids = data.terraform_remote_state.test.outputs.private_app_subnet_ids
    }
    prod = {
      vpc_id     = data.terraform_remote_state.prod.outputs.vpc_id
      cidr_block = data.terraform_remote_state.prod.outputs.vpc_cidr
      subnet_ids = data.terraform_remote_state.prod.outputs.private_app_subnet_ids
    }
  }

  route_entries = merge([
    for source_env, destination_envs in var.allowed_routes : {
      for destination_env in destination_envs : "${source_env}->${destination_env}" => {
        source      = source_env
        destination = destination_env
      }
      if source_env != destination_env && contains(keys(locals.vpcs), source_env) && contains(keys(locals.vpcs), destination_env)
    }
  ]...)

  active_transit_vifs = {
    for path_name, vif in var.transit_vifs : path_name => vif
    if vif.enabled
  }
}

resource "aws_ec2_transit_gateway" "core" {
  description                     = "${var.project_name} transit gateway"
  default_route_table_association = "disable"
  default_route_table_propagation = "disable"
  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"

  tags = {
    Name        = "${var.project_name}-tgw"
    Environment = "shared"
  }
}

resource "aws_ec2_transit_gateway_route_table" "per_env" {
  for_each           = locals.vpcs
  transit_gateway_id = aws_ec2_transit_gateway.core.id

  tags = {
    Name = "${var.project_name}-${each.key}-tgw-rt"
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "vpcs" {
  for_each           = locals.vpcs
  transit_gateway_id = aws_ec2_transit_gateway.core.id
  vpc_id             = each.value.vpc_id
  subnet_ids         = each.value.subnet_ids
  dns_support        = "enable"
  ipv6_support       = "disable"

  tags = {
    Name = "${var.project_name}-${each.key}-tgw-attachment"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "vpcs" {
  for_each                       = aws_ec2_transit_gateway_vpc_attachment.vpcs
  transit_gateway_attachment_id  = each.value.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.per_env[each.key].id
}

resource "aws_ec2_transit_gateway_route" "explicit" {
  for_each = locals.route_entries

  destination_cidr_block         = locals.vpcs[each.value.destination].cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_vpc_attachment.vpcs[each.value.destination].id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.per_env[each.value.source].id
}

resource "aws_dx_gateway" "core" {
  name            = var.dx_gateway_name
  amazon_side_asn = var.dx_gateway_amazon_side_asn
}

resource "aws_dx_gateway_association" "tgw" {
  dx_gateway_id         = aws_dx_gateway.core.id
  associated_gateway_id = aws_ec2_transit_gateway.core.id

  allowed_prefixes = [
    for vpc in values(locals.vpcs) : vpc.cidr_block
  ]
}

resource "aws_dx_transit_virtual_interface" "equinix" {
  for_each = local.active_transit_vifs

  connection_id  = each.value.connection_id
  name           = each.value.name
  vlan           = each.value.vlan
  address_family = each.value.address_family
  bgp_asn        = each.value.bgp_asn
  dx_gateway_id  = aws_dx_gateway.core.id
  bgp_auth_key   = each.value.bgp_auth_key != "" ? each.value.bgp_auth_key : null

  tags = {
    Name = each.value.name
    Path = each.key
  }
}
