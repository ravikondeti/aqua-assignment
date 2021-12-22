output "terraform_remote_state_bucket_name" {
  description = "Terraform remote state bucket name"
  value       = module.s3-bucket.s3_bucket_id
}

output "terraform_inframodule_state_lock_table_name" {
  description = "Terraform infra module state lock table name"
  value = {for k, v in module.dynamodb_table: k => v.dynamodb_table_id}
}

