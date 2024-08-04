/* --------------------------------------------------------
FILE: crawler.tf @ catalog module

Arquivo Terraform criado para gerenciar a declaração de
um Glue Crawler previamente configurado para verificar e
criar abelas no Glue Data Catalog conforme parâmetros
fornecidos pelo usuário. Recursos deste submódulo:

- Glue Crawler para criação de tabelas no Glue Data Catalog
- Agendamento do Glue Crawler via expressão cron
-------------------------------------------------------- */

# Criando um Glue Crawler para catalogação de dados brutos
resource "aws_glue_crawler" "datadelivery" {
  count = var.flag_create_glue_crawler ? 1 : 0

  name          = "datadelivery-glue-crawler-raw-data"
  database_name = var.glue_databases_names_map[var.raw_data_key_on_databases_names_map]
  role          = var.glue_crawler_role_arn

  s3_target {
    path = "s3://${var.sor_bucket_name}"
  }

  schedule = join("", concat(
    ["cron("],
    ["${formatdate("m", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("h", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("D", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["${formatdate("M", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    ["? "],
    ["${formatdate("YYYY", timeadd(timestamp(), var.delay_to_run_crawler))} "],
    [")"]
  ))

  depends_on = [
    aws_glue_catalog_database.datadelivery_dbs
  ]
}
