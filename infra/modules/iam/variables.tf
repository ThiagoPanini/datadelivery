/* --------------------------------------------------------
FILE: variables.tf @ iam module

Arquivo de variáveis criado para alimentar o submódulo de
iam dentro do projeto datadelivery
-------------------------------------------------------- */

variable "flag_create_glue_crawler" {
  description = "Flag booleano para habilitar a criação de recursos IAM (policies e roles) relacionados a execução de um Glue Crawler pré configurado pelo no módulo datadelivery."
  type        = bool
}

variable "sor_bucket_name" {
  description = "Nome de referência do bucket SoR criado no módulo storage para armazenamento de dados brutos. Esta variável é utilizada na configuração de permissões específicas em policy IAM criada para um eventual crawler do Glue."
  type        = string
}
