/* --------------------------------------------------------
FILE: variables.tf @ catalog module

This file contains variables used on the catalog module and
it can be used for structuring specific informations
required for module operation.
-------------------------------------------------------- */

variable "glue_databases_name" {
  description = "Database name for storing Glue catalog tables"
  type        = list(string)
}

variable "athena_output_location" {
  description = "S3 bucket URI created for storing athena query results"
  type        = string
}
