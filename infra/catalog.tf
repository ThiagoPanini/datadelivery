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
resource "aws_glue_catalog_database" "databases" {
  for_each    = toset(var.glue_databases_name)
  name        = each.value
  description = "Database ${each.value} for storing tables in this specific layer"
}

# Defining an Athena preconfigured workgroup
resource "aws_athena_workgroup" "analytics" {
  name          = "terracatalog-workgroup"
  force_destroy = true

  configuration {
    result_configuration {
      output_location = aws_s3_bucket.this["athena"].bucket

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = data.aws_kms_key.s3.arn
      }
    }
  }
}
