module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"

  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_dns_hostnames = var.vpc_enable_dns_hostnames
  enable_dns_support   = var.vpc_enable_dns_support

  enable_nat_gateway = var.vpc_enable_nat_gateway
  single_nat_gateway = var.vpc_enable_nat_gateway

  tags     = local.tags
  vpc_tags = local.tags

  public_subnet_tags = {
    tier = "public"
  }

  private_subnet_tags = {
    tier = "private"
  }

}