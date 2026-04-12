terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-state"
    key    = "github-oidc.tfstate"
    region = "us-east-1"
  }
}
