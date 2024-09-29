variable "project_name" {
  type        = string
  default     = "Cluckygang"
  description = "Name of the project using this module"
}

variable "create_s3_stub" {
  type        = bool
  default     = false
  description = "Whether to create a S3 connection stub"
}

variable "stub_path" {
  type        = string
  default     = null
  description = "Path where the s3 stub will be saved"
}

variable "resource_tags" {
  description = "List of resource tags to be added to all created resources"
  type        = map(string)
  default = {
    managed_by = "terraform"
  }
}

variable "provider_aws" {
  description = "Configuration passed to the Hashicorp/aws provider"
  default     = {}
  type = object({
    region = optional(string, "eu-west-1")
  })
}

variable "s3_config" {
  type = object({
    bucket           = optional(string, "clucker-bucket")
    enable_logging   = optional(bool, false)
    force_destroy    = optional(bool, true)
    object_ownership = optional(string, "BucketOwnerPreferred")
  })
  description = "Configure which child-resources will be created for the S3 bucket"
  default     = {}
}

variable "s3_creation_config" {
  type = object({
    append_random_id      = optional(bool, true)
    create_bucket         = optional(bool, true)
    create_kms_key        = optional(bool, true)
    create_bucket_policy  = optional(bool, true)
    create_kms_key_policy = optional(bool, true)
  })
  description = "Configure which resources will be created by this module"
  default     = {}
}

variable "s3_lifecycle" {
  type        = any
  description = "Configure S3 bucket lifecycle rules"
  default     = {}
}

variable "s3_object_lock" {
  type        = any
  description = "Configure S3 bucket object locking"
  default     = {}
}

variable "s3_sse" {
  type        = any
  description = "Configure S3 Bucket server-side encryption"
  default     = {}
}

variable "ddb_global" {
  type = object({
    append_random_id = optional(bool, true)
    enable_policy    = optional(bool, false)
    #resource_policy_enabled = optional(bool, false)
    resource_policy = optional(any)
  })
  default = {}
}

variable "ddb_config" {
  default = {}
  type = object({
    name = optional(string, "terraform-lock")
    sse  = optional(bool, true)
    rcu  = optional(number, 5)
    wcu  = optional(number, 5)
  })
}

variable "ddb_table" {
  default = {}
  type = object({
    attribute_name     = optional(string, "LockID")
    attribute_type     = optional(string, "S")
    create             = optional(bool, true)
    table_class        = optional(string, "STANDARD")
    ttl_enabled        = optional(bool, false)
    ttl_attribute_name = optional(string, "TimeToExist")
    hash_key           = optional(string, "LockID")
    range_key          = optional(string)
  })
  description = "Name of the DynamoDB table"
}

## OLD
# variable "s3" {
#   description = "Configuration of the S3 bucket where we will store remote state."
#   type = object({
#     bucket_acl_policy = optional(bool)
#     bucket_name       = optional(string)
#     bucket_versioning = optional(string)
#     bucket_key        = optional(string, "terraform/stacks/by-id/bucket/terraform.tfstate")
#     bucket_default_retention = optional(object({
#       mode = optional(string)
#       days = optional(number)
#     }))
#     dynamodb_table       = optional(string)
#     enable_object_lock   = optional(bool)
#     enable_encryption    = optional(bool)
#     force_destroy_bucket = optional(bool)
#   })
# }

# variable "kms" {
#   description = "Configuration for the KMS key"
#   type = object({
#     create_key       = optional(bool)
#     key_desc         = optional(string)
#     enable_rotation  = optional(bool)
#     deletion_in_days = optional(number)
#   })
# }

# variable "dynamodb" {
#   type = object({
#     create_table         = optional(bool)
#     table_name           = optional(string)
#     table_hash_key       = optional(string)
#     table_hash_key_type  = optional(string)
#     read_capacity_units  = optional(number)
#     write_capacity_units = optional(number)

#   })
#   description = "Name of the DynamoDB table"
# }


