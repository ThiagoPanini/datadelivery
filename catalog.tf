/* --------------------------------------------------------
FILE: main.tf @ catalog module

This is the main Terraform file for catalog module and it's
responsible for defining the best way to take the raw files
on S3 and catalog it on Data Catalog. Furthermore, this
module defines an Athena workgroup for helping users to
query cataloged data.
-------------------------------------------------------- */

# Collecting data sources
data "aws_kms_key" "s3" {
  key_id = "alias/aws/s3"
}

# Creating Glue databases on Data Catalog
resource "aws_glue_catalog_database" "mesh" {
  for_each    = var.glue_db_names
  name        = each.value
  description = "Database ${each.value} for storing tables in this specific layer"
}

# Defining an Athena preconfigured workgroup
resource "aws_athena_workgroup" "analytics" {
  name          = "datadelivery-workgroup"
  force_destroy = true

  configuration {
    result_configuration {
      output_location = "s3://${local.bucket_names_map["athena"]}"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = data.aws_kms_key.s3.arn
      }
    }
  }
}

# Defining a Glue Crawler
resource "aws_glue_crawler" "sor" {
  database_name = var.glue_db_names["sor"]
  name          = "datadelivery-glue-crawler-sor"
  role          = local.glue_crawler_role_arn

  s3_target {
    path = "s3://${local.bucket_names_map["sor"]}"
  }

  schedule = join("", concat(
    ["cron("],
    ["${formatdate("m", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("h", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("D", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("M", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["? "],
    ["${formatdate("YYYY", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    [")"]
  ))

  depends_on = [
    aws_s3_object.module_files,
    aws_s3_object.custom_files,
    aws_iam_policy.glue_policies,
    aws_iam_role.glue_crawler_role
  ]
}
