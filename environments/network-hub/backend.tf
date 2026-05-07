terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-states"
    key    = "network-hub/terraform.tfstate"
    region = "us-east-1"
  }
}
