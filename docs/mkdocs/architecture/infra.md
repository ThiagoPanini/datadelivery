# Project Architecture

## Infrastructure Provided

As stated in the [main page](../index.md) in this documentation, the *datadelivery* project enables a set of preconfigured AWS services in order to improve users journey on exploring data.

The diagram of services deployed can be found below:

[![A diagram of services deployed](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/imgs/project-diagram.png?raw=true)](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/imgs/project-diagram.png?raw=true)

In essence, by using *datadelivery*, users will have:

- 🪣 S3 buckets for storing data and *assets*
- 🚨 IAM policies and role to manage access
- 🎲 Databases in Data Catalog
- 🐞 A one-time scheduled Glue Crawler to catalog data
- 🏛️ An Athena workgroup to store query results

## Module Structure

In *datadelivery*, the AWS resources are declared in different Terraform files:

Considering the project architecture presented above, the table below shows how the structure of source repository.

| 📂 **File** | ⚙️ **Description** |
| :-- | :-- |
| `storage.tf` | Creates all s3 buckets and upload all files in `data/` folder into buckets |
| `iam.tf` | Creates IAM policies and role to be assumed by a Glue Crawler |
| `catalog.tf` | Sets a preconfigured Glue Crawler to catalog raw files as tables in Data Catalog |
| `athena.tf` | Creates a preconfigured Athena workgroup to help users to run their queris |