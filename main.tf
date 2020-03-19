terraform {
  backend "s3" {
    bucket         = "terraform-policy-manager"
    key            = "default/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-policy-manager"
    encrypt        = true
  }
}

provider "aws" {
  version = "~> 2"
  region  = "us-east-1"
}

module "my_managed_account" {
  source   = "./modules/managed_account"
  role_arn = "arn:aws:iam::389981984738:role/terraform-policy-manager"
}

module "my_managed_account2" {
  source   = "./modules/managed_account"
  role_arn = "arn:aws:iam::675587008098:role/terraform-policy-manager"
}
