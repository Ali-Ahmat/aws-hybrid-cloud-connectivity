variable "region" {
  description = "AWS region where resources will be deployed"
  type        = string
}

variable "project_name" {
  description = "Project name used for resource naming and tagging"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "public_subnet_az1_cidr" {
  description = "CIDR block for the public subnet in Availability Zone 1"
  type        = string
}

variable "public_subnet_az2_cidr" {
  description = "CIDR block for the public subnet in Availability Zone 2"
  type        = string
}

variable "private_app_subnet_az1_cidr" {
  description = "CIDR block for the private application subnet in Availability Zone 1"
  type        = string
}

variable "private_app_subnet_az2_cidr" {
  description = "CIDR block for the private application subnet in Availability Zone 2"
  type        = string
}

variable "private_data_subnet_az1_cidr" {
  description = "CIDR block for the private data subnet in Availability Zone 1"
  type        = string
}

variable "private_data_subnet_az2_cidr" {
  description = "CIDR block for the private data subnet in Availability Zone 2"
  type        = string
}