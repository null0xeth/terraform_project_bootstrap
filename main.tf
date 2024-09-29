locals {
  s3_bucket_name = var.s3_config.bucket != null ? var.s3_config.bucket : var.project_name
  ddb_table_name = var.ddb_config.name != null ? var.ddb_config.name : var.project_name
}

########### S3 BUCKET #####################################################################
module "s3_bucket" {
  source                             = "github.com/null0xeth/terraform_aws_s3_bucket"
  resource_tags                      = var.resource_tags
  provider_aws                       = var.provider_aws
  s3_global_resource_creation_config = var.s3_creation_config
  #s3_bucket                          = var.s3_config
  s3_lifecycle                 = var.s3_lifecycle
  s3_object_lock_configuration = var.s3_object_lock
  s3_server_side_encryption    = var.s3_sse

  s3_bucket = {
    bucket           = local.s3_bucket_name
    enable_logging   = var.s3_config.enable_logging
    force_destroy    = var.s3_config.force_destroy
    object_ownership = var.s3_config.object_ownership
  }
}

########### DYNAMO DB #####################################################################
module "dynamodb_table" {
  source        = "github.com/null0xeth/terraform_aws_dynamodb_table"
  resource_tags = var.resource_tags
  provider_aws  = var.provider_aws
  global        = var.ddb_global
  table_config  = var.ddb_table

  config = {
    name                           = local.ddb_table_name
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
  filename = "${var.root_path}/backend.tf" #"${path.root}/backend.tf.generated"
}

resource "local_file" "s3_stub" {
  content = templatefile("${path.module}/templates/stub.tftpl", {
    aws_region      = var.provider_aws.region
    aws_bucket_name = module.s3_bucket.out["bucket_id"]
    project_name    = var.project_name
  })
  filename = "${var.root_path}/s3_stub.tf"
}
