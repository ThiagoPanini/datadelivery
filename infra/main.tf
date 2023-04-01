/* --------------------------------------------------------
FILE: main.tf @ root module

This is main Terraform file from the root module.
It contains all other modules calls with all
infrastructure needed to deploy the project.
The modules are:

- ./modules/storage
- ./modules/catalog
- ./modules/iam
- ./modules/glue

Details about each module can be found on each
one's main.tf file.
-------------------------------------------------------- */

# Defining data sources to help local variables
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}


/* --------------------------------------------------------
---------------- TERRAFORM MODULE: storage ----------------
      Creating storage resources on the AWS account
-------------------------------------------------------- */

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

# Calling the module
module "storage" {
  source = "./modules/storage"

  bucket_names_map            = local.bucket_names_map
  local_data_path             = var.local_data_path
  flag_s3_block_public_access = var.flag_s3_block_public_access
}


/* --------------------------------------------------------
---------------- TERRAFORM MODULE: catalog ----------------
      Preparing the Data Catalog with local datasets
-------------------------------------------------------- */

# Calling the module
module "catalog" {
  source = "./modules/catalog"

  glue_databases_name    = var.glue_databases_name
  athena_output_location = "s3://${module.storage.bucket_name_athena}"

  depends_on = [
    module.storage
  ]
}
