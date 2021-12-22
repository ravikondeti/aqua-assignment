#Region
variable "aws_region" {
  default     = "ap-south-1"
  description = "AWS region"
}

variable "getpods_lambda_function_name" {
  default ="k8nodes_lambdafn"
}

variable "lambda_assume_role" {
  default = "lambda_Eks_role"
}
