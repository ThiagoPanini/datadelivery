/* --------------------------------------------------------
FILE: storage.tf

This file handles operations on storage context and its
actions are based on:
  - Creating s3 buckets
  - Configuring public access for buckets
  - Uploading datasets based on its repository location
-------------------------------------------------------- */

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
