variable "region" {
  type        = string
  description = "AWS region for the IAM resources."
  default     = "us-east-1"
}

variable "github_repository" {
  type        = string
  description = "GitHub repository allowed to assume the role (org/repo, case-sensitive)."
}

variable "state_bucket_name" {
  type        = string
  description = "S3 bucket that stores Terraform remote state."
  default     = "quant-terraform-remote-state"
}

variable "iam_role_name" {
  type        = string
  description = "Name of the IAM role GitHub Actions will assume."
  default     = "github-actions-terraform-ci"
}

variable "create_oidc_provider" {
  type        = bool
  description = "Set false if this account already has an IAM OIDC provider for token.actions.githubusercontent.com."
  default     = true
}

variable "oidc_provider_arn" {
  type        = string
  description = "Required when create_oidc_provider is false: existing OIDC provider ARN for GitHub."
  default     = null

  validation {
    condition     = var.create_oidc_provider || (try(length(var.oidc_provider_arn), 0) > 0)
    error_message = "When create_oidc_provider is false, oidc_provider_arn must be set to the existing provider ARN."
  }
}

variable "terraform_state_object_keys" {
  type        = list(string)
  description = "State object keys inside the state bucket this role may read and write."
  default     = ["quant-vpc.tfstate", "github-oidc.tfstate"]
}
