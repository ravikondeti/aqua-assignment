#Region
variable "region" {
  default     = "ap-south-1"
  description = "AWS region"
}

#terraform state bucket name
variable "remote_tfstate_bucket_name" {
    default = "aqua-assignment-remotestate-files"
}

# terraform state lock Dynamo db map variable
variable "tfstate-dynamodb-table" {
  description = "terraform state lock dynamodb table configuration."
  type        = map
  default     = {
    infra-module = {
        name = "aqua-inframodule-remote-tfstate",
        hash_key =  "LockID",
        read_capacity = 2,
        write_capacity = 2,
        attributes = [
            {
            name = "LockID"
            type = "S"
            }
        ],
        tags  =  {
            module = "infra-module"
            Environment = "dev"
        }
    },
    deployment-module = {
        name = "aqua-deploymentmodule-remote-tfstate",
        hash_key =  "LockID",
        read_capacity = 2,
        write_capacity = 2,
        attributes = [
            {
            name = "LockID"
            type = "S"
            }
        ],
        tags  =  {
            module = "deployment-module"
            Environment = "dev"
        }
    }
  }
}



