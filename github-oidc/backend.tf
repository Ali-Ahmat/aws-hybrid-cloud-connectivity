# environments/prod/backend.tf
terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-state"
    key    = "github-oidc.tfstate"
    region = "us-east-1"
  }
}

# environments/dev/backend.tf
terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-states"
    key    = "dev/terraform.tfstate"
    region = "us-east-1"
  }
}

# environments/test/backend.tf
terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-states"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}
