output "out" {
  description = "Resource creation summary"
  value       = module.s3_bucket.info
}

output "info" {
  description = "Remote S3 instructions"
  value       = <<EOT
    In order to configure your remote S3 backend:
      1. Copy `backend.tf.generated` to your terraform root module
      2. Rename the file to `backend.tf`
      3. Run `terraform init -migrate-state`
  EOT
}
# output "bucket" {
#   description = "Map with s3 bucket-specific information"
#   value = zipmap(
#     ["name", "arn"],
#     [
#       element(aws_s3_bucket.terraform-state[*], 0).id,
#       element(aws_s3_bucket.terraform-state[*], 0).arn,
#     ]
#   )
# }

# output "dynamodb" {
#   description = "Map with dynamodb table-specific information"
#   value = zipmap(
#     ["name", "arn"],
#     [element(aws_dynamodb_table.terraform-state[*], 0).id, element(aws_dynamodb_table.terraform-state[*], 0).arn],
#   )
# }

# output "s3_object" {
#   description = "Complete configuration of the S3 bucket created"
#   value = {
#     bucket         = element(aws_s3_bucket.terraform-state[*], 0).id
#     region         = element(aws_s3_bucket.terraform-state[*], 0).region
#     key            = var.s3.bucket_key
#     encrypt        = var.s3.enable_encryption
#     dynamodb_table = element(aws_dynamodb_table.terraform-state[*], 0).id
#   }
# }
