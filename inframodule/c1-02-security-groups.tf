module "eks_worker_group_one_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.7.0"

  name                = "worker_group_one"
  description         = "private Security group to allow connections with in VPC"
  vpc_id              = module.vpc.vpc_id
  ingress_rules       = ["ssh-tcp","https-443-tcp","http-80-tcp"]
  ingress_cidr_blocks = [module.vpc.vpc_cidr_block]


  egress_rules = ["all-all"]
  tags         = local.tags
}

module "eks_worker_group_two_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.7.0"

  name                = "worker_group_two"
  description         = "public Security group to allow connections from outside"
  vpc_id              = module.vpc.vpc_id
  ingress_rules       = ["ssh-tcp","https-443-tcp","http-80-tcp"]
  ingress_cidr_blocks = ["192.168.0.0/16",]

  egress_rules = ["all-all"]
  tags         = local.tags
}

# module "eks_all_security_group" {
#   source  = "terraform-aws-modules/security-group/aws"
#   version = "4.7.0"

#   name                = "all_worker_management"
#   description         = "Allow all connections"
#   vpc_id              = module.vpc.vpc_id
#   ingress_rules       = ["ssh-tcp"]
#   ingress_cidr_blocks = [
#         module.vpc.vpc_cidr_block,
#         "172.16.0.0/12",
#         "192.168.0.0/16",
#       ]

#   egress_rules = ["all-all"]
#   tags         = local.tags
# }


