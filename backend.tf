terraform {
  backend "s3" {
    region         = "eu-west-1"
    bucket         = "honkfrastructure-rootus"
    key            = "terraform/stacks/by-id/root/terraform.tfstate"
    encrypt        = true
    dynamodb_table = "root-terraform-lock"
  }
}
