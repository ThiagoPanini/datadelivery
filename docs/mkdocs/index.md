# datadelivery: Helping users to start their analytics journey at AWS

## Overview

*datadelivery* is an open source [Terraform](https://www.terraform.io/)  module that provides a starter infrastructure toolkit to be deployed in any AWS account in order to help users to explore analytics services like Athena, Glue, EMR, Redshift and others. It does that by uploading and cataloging public datasets that can be used for multiple purposes, either to create jobs or just to query data using AWS services.

- Have you ever wanted to have a bunch of datasets to explore in AWS?
- Have you ever wanted to take public data and start building an ETL process?
- Have you ever wanted to go deep into the Data Mesh architecture with SoR, SoT and Spec layers?

🚛 Try *datadelivery*!


<div align="center">
    <br><img src="https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/header-readme.png?raw=true" alt="datadelivery-logo">
</div>


<div align="center">  
  <br>

  <img src="https://img.shields.io/github/v/release/ThiagoPanini/datadelivery?color=purple" alt="Shield github release version">
  
  <img src="https://img.shields.io/github/last-commit/ThiagoPanini/datadelivery?color=purple" alt="Shield github last commit">
  
  <img src="https://img.shields.io/github/actions/workflow/status/ThiagoPanini/datadelivery/ci-feature.yml?label=ci" alt="Shield github CI workflow">

  <a href='https://datadelivery.readthedocs.io/en/latest/?badge=latest'>
    <img src='https://readthedocs.org/projects/datadelivery/badge/?version=latest' alt='Documentation Status' />
  </a>

</div>

___

## Features

- 🚀 A pocket and disposable AWS environment
- 🪣 Automatic creation of S3 buckets using the SoR, SoT and Spec storage layers approach
- 🤖 Automatic data cataloging process using a scheduled Glue Crawler
- 🎲 Provides different dataset tables ready to be explored in any AWS analytics service
- 🔦 Destroy everything and recreate all again at a touch of a single command

## How it Works?

When users call the *datadelivery* Terraform module, the following operations are performed:

1. Five different buckets are created in the target AWS account
2. The content of `data/` folder at the source module are uploaded to the SoR bucket
3. An IAM role is created with enough permissions to run a Glue Crawler
4. A Glue Crawler is created with a S3 target pointing to the SoR bucket
5. A cron expression is configured to trigger the Glue Crawler 2 minutes after finishing the infrastructure deployment
6. All files from SoR bucket (previously on `data/` folder) are cataloged as new tables on Data Catalog
7. A preconfigured Athena workgroup is created in order to enable users to run queries

## Combining Solutions

This is the *datadelivery* project documentation page. There are other complementary solutions that can be chained to enable a powerful learning journey on AWS. [Check it out](https://github.com/ThiagoPanini) if you think they could be useful for you!

![A diagram showing how its possible to use other solutions like datadelivery, terraglue and sparksnake](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/imgs/products-overview-v2.png?raw=true)

## Read the Docs

- Check out the [Quickstart](./quickstart/gettingstarted.md) page for a step by step guide on how to start using *datadelivery*
- The [Variables](./variables/variables.md) section helps users to understand all available module variables 
- The [Architecture](./architecture/infra.md) page you will see details for all AWS infrastructure provided
- Still have doubts? Check the [FAQ](./faq/faq.md) page!
    

## Contacts

- :fontawesome-brands-github: [@ThiagoPanini](https://github.com/ThiagoPanini)
- :fontawesome-brands-linkedin: [Thiago Panini](https://www.linkedin.com/in/thiago-panini/)
- :fontawesome-brands-hashnode: [panini-tech-lab](https://panini.hashnode.dev/)
