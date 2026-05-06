# store the terraform state file in s3
terraform {
  backend "s3" {
    bucket = "quant-terraform-remote-states"
    key    = "quant-vpc.tfstate"
    region = "us-east-1"
  }
}