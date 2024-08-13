/* --------------------------------------------------------
FILE: policies.tf @ iam module

Arquivo Terraform criado para gerenciar a declaração de
policies IAM, tais quais:

- Policy para execução de Glue Crawler
-------------------------------------------------------- */

/* -------------------------------------------------------
    IAM POLICY: datadelivery-glue-crawler-policy
    Policy para execução de Glue Crawler
------------------------------------------------------- */

# Definindo template file para policy
data "template_file" "datadelivery-glue-crawler-policy" {
  count = var.flag_create_glue_crawler ? 1 : 0

  template = file("${path.module}/policy-templates/datadelivery-glue-crawler-policy.json")

  vars = {
    sor_bucket_name = var.sor_bucket_name
  }
}

# Definindo policy
resource "aws_iam_policy" "datadelivery-glue-crawler-policy" {
  count = var.flag_create_glue_crawler ? 1 : 0

  name   = "datadelivery-glue-crawler-policy"
  policy = data.template_file.datadelivery-glue-crawler-policy[0].rendered
}
