variable "region" {
  description = "AWS region for shared network resources"
  type        = string
}

variable "project_name" {
  description = "Project name used in tags and resource names"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket storing Terraform remote states"
  type        = string
}

variable "dev_state_key" {
  description = "S3 key for dev Terraform state"
  type        = string
}

variable "test_state_key" {
  description = "S3 key for test Terraform state"
  type        = string
}

variable "prod_state_key" {
  description = "S3 key for prod Terraform state"
  type        = string
}

variable "allowed_routes" {
  description = "Per-environment list of destination environments allowed via TGW"
  type        = map(list(string))
}

variable "dx_gateway_name" {
  description = "Direct Connect Gateway name"
  type        = string
}

variable "dx_gateway_amazon_side_asn" {
  description = "Amazon-side ASN for the Direct Connect Gateway"
  type        = number
  default     = 64512
}

variable "create_transit_vif" {
  description = "If true, creates a transit virtual interface for Equinix"
  type        = bool
  default     = false
}

variable "dx_connection_id" {
  description = "Direct Connect connection ID (or hosted connection) from Equinix"
  type        = string
  default     = ""
}

variable "transit_vif_name" {
  description = "Name of the transit virtual interface"
  type        = string
  default     = "equinix-transit-vif"
}

variable "transit_vif_vlan" {
  description = "VLAN for the transit VIF"
  type        = number
  default     = 101
}

variable "transit_vif_bgp_asn" {
  description = "Customer-side BGP ASN used by Equinix side"
  type        = number
}

variable "transit_vif_address_family" {
  description = "Address family for transit VIF"
  type        = string
  default     = "ipv4"
}

variable "transit_vif_bgp_auth_key" {
  description = "Optional BGP MD5 auth key"
  type        = string
  default     = ""
  sensitive   = true
}
