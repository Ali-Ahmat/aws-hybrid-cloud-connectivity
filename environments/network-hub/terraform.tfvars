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

# Path-1 primary and Path-2 secondary
transit_vifs = {
  primary = {
    enabled        = true
    connection_id  = "dxcon-primary"
    name           = "equinix-transit-vif-primary"
    vlan           = 101
    bgp_asn        = 65010
    address_family = "ipv4"
    bgp_auth_key   = ""
  }

  secondary = {
    enabled        = true
    connection_id  = "dxcon-secondary"
    name           = "equinix-transit-vif-secondary"
    vlan           = 102
    bgp_asn        = 65011
    address_family = "ipv4"
    bgp_auth_key   = ""
  }
}
