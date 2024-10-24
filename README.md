<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                            | Version   |
| --------------------------------------------------------------- | --------- |
| <a name="requirement_aws"></a> [aws](#requirement_aws)          | ~> 5.64.0 |
| <a name="requirement_random"></a> [random](#requirement_random) | 3.6.2     |

## Providers

| Name                                                   | Version |
| ------------------------------------------------------ | ------- |
| <a name="provider_local"></a> [local](#provider_local) | n/a     |

## Modules

| Name                                                                          | Source                                            | Version |
| ----------------------------------------------------------------------------- | ------------------------------------------------- | ------- |
| <a name="module_dynamodb_table"></a> [dynamodb_table](#module_dynamodb_table) | github.com/null0xeth/terraform_aws_dynamodb_table | n/a     |
| <a name="module_s3_bucket"></a> [s3_bucket](#module_s3_bucket)                | github.com/null0xeth/terraform_aws_s3_bucket      | n/a     |

## Resources

| Name                                                                                                        | Type     |
| ----------------------------------------------------------------------------------------------------------- | -------- |
| [local_file.tf_backend](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |

## Inputs

| Name                                                                                    | Description                                                       | Type                                                                                                                                                                                                                                                                                                                                                                               | Default                                         | Required |
| --------------------------------------------------------------------------------------- | ----------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------- | :------: |
| <a name="input_ddb_config"></a> [ddb_config](#input_ddb_config)                         | n/a                                                               | <pre>object({<br> name = optional(string, "terraform-lock")<br> sse = optional(bool, true)<br> rcu = optional(number, 5)<br> wcu = optional(number, 5)<br> })</pre>                                                                                                                                                                                                                | `{}`                                            |    no    |
| <a name="input_ddb_global"></a> [ddb_global](#input_ddb_global)                         | n/a                                                               | <pre>object({<br> append_random_id = optional(bool, true)<br> enable_policy = optional(bool, false)<br> #resource_policy_enabled = optional(bool, false)<br> resource_policy = optional(any)<br> })</pre>                                                                                                                                                                          | `{}`                                            |    no    |
| <a name="input_ddb_table"></a> [ddb_table](#input_ddb_table)                            | Name of the DynamoDB table                                        | <pre>object({<br> attribute_name = optional(string, "LockID")<br> attribute_type = optional(string, "S")<br> create = optional(bool, true)<br> table_class = optional(string, "STANDARD")<br> ttl_enabled = optional(bool, false)<br> ttl_attribute_name = optional(string, "TimeToExist")<br> hash_key = optional(string, "LockID")<br> range_key = optional(string)<br> })</pre> | `{}`                                            |    no    |
| <a name="input_project_name"></a> [project_name](#input_project_name)                   | Name of the project using this module                             | `string`                                                                                                                                                                                                                                                                                                                                                                           | `"Cluckygang"`                                  |    no    |
| <a name="input_provider_aws"></a> [provider_aws](#input_provider_aws)                   | Configuration passed to the Hashicorp/aws provider                | <pre>object({<br> region = optional(string, "eu-west-1")<br> })</pre>                                                                                                                                                                                                                                                                                                              | `{}`                                            |    no    |
| <a name="input_resource_tags"></a> [resource_tags](#input_resource_tags)                | List of resource tags to be added to all created resources        | `map(string)`                                                                                                                                                                                                                                                                                                                                                                      | <pre>{<br> "managed_by": "terraform"<br>}</pre> |    no    |
| <a name="input_s3_config"></a> [s3_config](#input_s3_config)                            | Configure which child-resources will be created for the S3 bucket | <pre>object({<br> bucket = optional(string, "clucker-bucket")<br> enable_logging = optional(bool, false)<br> force_destroy = optional(bool, true)<br> object_ownership = optional(string, "BucketOwnerPreferred")<br> })</pre>                                                                                                                                                     | `{}`                                            |    no    |
| <a name="input_s3_creation_config"></a> [s3_creation_config](#input_s3_creation_config) | Configure which resources will be created by this module          | <pre>object({<br> append_random_id = optional(bool, true)<br> create_bucket = optional(bool, true)<br> create_kms_key = optional(bool, true)<br> create_bucket_policy = optional(bool, true)<br> create_kms_key_policy = optional(bool, true)<br> })</pre>                                                                                                                         | `{}`                                            |    no    |
| <a name="input_s3_lifecycle"></a> [s3_lifecycle](#input_s3_lifecycle)                   | Configure S3 bucket lifecycle rules                               | `any`                                                                                                                                                                                                                                                                                                                                                                              | `{}`                                            |    no    |
| <a name="input_s3_object_lock"></a> [s3_object_lock](#input_s3_object_lock)             | Configure S3 bucket object locking                                | `any`                                                                                                                                                                                                                                                                                                                                                                              | `{}`                                            |    no    |
| <a name="input_s3_sse"></a> [s3_sse](#input_s3_sse)                                     | Configure S3 Bucket server-side encryption                        | `any`                                                                                                                                                                                                                                                                                                                                                                              | `{}`                                            |    no    |

## Outputs

| Name                                            | Description               |
| ----------------------------------------------- | ------------------------- |
| <a name="output_info"></a> [info](#output_info) | Remote S3 instructions    |
| <a name="output_out"></a> [out](#output_out)    | Resource creation summary |

#

<!-- END_TF_DOCS -->
