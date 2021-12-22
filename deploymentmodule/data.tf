#Reading inframodule terraform state from s3
data "terraform_remote_state" "inframodule"{
    backend = "s3"
    config = {
      bucket = "aqua-assignment-remotestate-files"
      key    = "inframodule.tf"
      region = "ap-south-1"
     }
}


# VPC private subnets
data "aws_subnet_ids" "private" {
  vpc_id = data.terraform_remote_state.inframodule.outputs.vpc_id
  tags = {
    tier = "private"
  }
}

data "aws_subnet" "private" {
  for_each = data.aws_subnet_ids.private.ids
  id       = each.value
}

# private Security groups
data "aws_security_groups" "private" {
  filter {
    name   = "group-name"
    values = ["*worker_group_one*"]
  }

  filter {
    name   = "vpc-id"
    values = [data.terraform_remote_state.inframodule.outputs.vpc_id]
  }
}

data "aws_caller_identity" "current" {}

