/* --------------------------------------------------------
FILE: iam.tf

This file handles the declaration of Terraform resources
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
  for_each = var.create_crawler_role ? fileset(local.iam_policies_path, "*.json") : []
  name     = split(".", each.value)[0]
  policy   = file("${local.iam_policies_path}/${each.value}")
}

# Creating role for Glue Crawler
resource "aws_iam_role" "glue_crawler_role" {
  count              = var.create_crawler_role ? 1 : 0
  name               = var.crawler_role_name
  assume_role_policy = data.aws_iam_policy_document.glue_trust.json
  managed_policy_arns = concat(
    [for p in aws_iam_policy.glue_policies : p.arn],
    ["arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"]
  )
}
