/* --------------------------------------------------------
FILE: main.tf @ catalog module

This is the main Terraform file for iam module and it's
responsible for defining policies and roles to be used on
Glue crawler process do catalog data
-------------------------------------------------------- */

# Collecting data sources
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "glue_trust" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

# Creating IAM policies using JSON files in the module
resource "aws_iam_policy" "glue_policies" {
  for_each = fileset(var.iam_policies_path, "**")
  name     = split(".", each.value)[0]
  policy   = file("${var.iam_policies_path}/${each.value}")
}

# Creating role for Glue Crawler
resource "aws_iam_role" "glue_role" {
  name               = var.iam_glue_role_name
  assume_role_policy = data.aws_iam_policy_document.glue_trust.json
  managed_policy_arns = [
    for p in aws_iam_policy.glue_policies : p.arn
  ]
}


