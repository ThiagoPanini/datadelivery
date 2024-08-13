/* --------------------------------------------------------
FILE: databases.tf @ catalog module

Arquivo Terraform criado para gerenciar a declaração de
databases no Glue para eventualmente armazenar tabelas
obtidas através da execução de um Glue Crawler
eventualmente criado via datadeliery.

- Databases para as camadas SoR, SoT, Spec
-------------------------------------------------------- */

# Criando databases no Glue Data Catalog para armazenamento de tabelas
resource "aws_glue_catalog_database" "datadelivery_dbs" {
  for_each = var.flag_create_glue_databases ? var.glue_databases_names_map : {}

  name        = each.value
  description = "Database criado para armazenar tabelas da camada ${upper(each.key)}"
}
