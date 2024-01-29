/* --------------------------------------------------------
FILE: variables.tf @ root module

This file contains all variables used on this IaC project.
As much as the project is divided in different modules,
this variables.tf file from root module is where users
can set all variables used on all other modules.
-------------------------------------------------------- */

variable "upload_custom_data" {
  description = "Flag that enables users to upload their own data files within datadelivery in order to explore custom datasets for special needs. If this variable is set as true, everything under the var.custom_data_dir will be uploaded in the datadeliverie's SoR bucket"
  type        = bool
  default     = false
}

variable "upload_module_data" {
  description = "Flag that enables users to upload and catalog public datasets already provided within the module"
  type        = bool
  default     = true
}


/* --------------------------------------------------------
---------------- VARIABLES: storage module ----------------
-------------------------------------------------------- */

variable "custom_data_dir" {
  description = "Directory where data files are stored when calling datadelivery in 'personal' mode"
  type        = string
  default     = "data/"
}

variable "flag_s3_block_public_access" {
  description = "Flag for blocking all public access for buckets created in this project"
  type        = bool
  default     = true
}

/* --------------------------------------------------------
---------------- VARIABLES: iam module ----------------
-------------------------------------------------------- */

variable "create_crawler_role" {
  description = "Flag that configures the module to create a IAM role to be assumed by the Glue Crawler"
  type        = bool
  default     = true
}

variable "crawler_role_name" {
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
