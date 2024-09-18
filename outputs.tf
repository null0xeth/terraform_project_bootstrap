output "summary" {
  description = "Resource creation summary"
  value       = module.s3_bucket.info
}

output "s3_out" {
  value = module.s3_bucket.out
}

output "ddb_out" {
  value = module.dynamodb_table.output
}

output "info" {
  description = "Remote S3 instructions"
  value       = <<EOT
    In order to configure your remote S3 backend:
      1. Copy `backend.tf.generated` to your terraform root module
      2. Rename the file to `backend.tf`
      3. Run `terraform init -migrate-state`
      4. Reference the `data.terraform_remote_state.bootstrap` to access the bootstrap outputs
  EOT
}
