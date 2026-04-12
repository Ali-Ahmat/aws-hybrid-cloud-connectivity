output "github_actions_role_arn" {
  description = "Set this value as the AWS_ROLE_ARN repository secret for GitHub Actions."
  value       = aws_iam_role.github_actions_terraform.arn
}

output "oidc_provider_arn" {
  description = "ARN of the GitHub OIDC provider in this account (new or existing)."
  value       = local.oidc_provider_arn
}
