/* --------------------------------------------------------
ARQUIVO: data.tf @ catalog module

Arquivo criado para centralizar todas as definições de
data sources do Terraform criados para facilitar a
declaração e configuração de recursos ao longo do módulo
-------------------------------------------------------- */

# Definindo data sources para coleta automática de chave KMS do S3
data "aws_kms_key" "s3" {
  key_id = "alias/aws/s3"
}
