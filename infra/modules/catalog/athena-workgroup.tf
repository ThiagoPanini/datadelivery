/* --------------------------------------------------------
FILE: athena-workgroup.tf @ catalog module

Arquivo Terraform criado para gerenciar a declaração de
um workgroup do Athena

- Workgroup pré configurado do Athena
-------------------------------------------------------- */

resource "aws_athena_workgroup" "datadelivery" {
  count = var.flag_create_athena_workgroup ? 1 : 0

  name          = var.athena_workgroup_name
  force_destroy = true

  configuration {
    result_configuration {
      output_location = "s3://${var.athena_s3_output_bucket_name}"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = data.aws_kms_key.s3.arn
      }
    }
  }

}

