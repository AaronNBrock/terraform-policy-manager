terraform {
  required_version = ">= 0.12"
  required_providers {
    aws = ">= 2"
  }
}

#
# Remediation
#
resource "aws_cloudformation_stack" "bucket_versioning_remediation" {
  name       = "${var.name_prefix}bucket-versioning-remediation${var.name_suffix}"
  depends_on = [var.config_rule, aws_iam_role.bucket_versioning]

  parameters = {
    Automatic            = true
    ConfigRuleName       = var.config_rule.name
    AutomationAssumeRole = aws_iam_role.bucket_versioning.arn
    VersioningState      = var.versioning_enabled ? "Enabled" : "Disabled"
  }

  template_body = file("${path.module}/remediation.json")
}

#
# IAM
#
data "aws_iam_policy_document" "bucket_versioning_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ssm.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "bucket_versioning_attached" {
  statement {
    sid    = "1"
    effect = "Allow"
    actions = [
      "s3:*",
    ]

    resources = [
      "*",
    ]
  }
  statement {
    sid    = "2"
    effect = "Allow"
    actions = [
      "iam:PassRole",
    ]
    resources = [
      aws_iam_role.bucket_versioning.arn
    ]
  }
  statement {
    sid    = "3"
    effect = "Allow"
    actions = [
      "ssm:*"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    sid    = "4"
    effect = "Allow"
    actions = [
      "lambda:InvokeFunction"
    ]
    resources = [
      "arn:aws:lambda:*:*:function:Automation*"
    ]
  }
}

resource "aws_iam_policy" "bucket_versioning_policy" {
  name        = "${var.name_prefix}bucket-versioning-policy${var.name_suffix}"
  description = "A policy for allowing terraform"
  policy      = data.aws_iam_policy_document.bucket_versioning_attached.json
}

resource "aws_iam_role_policy_attachment" "bucket_versioning_attach" {
  role       = aws_iam_role.bucket_versioning.name
  policy_arn = aws_iam_policy.bucket_versioning_policy.arn
}

resource "aws_iam_role" "bucket_versioning" {
  name               = "${var.name_prefix}bucket-versioning-role${var.name_suffix}"
  assume_role_policy = data.aws_iam_policy_document.bucket_versioning_trust.json
}
