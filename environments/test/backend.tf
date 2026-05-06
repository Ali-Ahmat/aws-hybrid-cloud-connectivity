# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-states"
    key    = "test/terraform.tfstate"
    region = "us-east-1"
  }
}