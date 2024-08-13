/* --------------------------------------------------------
FILE: main.tf @ root module

Arquivo principal do projeto Terraform no módulo root
responsável por chamar todos os demais submódulos do
projeto, entre eles:

- Módulo storage
- Módulo iam
- Módulo catalog
-------------------------------------------------------- */

# Criando recursos de armazenamento de dados físicos no S3 via módulo storage
module "storage" {
  source = "./infra/modules/storage"

  bucket_names_map                      = var.bucket_names_map
  raw_data_key_on_bucket_names_map      = var.raw_data_key_on_bucket_names_map
  flag_block_public_access_from_buckets = var.flag_block_public_access_from_buckets
  flag_upload_public_datasets           = var.flag_upload_public_datasets
  flag_upload_custom_datasets           = var.flag_upload_custom_datasets
  custom_dataset_dir                    = var.custom_dataset_dir
}

# Criando recursos de gerenciamento de permissões via módulo iam
module "iam" {
  source = "./infra/modules/iam"

  flag_create_glue_crawler = var.flag_create_glue_crawler
  sor_bucket_name          = module.storage.bucket_names_map[var.raw_data_key_on_bucket_names_map]

  depends_on = [
    module.storage
  ]
}

# Criando recursos para armazenamento de dados no Glue Data Catalog via módulo catalog
module "catalog" {
  source = "./infra/modules/catalog"

  flag_create_glue_databases          = var.flag_create_glue_databases
  glue_databases_names_map            = var.glue_databases_names_map
  raw_data_key_on_databases_names_map = var.raw_data_key_on_databases_names_map

  flag_create_glue_crawler = var.flag_create_glue_crawler
  glue_crawler_role_arn    = module.iam.glue_crawler_role_arn
  sor_bucket_name          = module.storage.bucket_names_map[var.raw_data_key_on_databases_names_map]
  delay_to_run_crawler     = var.delay_to_run_crawler

  flag_create_athena_workgroup = var.flag_create_athena_workgroup
  athena_workgroup_name        = var.athena_workgroup_name
  athena_s3_output_bucket_name = module.storage.bucket_names_map[var.athena_output_key_on_bucket_names_map]

  depends_on = [
    module.storage,
    module.iam
  ]
}
