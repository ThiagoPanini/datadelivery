/* --------------------------------------------------------
FILE: locals.tf

This file handles declaration of locals variables that can
be used along other Terraform files to help users to
organize elements and componentes for all resources to be
deployed in this infrastructure project
-------------------------------------------------------- */

# Defining data sources to help local variables
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

# Defining local variables to be used on the module
locals {
  account_id  = data.aws_caller_identity.current.account_id
  region_name = data.aws_region.current.name

  # Creating a map with bucket names to be deployed
  bucket_names_map = {
    "sor"    = "datadelivery-sor-data-${local.account_id}-${local.region_name}"
    "sot"    = "datadelivery-sot-data-${local.account_id}-${local.region_name}"
    "spec"   = "datadelivery-spec-data-${local.account_id}-${local.region_name}"
    "athena" = "datadelivery-athena-query-results-${local.account_id}-${local.region_name}"
    "glue"   = "datadelivery-glue-assets-${local.account_id}-${local.region_name}"
  }

  # Referencing a policies folder where the JSON files for policies are located
  iam_policies_path = "${path.module}/policy/"

  # If users want to create an IAM role for Glue Crawler, so this variable will consider the ARN of the given role. If not, this variable will hold the ARN string for an existing IAM role identified by its name
  glue_crawler_role_arn = var.create_crawler_role ? aws_iam_role.glue_crawler_role[0].arn : "arn:aws:iam::${local.account_id}:role/${var.crawler_role_name}"

  # Extracting current timestamp and adding a delay
  timestamp_to_run = timeadd(timestamp(), var.delay_to_run_crawler)
}
