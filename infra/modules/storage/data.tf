/* --------------------------------------------------------
ARQUIVO: data.tf @ storage module

Arquivo criado para centralizar todas as definições de
data sources do Terraform definidos para facilitar a
declaração e configuração de recursos ao longo do módulo
-------------------------------------------------------- */

# Definindo data sources para coleta de ID da conta e nome da regiao
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
