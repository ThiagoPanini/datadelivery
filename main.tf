/* --------------------------------------------------------
FILE: main.tf @ root module

Main Terraform file where all submodules are called in
order to deploy the infrastructure provided as code. This
file handles the calls for the following modules:

- [x] storage
- [x] iam
- [x] catalog
-------------------------------------------------------- */

# Criando recursos de armazenamento via módulo storage
module "storage" {
  source = "./infra/modules/storage"
}
