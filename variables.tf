/* --------------------------------------------------------
FILE: variables.tf @ root module

Arquivo de variáveis criado com todas as variáveis e
parâmetros aceitos pelos submódulos do módulo datadelivery
-------------------------------------------------------- */

/* -------------------------------------------------------
    VARIABLES: storage
    Variáveis aceitas pelo módulo storage
------------------------------------------------------- */

variable "bucket_names_map" {
  description = "Dicionário de definição de todos os nomes de buckets a serem criados na conta AWS alvo. Este dicionário deve possuir chaves identificadoras (ex: 'sor', 'sot', 'spec') cujos valores representam os nomes para os buckets a serem criados para cada contexto identificador. E obrigatório que exista, pelo menos, uma chave identificadora definida como 'sor' com o respectivo nome de bucket para armazenar dados na camada SoR. Qualquer outro identificador de chave e nome de bucket é opcional. Ao final de cada valor desse dicionário, processos automáticos do módulo irão adicionar um sufixo definido por '-<region_name>-<account_id>', onde <region_name> identifica o nome da região alvo da chamada e <account_id> o ID da conta AWS alvo da chamada."
  type        = map(string)
  default = {
    "sor"    = "datadelivery-sor"
    "sot"    = "datadelivery-sot"
    "spec"   = "datadelivery-spec"
    "athena" = "datadelivery-athena-query-results"
    "glue"   = "datadelivery-glue-assets"
    "temp"   = "datadelivery-temp"
  }
}

variable "raw_data_key_on_bucket_names_map" {
  description = "Referência relacionada à chave do dicionário (map) da variável var.bucket_names_map do módulo utilizada para referenciar o bucket usado para armazenar dados brutos (sor, bronze, etc)."
  type        = string
  default     = "sor"
}

variable "flag_block_public_access_from_buckets" {
  description = "Flag booleano para configurar o bloqueio de acesso público aos buckets criados pelo módulo. O valor 'True' indica o bloqueio do acesso público através do recurso Terraform `aws_s3_bucket_public_access_block`."
  type        = bool
  default     = true
}

variable "flag_upload_public_datasets" {
  description = "Flag que habilita o upload automático de datasets públicos previamente presentes e disponibilizados na estrutura interna do módulo."
  type        = bool
  default     = true
}


/* -------------------------------------------------------
    VARIABLES: iam e catalog
    Variáveis aceitas pelos módulos iam e catalog
------------------------------------------------------- */

variable "flag_create_glue_crawler" {
  description = "Flag booleano para habilitar a criação de recursos IAM (policies e roles) relacionados a execução de um Glue Crawler pré configurado pelo no módulo datadelivery."
  type        = bool
  default     = true
}
