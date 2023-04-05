# datadelivery: Helping users to start their analytics journey at AWS

## Overview

The *datadelivery* project is an open source solution that provides a starter toolkit to be deployed in any AWS account in order to enable users to begin their learning path on AWS analytics services, like Athena, Glue, EMR, Redshift. It does that by supplying a [Terraform](https://www.terraform.io/) module that can be called from any Terraform project for deploying all the infrastructure needed to take the first steps using analytics in AWS with public datasets to be explored.

- Have you ever wanted to have a bunch of datasets to explore in AWS?
- Have you ever wanted to take public data and start building an ETL process?
- Have you ever wanted to go deep into the Data Mesh architecture with SoR, SoT and Spec layers?

🚛 Try *datadelivery*!


<div align="center">
    <br><img src="https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/logo.png?raw=true" alt="terraglue-logo" width=200 height=200>
</div>

<div align="center">
    <i>datadelivery<br>
    AWS Pocket Infrastructure</i>
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


## Read the Docs

- Checkout the [Quickstart](./quickstart/gettingstarted.md) page for a step by step guide on how to start using *datadelivery*
- At the [Architecture](./architecture/project-architecture.md) page you will see details for all AWS infrastructure provided
- Still have doubts? Check the [FAQ](./faq/faq.md) page!
    

## Contacts

- :fontawesome-brands-github: [@ThiagoPanini](https://github.com/ThiagoPanini)
- :fontawesome-brands-linkedin: [Thiago Panini](https://www.linkedin.com/in/thiago-panini/)
- :fontawesome-brands-hashnode: [panini-tech-lab](https://panini.hashnode.dev/)
