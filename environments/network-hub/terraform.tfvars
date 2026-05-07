region         = "us-east-1"
project_name   = "quant-shared-network"
state_bucket   = "quant-terraform-remote-states"
dev_state_key  = "dev/terraform.tfstate"
test_state_key = "test/terraform.tfstate"
prod_state_key = "prod/terraform.tfstate"

allowed_routes = {
  dev  = ["test"]
  test = ["dev"]
  prod = ["dev", "test"]
}

dx_gateway_name            = "quant-dx-gw"
dx_gateway_amazon_side_asn = 64512

# Set to true after Equinix provides the hosted connection ID and BGP details.
create_transit_vif  = false
dx_connection_id    = "dxcon-xxxxxxxx"
transit_vif_name    = "equinix-transit-vif"
transit_vif_vlan    = 101
transit_vif_bgp_asn = 65010

# Optional BGP MD5 key
transit_vif_bgp_auth_key = ""
