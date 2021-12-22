
locals {
  name        = "aqua-assignment"
  environment = "dev"
  region      = var.aws_region
  tags = {
    Environment = local.environment
    Name        = local.name
  }
}
