########### S3 BUCKET #####################################################################
module "s3_bucket" {
  source                             = "github.com/null0xeth/terraform_aws_s3_bucket"
  resource_tags                      = var.resource_tags
  provider_aws                       = var.provider_aws
  s3_global_resource_creation_config = var.s3_creation_config
  s3_bucket                          = var.s3_config
  s3_lifecycle                       = var.s3_lifecycle
  s3_object_lock_configuration       = var.s3_object_lock
  s3_server_side_encryption          = var.s3_sse
}

########### DYNAMO DB #####################################################################
module "dynamodb_table" {
  source        = "github.com/null0xeth/terraform_aws_dynamodb_table"
  resource_tags = var.resource_tags
  provider_aws  = var.provider_aws
  global        = var.ddb_global
  table_config  = var.ddb_table

  config = {
    name                           = var.ddb_config.name
    server_side_encryption_enabled = var.ddb_config.sse
    kms_key_arn                    = module.s3_bucket.out["kms_key_arn"]
    read_capacity_units            = var.ddb_config.rcu
    write_capacity_units           = var.ddb_config.wcu
  }
}

resource "local_file" "tf_backend" {
  content = templatefile("${path.module}/templates/backend.tftpl", {
    aws_region      = var.provider_aws.region
    aws_bucket_name = module.s3_bucket.out["bucket_id"]
    project_name    = var.project_name
    ddb_table       = module.dynamodb_table.output["id"]
  })
  filename = "${path.root}/backend.tf.generated"
}

