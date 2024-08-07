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

## Overview

The `datadelivery` solution is an open source [Terraform](https://www.terraform.io/) that provides an infrastructure toolkit to be deployed in any AWS account in order to help users to start **exploring data**. It does that by:

- 🪣 Deploying AWS S3 buckets into the user account following the [data mesh architecture](https://www.datamesh-architecture.com/)
- 🎲 Uploading some public datasets into the raw data S3 bucket
- ⏳ Scheduling a Glue crawler to catalog raw files into tables
- 🔒 Providing a preconfigured IAM policy and role to run the crawler
- 📈 Creating an Athena workgroup to run SQL queries

<small>
  :octicons-tools-16:
  **A fully disposable environment!** As a Terraform module, all AWS resources provided by `datadelivery` can be deployed on a single command call (`terraform apply`). On the same way, the environment can be turned off and all resources can be destroyed whenever users want (`terraform destroy`).
</small>

## Before the Beginning

In order to start using `datadelivery`, users will need:

- ☁️ An [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) available for use
- 🔑 [Programatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) on the account with an `access_key_id` and a `secret_access_key`
- ⛏ [Terraform](https://www.terraform.io/) installed (version >=1.0)

## Calling the Module

With the environment already setup, users can simply create a `main.tf` Terraform file and call the module as:

```python
# Calling datadelivery module with default configuration
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

<small>
  :octicons-light-bulb-16:
  **Hint:** if you have any doubt about how to setup a Terraform project, check the block below to see some demos on running Terraform commands in order to deploy `datadelivery` AWS resources.
</small>

??? tip "Setting up a basic Terraform project"
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
