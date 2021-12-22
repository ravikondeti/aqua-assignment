
# VPC private subnets
data "aws_subnet_ids" "private" {
  vpc_id = var.vpc_id
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
    values = [var.vpc_id]
  }
}