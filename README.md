<div align="center">
    <br><img src="https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/header-readme.png?raw=true" alt="datadelivery-logo">
</div>

<div align="center">
  <br>
  
  ![GitHub release (latest by date)](https://img.shields.io/github/v/release/ThiagoPanini/datadelivery?color=purple)
  ![GitHub Last Commit](https://img.shields.io/github/last-commit/ThiagoPanini/datadelivery?color=purple)
  ![CI workflow](https://img.shields.io/github/actions/workflow/status/ThiagoPanini/datadelivery/ci-main.yml?label=ci)
  [![Documentation Status](https://readthedocs.org/projects/terraglue/badge/?version=latest)](https://datadelivery.readthedocs.io/pt/latest/?badge=latest)

</div>

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Features](#features)
- [How Does it Work?](#how-does-it-work)
- [Combining Solutions](#combining-solutions)
- [Contacts](#contacts)
- [References](#references)

___


## Overview

The *datadelivery* project is an open source solution that provides a starter toolkit to be deployed in any AWS account in order to enable users to begin their learning path on AWS analytics services, like Athena, Glue, EMR, Redshift. It does that by supplying a [Terraform](https://www.terraform.io/) module that can be called from any Terraform project for deploying all the infrastructure needed to take the first steps using analytics in AWS with public datasets to be explored.

- Have you ever wanted to have a bunch of datasets to explore in AWS?
- Have you ever wanted to take public data and start building an ETL process?
- Have you ever wanted to go deep into the Data Mesh architecture with SoR, SoT and Spec layers?

🚛 Try *datadelivery*!

> **Note**
>  Now the *datadelivery* project has an official documentation in readthedocs! Visit the [following link](https://datadelivery.readthedocs.io/en/latest/) and check out usability technical details, practical examples and more!

___

## Features

- 🚀 A pocket and disposable AWS environment
- 🪣 Automatic creation of S3 buckets using the SoR, SoT and Spec storage layers approach
- 🤖 Automatic data cataloging process using a scheduled Glue Crawler
- 🎲 Provides different dataset tables ready to be explored in any AWS analytics service
- 🔦 Destroy everything and recreate all again at a touch of a single command

## How Does it Work?

When users call the *datadelivery* Terraform module, the following operations are performed:

1. Five different buckets are created in the target AWS account
2. The content of `data/` folder at the source module are uploaded to the SoR bucket
3. An IAM role is created with enough permissions to run a Glue Crawler
4. A Glue Crawler is created with a S3 target pointing to the SoR bucket
5. A cron expression is configured to trigger the Glue Crawler 2 minutes after finishing the infrastructure deployment
6. All files from SoR bucket (previously on `data/` folder) are cataloged as new tables on Data Catalog
7. A preconfigured Athena workgroup is created in order to enable users to run queries

## Combining Solutions

The *datadelivery* Terraform module isn't alone. There are other complementary open source solutions that can be put together to enable the full power of learning analytics on AWS. [Check it out](https://github.com/ThiagoPanini) if you think they could be useful for you!

![A diagram showing how its possible to use other solutions like datadelivery, terraglue and sparksnake](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/products-overview-v2.png?raw=true)

___

## Contacts

- [Thiago Panini - LinkedIn](https://www.linkedin.com/in/thiago-panini/)
- [paninitechlab @ hashnode](https://panini.hashnode.dev/)

___

## References

**AWS Glue**

- [Glue Crawler Prerequisites](https://docs.aws.amazon.com/glue/latest/dg/crawler-prereqs.html)

**Terraform**

- [Terraform - Creating Modules](https://developer.hashicorp.com/terraform/language/modules/develop)
- [Terraform - Using Modules](https://developer.hashicorp.com/terraform/language/modules)
- [Terraform - Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)
- [Medium - Maintaining Reusable Terraform Modules](https://arunksingh16.medium.com/maintaining-reusable-terraform-modules-in-github-d0440753e784)
- [Terraform - Filesystem and Workspace Info](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)

**GitHub**

- [GitHub - terraform-validate Action](https://github.com/marketplace/actions/terraform-validate)
