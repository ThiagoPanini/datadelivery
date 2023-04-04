<div align="center">
    <br><img src="https://github.com/ThiagoPanini/terracatalog/blob/main/docs/assets/imgs/header-readme.png?raw=true" alt="terracatalog-logo">
</div>

<div align="center">
  <br>
  
  ![GitHub release (latest by date)](https://img.shields.io/github/v/release/ThiagoPanini/terracatalog?color=purple)
  ![GitHub Last Commit](https://img.shields.io/github/last-commit/ThiagoPanini/terracatalog?color=purple)
  ![CI workflow](https://img.shields.io/github/actions/workflow/status/ThiagoPanini/terracatalog/ci-main.yml?label=ci)
  [![Documentation Status](https://readthedocs.org/projects/terraglue/badge/?version=latest)](https://terracatalog.readthedocs.io/pt/latest/?badge=latest)

</div>

## Table of Contents
- [Table of Contents](#table-of-contents)
- [Overview](#overview)
- [Features](#features)
- [Contacts](#contacts)
- [References](#references)

___


## Overview

The *terracatalog* project is an open source solution that provides a starter toolkit to be deployed in any AWS account in order to enable users to begin their learning path on AWS analytics services, like Athena, Glue, EMR, Redshift. It does that by supplying a [Terraform](https://www.terraform.io/) module that can be called from any Terraform project for deploying all the infrastructure needed to take the first steps using analytics in AWS with public datasets to be explored.

- Have you ever wanted to have a bunch of datasets to explore in AWS?
- Have you ever wanted to take public data and start building an ETL process?
- Have you ever wanted to go deep into the Data Mesh architecture with SoR, SoT and Spec layers?

🌘 Try *terracatalog*!

> **Note**
>  Now the *terracatalog* project has an official documentation in readthedocs! Visit the [following link](https://terracatalog.readthedocs.io/en/latest/) and check out usability technical details, practical examples and more!

___

## Features

- 🚀 A pocket and disposable AWS environment
- 🪣 Automatic creation of S3 buckets using the SoR, SoT and Spec storage layers approach
- 🤖 Automatic data cataloging process using a scheduled Glue Crawler
- 🎲 Provides different dataset tables ready to be explored in any AWS analytics service
- 🔦 Destroy everything and recreate all again at a touch of a single command

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