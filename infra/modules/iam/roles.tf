/* --------------------------------------------------------
FILE: roles.tf @ iam module

Arquivo Terraform criado para gerenciar a declaração de
roles IAM, tais quais:

- Role para execução de Glue Crawler
-------------------------------------------------------- */

/* -------------------------------------------------------
    IAM ROLE: datadelivery-glue-crawler-role
    Role para execução de Glue Crawler
------------------------------------------------------- */

# Definindo role IAM
resource "aws_iam_role" "datadelivery-glue-crawler-role" {
  count = var.flag_create_glue_crawler ? 1 : 0

  name                  = "datadelivery-glue-crawler-role"
  assume_role_policy    = file("${path.module}/trust/datadelivery-trust-glue.json")
  force_detach_policies = true

  managed_policy_arns = [
    aws_iam_policy.datadelivery-glue-crawler-policy[0].arn,
    "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
  ]

  depends_on = [
    data.template_file.datadelivery-glue-crawler-policy,
    aws_iam_policy.datadelivery-glue-crawler-policy
  ]
}
