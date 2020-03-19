provider "aws" {
  version = "~> 2"
  region  = "us-east-1"
}

module "my_managed_account" {
  source      = "./modules/managed_account"
  #role_arn    = "arn:aws:iam::389981984738:role/OrganizationAccountAccessRole"
  role_arn = "arn:aws:iam::389981984738:role/terraform-policy-manager"
  name_prefix = "aws-sentinal-"
}
