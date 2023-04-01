/* --------------------------------------------------------
FILE: variables.tf @ root module

This file contains all variables used on this IaC project.
As much as the project is divided in different modules,
this variables.tf file from root module is where users
can set all variables used on all other modules.
-------------------------------------------------------- */

variable "aws_provider_config" {
  description = "Providing a local file where AWS credentials are stored"
  type        = map(any)
  default = {
    "config"      = ["~/.aws/config"]
    "credentials" = ["~/.aws/credentials"]
  }
}

/* --------------------------------------------------------
---------------- VARIABLES: storage module ----------------
-------------------------------------------------------- */

variable "local_data_path" {
  description = "Local path where files to be uplaoded are stored"
  type        = string
  default     = "./data/"
}

variable "flag_s3_block_public_access" {
  description = "Flag for blocking all public access for buckets created in this project"
  type        = bool
  default     = true
}

variable "datasets_to_upload" {
  description = "Map for managing which datasets will be uploaded to S3"
  type        = map(bool)
  default = {
    "bike_data"         = true
    "br_ecommerce"      = true
    "tbl_activity_data" = true
    "tbl_airbnb"        = true
    "tbl_iot_devices"   = true
  }
}

/* --------------------------------------------------------
---------------- VARIABLES: catalog module ----------------
-------------------------------------------------------- */

variable "glue_databases_name" {
  description = "List of database names for storing Glue catalog tables"
  type        = list(string)
  default     = ["db_terracatalog_sor", "db_terracatalog_sot", "db_terracatalog_spec"]
}
