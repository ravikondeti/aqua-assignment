# Terraform state lock dynamo db tables
module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "1.1.0"

  for_each = var.tfstate-dynamodb-table
  name = each.value.name
  hash_key =  each.value.hash_key
  read_capacity = each.value.read_capacity
  write_capacity = each.value.write_capacity
  attributes = each.value.attributes     
  tags  =  each.value.tags  
 
}

# terraform state store bucket
module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "2.11.1"
  bucket = var.remote_tfstate_bucket_name

  versioning = {
    enabled = true
  }
  server_side_encryption_configuration = {
        rule = {
            apply_server_side_encryption_by_default = {
                kms_master_key_id = "arn:aws:kms:ap-south-1:314301073530:key/f864bf3f-38c5-4422-9934-d598ff8fcab7"
                sse_algorithm     = "aws:kms"
            }
        }
    }

  tags = {
    Name        = local.name
    Environment = local.environment
  }
}


