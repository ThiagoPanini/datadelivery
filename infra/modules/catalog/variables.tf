/* --------------------------------------------------------
FILE: variables.tf @ catalog module

Arquivo de variáveis criado para alimentar o submódulo de
catalog dentro do projeto datadelivery
-------------------------------------------------------- */

variable "flag_create_glue_databases" {
  description = "Flag booleano para habilitar a criação de databases no Glue Data Catalog para armazenar os resultados do processo de execução do Glue Crawler."
  type        = bool
}

variable "glue_databases_names_map" {
  description = "Dicionário de definição de todos os nomes de databases a serem criados na conta AWS alvo. Este dicionário deve possuir chaves identificadoras (ex: 'sor', 'sot', 'spec') cujos valores representam os nomes para os databases a serem criados para cada contexto identificador. É obrigatório que exista, pelo menos, uma chave que identifique um nome de dadatabase para armazenar dados brutos (ex: 'sor' ou 'bronze'). Outros identificadores de chave e nome de bucket são opcionais (ex: 'sot', 'spec', 'silver', 'gold')."
  type        = map(string)
}

variable "raw_data_key_on_databases_names_map" {
  description = "Referência relacionada à chave do dicionário (map) da variável var.glue_databases_names_map do módulo utilizada para referenciar o database usado para armazenar dados brutos (sor, bronze, etc)."
  type        = string
}

variable "flag_create_glue_crawler" {
  description = "Flag booleano para habilitar a criação de um Glue Crawler para armazenar tabelas no Glue Data Catalog."
  type        = bool
}

variable "glue_crawler_role_arn" {
  description = "ARN de role para execução de um Glue Crawler"
  type        = string
}

variable "sor_bucket_name" {
  description = "Nome de referência do bucket SoR criado no módulo storage para armazenamento de dados brutos. Esta variável é utilizada na configuração de um target no S3 para o Glue Crawler."
  type        = string
}

variable "delay_to_run_crawler" {
  description = "Referência de tempo em segundos (s), minutos (m) ou horas (h) representando o delay para execução do Glue Crawler após a execução do módulo e implantação dos recursos. Por exemplo, var.delay_to_run_crawler = '2m' indica que o Glue Crawler será executado 2 minutos após a implantação dos recursos do módulo datadelivery."
  type        = string
}

variable "flag_create_athena_workgroup" {
  description = "Flag booleano para habilitar a criação de um workgroup pré configurado do Athena para permitir a execução de consultas."
  type        = bool
}

variable "athena_workgroup_name" {
  description = "Nome para workgroup do Athena criado pelo módulo datadelivery"
  type        = string
}

variable "athena_s3_output_bucket_name" {
  description = "Referência de bucket S3 para armazenamento de resultados de consultas do Athena"
  type        = string
}
