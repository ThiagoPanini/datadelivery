/* --------------------------------------------------------
FILE: iam.tf

This file handls the declaration of Terraform resources
used to create an IAM role for Glue Crawler to run. It uses
the infra/policy/ folder to read the JSON files to create
all policies needed.
-------------------------------------------------------- */

# Defining the truste policy for Glue service
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
resource "aws_iam_role" "glue_crawler_role" {
  name               = var.iam_glue_crawler_role_name
  assume_role_policy = data.aws_iam_policy_document.glue_trust.json
  managed_policy_arns = concat(
    [for p in aws_iam_policy.glue_policies : p.arn],
    ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"]
  )
}
