# EKS Cluster
variable "cluster_name" {
  type  = string
  default = "terraform-eks-assign-cluster"
}

variable "sre_pool_main_node_size" {
  type  = number
  default = 2
}

variable "sre_pool_sec_node_size" {
  type  = number
  default = 1
}

variable "sre_pool_main_instance_type" {
  type  = string
  default = "t2.micro"
}

variable "sre_pool_sec_instance_type" {
  type  = string
  default = "t2.micro"
}