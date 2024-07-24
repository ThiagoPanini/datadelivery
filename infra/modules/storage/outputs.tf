/* --------------------------------------------------------
ARQUIVO: outputs.tf @ storage module

Arquivo Terraform responsável por consolidar todas as saídas
expostas pelo submódulo storage do projeto datadelivery.
-------------------------------------------------------- */

output "bucket_names_map" {
  description = "Dicionário (map) contendo o nome de todos os buckets S3 criados na conta AWS alvo"
  value       = local.bucket_names_map
}
