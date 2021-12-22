#Region
variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS region"
}

# VPC variable
variable "vpc_id" {
  default =  "vpc-0d59a62dcd951ccb1"
}