/* --------------------------------------------------------
FILE: main.tf @ root module

Main Terraform file where all submodules are called in
order to deploy the infrastructure provided as code. This
file handles the calls for the following modules:

- [x] storage
- [ ] iam
- [ ] catalog
-------------------------------------------------------- */

# Criando recursos de armazenamento via módulo storage
module "storage" {
  source = "./infra/modules/storage"

  bucket_names_map                      = var.bucket_names_map
  raw_data_key_on_bucket_names_map      = var.raw_data_key_on_bucket_names_map
  flag_block_public_access_from_buckets = var.flag_block_public_access_from_buckets
  flag_upload_public_datasets           = var.flag_upload_public_datasets
}

# Criando recursos de gerenciamento de permissões via módulo iam
module "iam" {
  source = "./infra/modules/iam"

  flag_create_glue_crawler = var.flag_create_glue_crawler
  sor_bucket_name          = module.storage.bucket_names_map["sor"]

  depends_on = [
    module.storage
  ]
}
