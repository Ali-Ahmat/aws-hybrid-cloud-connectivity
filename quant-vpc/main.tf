# configure aws provider (use default credential chain: env vars in CI, AWS_PROFILE locally)
provider "aws" {
  region = var.region
}

variable "ami_id" {
  type        = string
  description = "AMI ID for the EC2 instance"
}

# create vpc
module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project_name                 = var.project_name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
}

module "ec2" {
  source = "../modules/ec2"

  name                        = "quant-server"
  ami_id                      = var.ami_id
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.private_subnet_ids[0]
  security_group_ids          = [aws_security_group.ec2_sg.id]
  associate_public_ip_address = false

  tags = {
    Project     = "quant-vpc"
  }
}
