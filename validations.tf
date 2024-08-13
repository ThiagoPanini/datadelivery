/* --------------------------------------------------------
FILE: validations.tf @ root module

Arquivo Terraform criado especificamente para centralizar
validações compostas que consideram múltiplas variáveis
como entrada. Em outras palavras, este arquivo funciona
como uma alternativa customizada para implementar
verificações de valores de variáveis fornecidas pelo usuário
considerando condicionais que envolvem duas ou mais
variáveis.

O Terraform possui uma abstração de validação definida
pelo bloco "validation" dentro da definição da própria
variável, como por exemplo:

variable "some_variable" {
  description = "Some variable description"
  type        = some_variable_type

  validation {
    condition     = boolean_condition
    error_message = "Some error message"
  }
}

Entretanto, este bloco acima funciona apenas quando a
validação de condição a ser estabelecida (condição booleana
no bloco condition) utiliza a própria variável como entrada.
Ou seja, `boolean_condition` poderia ser qualquer expressão
booleana que utiliza a própria variável var.some_variable
como entrada. Caso houvesse outra variável que precisasse
ser validada em conjunto, este bloco não poderia ser
utilizado.

Dessa forma, uma maneira de realizar validações condicionais
de preenchimento de variáveis no Terraform utilizando duas
ou mais variáveis na mesma condição é através de um
workaround utilizando variáveis locais (locals{}).

Fontes:
https://github.com/hashicorp/terraform/issues/25609,
https://github.com/hashicorp/terraform/issues/25609#issuecomment-1057614400
-------------------------------------------------------- */

locals {
  # Validando preenchimento de var.custom_dataset_dir quando var.flag_upload_custom_datasets é igual a true
  validate_custom_dataset_dir = (
    var.flag_upload_custom_datasets == true && var.custom_dataset_dir == " " ?
    tobool("O módulo foi configurado para realizar o upload de datasets próprios do usuário (var.flag_upload_custom_datasets = true), porém nenhum diretório local válido foi fornecido pelo usuário para coletar e subir os arquivos (var.custom_dataset_dir = ' ')")
    : true
  )
}
