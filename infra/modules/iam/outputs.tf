/* --------------------------------------------------------
ARQUIVO: outputs.tf @ iam module

Arquivo Terraform responsável por consolidar todas as saídas
expostas pelo submódulo iam do projeto datadelivery.
-------------------------------------------------------- */

output "glue_crawler_role_arn" {
  description = "ARN de role criada para execução de um Glue Crawler"
  value       = aws_iam_role.datadelivery-glue-crawler-role[0].arn
}
