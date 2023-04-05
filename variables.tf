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
---------------- VARIABLES: iam module ----------------
-------------------------------------------------------- */

variable "iam_glue_crawler_role_name" {
  description = "Role name for Glue Crawler IAM role"
  type        = string
  default     = "datadelivery-glue-crawler-role"
}


/* --------------------------------------------------------
---------------- VARIABLES: catalog module ----------------
-------------------------------------------------------- */

variable "glue_db_names" {
  description = "List of database names for storing Glue catalog tables"
  type        = map(string)
  default = {
    "sor"  = "db_datadelivery_sor",
    "sot"  = "db_datadelivery_sot",
    "spec" = "db_datadelivery_spec"
  }
}

variable "delay_to_run_crawler" {
  description = "A string representation to be considered as a time difference between the time of infrastructure deploy and the time to run the Glue Crawler"
  type        = string
  default     = "2m"
}
