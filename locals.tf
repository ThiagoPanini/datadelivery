/* --------------------------------------------------------
FILE: locals.tf

This file handles declaration of locals variables that can
be used along other Terraform files to help users to
organize elements and componentes for all resources to be
deployed in this infrastructure project
-------------------------------------------------------- */

# Defining data sources to help local variables
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Defining local variables to be used on the module
locals {
  account_id  = data.aws_caller_identity.current.account_id
  region_name = data.aws_region.current.name

  # Here it's possible to set all bucket names to be created
  bucket_names_map = {
    "sor"    = "terracatalog-sor-data-${local.account_id}-${local.region_name}"
    "sot"    = "terracatalog-sot-data-${local.account_id}-${local.region_name}"
    "spec"   = "terracatalog-spec-data-${local.account_id}-${local.region_name}"
    "athena" = "terracatalog-athena-query-results-${local.account_id}-${local.region_name}"
    "glue"   = "terracatalog-glue-assets-${local.account_id}-${local.region_name}"
  }

  # Referencing a data folder where the files to be uploaded are located
  data_path = "${path.module}/data/"

  # Referencing a policies folder where the JSON files for policies are located
  iam_policies_path = "${path.module}/policy/"

  # Extracting current timestamp and adding a delay
  timestamp_to_run = timeadd(timestamp(), var.delay_to_run_crawler)

  # Getting date information
  cron_day    = formatdate("D", local.timestamp_to_run)
  cron_month  = formatdate("M", local.timestamp_to_run)
  cron_year   = formatdate("YYYY", local.timestamp_to_run)
  cron_hour   = formatdate("h", local.timestamp_to_run)
  cron_minute = formatdate("m", local.timestamp_to_run)

  # Building a cron expression for Glue Crawler to run 10 minutes after infrastructure deploy
  crawler_cron_expr = "cron(${local.cron_minute} ${local.cron_hour} ${local.cron_day} ${local.cron_month} ? ${local.cron_year})"
}
