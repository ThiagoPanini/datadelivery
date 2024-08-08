# Toolkit de Exploração de Dados na AWS

<div align="center">
    <br><img src="https://github.com/ThiagoPanini/datadelivery/blob/v1.0.x/docs/_assets/imgs/logo/logo-com-nome.png?raw=true" width=280 alt="datadelivery-logo">
</div>

<div align="center">

  <a href="https://www.terraform.io/">
    <img src="https://img.shields.io/badge/terraform-grey?style=for-the-badge&logo=terraform&logoColor=B252D0">
  </a>

  <a href="https://www.mkdocs.org/">
    <img src="https://img.shields.io/badge/mkdocs-grey?style=for-the-badge&logo=markdown&logoColor=B252D0">
  </a>

  <a href="https://readthedocs.org/">
    <img src="https://img.shields.io/badge/readthedocs-grey?style=for-the-badge&logo=readthedocs&logoColor=B252D0">
  </a>

  <a href="https://github.com/">
    <img src="https://img.shields.io/badge/github-grey?style=for-the-badge&logo=github&logoColor=B252D0">
  </a>

</div>

## Visão Geral

O `datadelivery` é um módulo [Terraform](https://www.terraform.io/) que permite com que seus usuários criem recursos de infraestrutura em suas respectivas contas AWS visando aprimorar os primeiros passos na **exploração de dados** utilizando serviços de Analytics. Isto é feito através de processos como:

- 🪣 Criação de buckets S3 seguindo uma [arquitetura Data Mesh](https://www.datamesh-architecture.com/) ou [arquitetura medalhão](https://medium.com/@junshan0/medallion-architecture-what-why-and-how-ce07421ef06f)
- 🎲 Upload automático de datasets públicos em bucket S3
- 📦 Upload opcional de datasets customizados fornecidos pelo usuário
- ⏳ Agendamento automático de um Glue Crawler para criação de tabelas para os datasets
- 🔒 Criação de *policies* e *roles* IAM para execução do Glue Crawler
- 📈 Criação de um *workgroup* do Athena para facilitar a execução de *queries*

<small>
  :octicons-tools-16:
  **Um ambiente de bolso!** Como um módulo Terraform, todos os recursos proporcionados pelo `datadelivery` podem ser implantados através de um **único comando** (`terraform apply`). Da mesma forma, os usuários podem simplesmente eliminar todos estes recursos sempre que quiserem também com um **único comando** (`terraform destroy`).
</small>

## Pré Requisitos

Para utilizar o `datadelivery`, usuários precisam:
In order to start using `datadelivery`, users will need:

- ☁️ Ter uma [conta AWS](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) disponível para uso
- 🔑 [Acesso programático](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) nessa conta AWS via chaves `access_key_id` e `secret_access_key`
- ⛏ [Terraform](https://www.terraform.io/) instalado

## Chamando o Módulo

Com o ambiente preparado, usuários podem criar um arquivo Terraform de extensão `.tf` e chamar o módulo `datadelivery` no seguinte formato:

```python
# Chamando o módulo datadelivery com as configurações padrão
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

<small>
  :octicons-light-bulb-16:
  **Dica:** se você tem dúvidas sobre como configurar um projeto Terraform para a chamada de módulos, expanda o bloco abaixo para visualizar demonstrações práticas em um passo a passo completo utilizando o módulo `datadelivery`.
</small>

??? tip "Configuração básica de um projeto Terraform (passo a passo datadelivery)"
    For those who have never worked with Terraform and need a guideline, in the following steps we will:

    1. Create a simple Terraform project (a `main.tf` file)
    2. Call the `datadelivery` module
    3. Initialize the module with `terraform init`
    4. See the deployment plan with `terraform plan`
    5. Deploy the resources with `terraform apply`

    A [Terraform module](https://developer.hashicorp.com/terraform/language/modules) can be called from a different set of [sources](https://developer.hashicorp.com/terraform/language/modules/sources) in any Terraform project.

    A Terraform project can be anything you put in Terraform files in your workspace. Terraform files are simply files with `.tf` extension. So, with that in mind, let's create a file called `main.tf` to hold our Terraform code.

    ??? example "Creating a Terraform project"
        ![Creating a main.tf in a Terraform project](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/gifs/datadelivery-quickstart-01-maintf.gif?raw=true)

    Once we have the Terraform project (at least one `.tf` file) in our workspace, let's show how a Terraform module can be called. It needs at least a source and [module sources](https://developer.hashicorp.com/terraform/language/modules/sources) local paths, HTTP URLs, GitHub repos, S3 buckets and many others.

    The `datadelivery` module is hosted by a GitHub repository, so let's declare the module call inside our `main.tf` file.

    ??? example "Calling the datadelivery module from GitHub"
        ![Declaring the Terraform module block to call datadelivery source module from GitHub](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/gifs/datadelivery-quickstart-02-module.gif?raw=true)

    So now we can start executing Terraform commands in order to get the `datadelivery` module resources deployed in (your) the AWS target account. The first command works as a kind of a "press start button" and it helps users to get all the module logic in their workspace. We are talking about the `terraform init` command. Let's see how it works.

    ??? example "Initializing the module with terraform init"
        ![Initializing the module with terraform init](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/gifs/datadelivery-quickstart-03-init.gif?raw=true)

    After that, we can see exactly which AWS resources will be deployed, changed or even destroyed. It's the `terraform plan` command that can give us the visualization of the deployment plan.

    ??? example "Planning the deploy with terraform deploy"
        ![Planning the deploy with terraform deploy](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/gifs/datadelivery-quickstart-04-plan.gif?raw=true)

    And finally, after we initialized the module and checked the deployment plan, we can follow on with the deployment using the `terraform apply` command.
    
    ??? example "Deploying infrastructure with terraform apply"
        ![Deploying infrastructure with terraform apply](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/gifs/datadelivery-quickstart-05-apply.gif?raw=true)
    
    And that's how you can create Terraform project and call Terraform modules in any workspace.


## Variables 

The `datadelivery` Terraform module provides variables that can be set up in order to customize some of its behaviors. Users can follow along the [variables](./variables.md) page to understand what kind of customizations can be made.
