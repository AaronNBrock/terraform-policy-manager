#
# Provider
#
provider "aws" {
  alias   = "managed_account"
  version = "~> 2"
  region  = "us-east-1"
  assume_role {
    role_arn = var.role_arn
  }
}


module "config_rules" {
  providers = {
    aws = aws.managed_account
  }
  source      = "../config_rules"
  name_prefix = var.name_prefix
  name_suffix = var.name_suffix
}