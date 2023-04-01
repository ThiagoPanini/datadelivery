/* --------------------------------------------------
FILE: variables.tf @ storage module

CONTEXT: Arquivo de declaração de variáveis a ser 
utilizado nos recursos criados especificamente neste
módulo.

GOAL: O objetivo deste arquivo é concentrar a declaração
de variáveis para toda a construção do ambiente de
armazenamento dos dados e insumos no s3
-------------------------------------------------- */

variable "bucket_names_map" {
  description = "Map with keys containing the name of all buckets to be created in this module"
  type        = map(string)
}

variable "local_data_path" {
  description = "Local path where files to be uplaoded are stored"
  type        = string
}

variable "flag_s3_block_public_access" {
  description = "Flag for blocking all public access for buckets created in this project"
  type        = bool
}
