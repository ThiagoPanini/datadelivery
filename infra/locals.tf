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
}
