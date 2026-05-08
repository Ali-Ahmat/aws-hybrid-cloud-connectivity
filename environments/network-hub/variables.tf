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

variable "transit_vifs" {
  description = "Transit VIF definitions keyed by path name (for example, primary and secondary)"
  type = map(object({
    enabled        = bool
    connection_id  = string
    name           = string
    vlan           = number
    bgp_asn        = number
    address_family = optional(string, "ipv4")
    bgp_auth_key   = optional(string, "")
  }))
  default = {}
}
