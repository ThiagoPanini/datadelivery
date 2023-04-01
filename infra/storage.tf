/* --------------------------------------------------------
FILE: storage.tf

This file handles operations on storage context and its
actions are based on:
  - Creating s3 buckets
  - Configuring public access for buckets
  - Uploading datasets based on its repository location
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
}

# Creating all s3 buckets
resource "aws_s3_bucket" "this" {
  for_each      = local.bucket_names_map
  bucket        = each.value
  force_destroy = true
}

# Blocking all public access dor buckets
resource "aws_s3_bucket_public_access_block" "all_private" {
  for_each = var.flag_s3_block_public_access ? local.bucket_names_map : {}
  bucket   = aws_s3_bucket.this[each.key].id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Encrypting buckets
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  for_each = local.bucket_names_map
  bucket   = aws_s3_bucket.this[each.key].bucket
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}

# Adding local files on SoR bucket
resource "aws_s3_object" "data_sources" {
  for_each               = fileset(var.local_data_path, "**")
  bucket                 = aws_s3_bucket.this["sor"].bucket
  key                    = each.value
  source                 = "${var.local_data_path}${each.value}"
  server_side_encryption = "aws:kms"
}
