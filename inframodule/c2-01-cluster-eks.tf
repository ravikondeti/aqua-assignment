module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.21"
  subnets         = module.vpc.private_subnets

  tags = local.tags

  vpc_id = module.vpc.vpc_id

  workers_group_defaults = {
    root_volume_type = "gp2"
  }

  worker_groups = [
    {
      name                          = "sre-pool-main"
      instance_type                 = var.sre_pool_main_instance_type
      asg_desired_capacity          = var.sre_pool_main_node_size
      additional_security_group_ids = [module.eks_worker_group_one_sg.security_group_id]
    },
    {
      name                          = "sre-pool-sec"
      instance_type                 = var.sre_pool_sec_instance_type
      additional_security_group_ids = [module.eks_worker_group_two_sg.security_group_id]
      asg_desired_capacity          = var.sre_pool_sec_node_size
    },
  ]

# AWS Auth (kubernetes_config_map)
  map_roles = [
    {
      groups = ["system:masters"]
      rolearn = "arn:aws:iam::314301073530:role/lambda_role"
      username = "lambda"
    },
  ]
}

