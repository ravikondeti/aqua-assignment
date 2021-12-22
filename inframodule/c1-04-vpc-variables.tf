#Region
variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "vpc_name" {
  type    = string
  default = "my-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "vpc_azs" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}

variable "vpc_private_subnets" {
  type    = list(string)
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "vpc_public_subnets" {
  type    = list(string)
  default = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
}


variable "vpc_manage_default_route_table" {
  type    = bool
  default = true
}

variable "vpc_enable_nat_gateway" {
  type    = bool
  default = true
}

variable "vpc_single_nat_gateway" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_hostnames" {
  type    = bool
  default = true
}

variable "vpc_enable_dns_support" {
  type    = bool
  default = true
}




