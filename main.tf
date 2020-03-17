provider "aws" {
  version = "~> 2"
  region  = "us-east-1"
}

data "aws_organizations_organization" "this" {}

resource "aws_organizations_account" "org_account" {
  name  = "Aaron N. Brock"
  email = "aws.child@aaronnbrock.com"
}

module "my_account" {
  source = "./modules/my-account"
  # role_arn = "arn:aws:iam::651576848133:role/OrganizationAccountAccessRole"
  role_arn = "arn:aws:iam::${aws_organizations_account.org_account.id}:role/OrganizationAccountAccessRole"
}

output "accound_id" {
  value = aws_organizations_account.org_account.id
}

output "accound_arn" {
  value = aws_organizations_account.org_account.arn
}
