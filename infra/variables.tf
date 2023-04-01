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
  default     = "../data/"
}

variable "flag_s3_block_public_access" {
  description = "Flag for blocking all public access for buckets created in this project"
  type        = bool
  default     = true
}
