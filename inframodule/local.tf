
locals {
  name        = "aqua-assignment"
  environment = "dev"
  cluster_name = var.cluster_name
  region      = var.aws_region
  tags = {
    Environment = local.environment
    Name        = local.name
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
  }
}
