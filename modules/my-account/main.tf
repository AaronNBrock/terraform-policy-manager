provider "aws" {
  alias   = "new_account"
  version = "~> 2"
  region  = "us-east-1"
  assume_role {
    role_arn = var.role_arn
  }
}

resource "aws_s3_bucket" "b" {
  provider = aws.new_account
  bucket   = "my-tf-test-bucket-potato"
}
