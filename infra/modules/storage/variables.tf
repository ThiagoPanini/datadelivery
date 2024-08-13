/* --------------------------------------------------------
FILE: variables.tf @ storage module

Arquivo de variáveis criado para alimentar o submódulo de
storage dentro do projeto datadelivery
-------------------------------------------------------- */

variable "bucket_names_map" {
  description = "Dicionário de definição de todos os nomes de buckets S3 a serem criados na conta AWS alvo. Este dicionário deve possuir chaves identificadoras (ex: 'sor', 'sot', 'spec') cujos valores representam os nomes para os buckets a serem criados para cada contexto identificador. É obrigatório que exista, pelo menos, uma chave que identifique um nome de bucket para armazenar dados brutos (ex: 'sor' ou 'bronze'). Outros identificadores de chave e nome de bucket são opcionais (ex: 'sot', 'spec', 'silver', 'gold'). Ao final de cada valor desse dicionário, processos automáticos do módulo irão adicionar um sufixo definido por '-<region_name>-<account_id>', onde <region_name> identifica o nome da região alvo da chamada e <account_id> o ID da conta AWS alvo da chamada."
  type        = map(string)
}

variable "raw_data_key_on_bucket_names_map" {
  description = "Referência relacionada à chave do dicionário (map) da variável var.bucket_names_map do módulo utilizada para referenciar o bucket usado para armazenar dados brutos (sor, bronze, etc)."
  type        = string
}

variable "flag_block_public_access_from_buckets" {
  description = "Flag booleano para configurar o bloqueio de acesso público aos buckets criados pelo módulo. O valor 'True' indica o bloqueio do acesso público através do recurso Terraform `aws_s3_bucket_public_access_block`."
  type        = bool
}

variable "flag_upload_public_datasets" {
  description = "Flag que habilita o upload automático de datasets públicos previamente presentes e disponibilizados na estrutura interna do módulo."
  type        = bool
}

variable "flag_upload_custom_datasets" {
  description = "Flag que habilita o upload de datasets customizados fornecidos pelo próprio usuário no bucket criado pelo módulo datadelivery para o armazenamento de dados brutos (sor, bronze, etc). Se var.flag_upload_custom_datasets=true, então o usuário deve fornecer um caminho de diretório onde os dados estão armazenados através da variável var.custom_datasets_dir."
  type        = bool
}

variable "custom_dataset_dir" {
  description = "Diretório onde os arquivos dos datasets do usuário estão armazenados para que estes sejam coletados e enviados para o bucket de armazenamento de dados brutos no S3. É obrigatório que o usuário forneça um valor para esta variável caso var.flag_upload_custom_datasets=true."
  type        = string
}
