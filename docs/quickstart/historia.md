# datadelivery Under the Hood


In this documentation page, I will talk about the big idea behind the *datadelivery* Terraform module and how its creation can be a huge milestone on learning anything on AWS.

🪄 This is the story about how I had to decouple my open source solutions to have a more scalable kit of projects that help users in their analytics learning journey on AWS.

## Terraglue: the Beginning and the First

No, you are not reading anything wrong and you are neither at the wrong documentation page. The truth is that we can't talk about *datadelivery* without talking about *terraglue* first.

I know, it's a bunch of unknown names and maybe you're thinking about what's going on. But let me tell you something really important: the *datadelivery* project was born from *terraglue* project. To know more about *terraglue* (and to get the idea about the decoupling process), I suggest you to stop this reading for a little while and go to the [main story about how it all started](https://terraglue.readthedocs.io/en/latest/story/).

This is not like Dark, the Netflix TV Show, where you travel through time, but probably you will like to know the beginning of everything before going ahead in this page. Feel free to choose your beginning.

![A gif of Jonas, the main character of a Netflix TV Show called Dark](https://media2.giphy.com/media/87dGn81U6RvMSRYoRe/giphy.gif?cid=ecf05e47ymzhlogsdm5bn3m96gleb3xrb2q9fof8brij0trv&rid=giphy.gif&ct=g)

## Where is the Data?

Well, regardless of how you got here and which of my other open source projects you are familiar with, the *datadelivery* project was born to solve a specific problem: the lack of public data sources available to explore AWS services.

In fact, this is a honest claim of anyone who wants to learn more about AWS services using different datasets. After all, data is probably the most important thing in any data project (and I don't want to be redundant with this sentence).

???+ question "So where can we find datasets to explore?"
    Nowadays, finding public datasets isn't too hard. There are many websites, blog posts, books and many other sources who offers links to download datasets with the most varied contents. To name a few, we have:

    - [Kaggle](https://www.kaggle.com/datasets/)
    - [UCI Machine Learning Repository](https://archive-beta.ics.uci.edu/)
    - GitHub repository from books such as:
        - [Spark - The Definitive Guide](https://github.com/databricks/Spark-The-Definitive-Guide/tree/master/data)
        - [Learning Spark](https://github.com/databricks/LearningSparkV2/tree/master/databricks-datasets/learning-spark-v2)
        - [Apache Hive Essentials](https://github.com/PacktPublishing/Apache-Hive-Essentials-Second-Edition/tree/master/data)

    So, it's enough to say that there are many ways to download and use public datasets for whatever learning purpose. Ok, it's fair enough.

    But in our context we are talking about use those datasets inside AWS, right? What about all the effort needed do download the files, upload into a storage system (like S3) and catalog all the medata into Data Catalog? It's seems like a little bit too hard yet.

    🚛💨 This is where *datadelivery* shines!

## datadelivery: A Data Exploration Toolkit

I think you get the idea but just to reinforce: the *datadelivery* project provides an efficient way to activate pieces and services in an AWS account in order to enable users to explore preselected public datasets. It does that by providing a Terraform module that can be called directly from its source GitHub repository.

I state that in the project documentation home page, but this is the perfect time to clarify what really happens when users call the *datadelivery* Terraform module:

1. Five different buckets are created in the target AWS account
2. The content of `data/` folder at the source module are uploaded to the SoR bucket
3. An IAM role is created with enough permissions to run a Glue Crawler
4. A Glue Crawler is created with a S3 target pointing to the SoR bucket
5. A cron expression is configured to trigger the Glue Crawler 2 minutes after finishing the infrastructure deployment
6. All files from SoR bucket (previously on `data/` folder) are cataloged as new tables on Data Catalog
7. A preconfigured Athena workgroup is created in order to enable users to run queries

If writing it isn't enough, take a look at the project diagram:

[![A diagram of services deployed](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/project-diagram.png?raw=true)](https://github.com/ThiagoPanini/datadelivery/blob/main/docs/assets/imgs/project-diagram.png?raw=true)

Do you want to know more about the "behind the scenes" of the project construction? I will present some code details about how all the infrastructure was declared in the module.

### Storage Structure in S3

This was the first infrastructure block created in the project. After all, it would be impossible to provide the exploration of public datasets in analytics services in AWS without thinking about the storage layer.

To do such a thing, I declared some useful variables into a [`locals.tf`](https://github.com/ThiagoPanini/datadelivery/blob/main/locals.tf) Terraform file as you can see below:

```json
# Defining data sources to help local variables
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

# Defining local variables to be used on the module
locals {
  account_id  = data.aws_caller_identity.current.account_id
  region_name = data.aws_region.current.name

  # Creating a map with bucket names to be deployed
  bucket_names_map = {
    "sor"    = "datadelivery-sor-data-${local.account_id}-${local.region_name}"
    "sot"    = "datadelivery-sot-data-${local.account_id}-${local.region_name}"
    "spec"   = "datadelivery-spec-data-${local.account_id}-${local.region_name}"
    "athena" = "datadelivery-athena-query-results-${local.account_id}-${local.region_name}"
    "glue"   = "datadelivery-glue-assets-${local.account_id}-${local.region_name}"
  }

  # [...] more code below
```

The `aws_region` and the `aws_caller_identity` Terraform data sources were created to make it possible to get some useful attributes from the target AWS account, like the `account_id` and `region_name` local values.

According to the official [Terraform documentation](https://developer.hashicorp.com/terraform/language/values/locals):

> "A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression. [...] The expressions in local values are not limited to literal constants; they can also reference other values in the module in order to transform or combine them, including variables, resource attributes, or other local."

With that in mind, the storage layer has its heart at the `bucket_names_map` local value used to create a map of bucket names using dynamic information gotten from the aforementioned data sources.

So, the next step was about to create a [storage.tf](https://github.com/ThiagoPanini/datadelivery/blob/main/storage.tf) Terraform file to declare a [aws_s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) Terraform resource for each value in the `bucket_names_map` local variable as you can see below:

```json
# Creating all buckets
resource "aws_s3_bucket" "this" {
  for_each      = local.bucket_names_map
  bucket        = each.value
  force_destroy = true
}
```

The big idea about the resource block code above is the definition of a [`for_each`](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each) meta-argument that makes it possible to create several similar objects without writing a separate block for each one.

And once again, according to the Terraform official documentation page:

> "If a resource or module block includes a for_each argument whose value is a map or a set of strings, Terraform creates one instance for each member of that map or set."

And that's how multiple buckets could be created using a local value that maps different bucket names.

In addition to that, other bucket configurations and resources were defined on the `storage.tf` file, such as:

- Public access block with [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)
- Server Side Encryption with [aws_s3_bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block)

And finally, with all the buckets created and configured, it was possible to upload preselected public datasets originally stored in the `data/` folder from the source GitHub repository. Before showing the Terraform code block to do that, let's see the structure of this folder:

```
├───data
│   ├───bike_data
│   │   ├───tbl_bikedata_station
│   │   └───tbl_bikedata_trip
│   ├───br_ecommerce
│   │   ├───tbl_brecommerce_customers
│   │   ├───tbl_brecommerce_geolocation
│   │   ├───tbl_brecommerce_orders
│   │   ├───tbl_brecommerce_order_items
│   │   ├───tbl_brecommerce_payments
│   │   ├───tbl_brecommerce_products
│   │   ├───tbl_brecommerce_reviews
│   │   └───tbl_brecommerce_sellers
│   ├───flights_data
│   │   ├───tbl_flights_airport_codes_na
│   │   ├───tbl_flights_departure_delays
│   │   └───tbl_flights_summary_data
│   ├───tbl_airbnb
│   ├───tbl_blogs
│   └───tbl_iot_devices
```

Here you can see that there are some data folders simulating table structures with raw files in each one of them. In order to provide some context, the table below shows some useful information about the datasets in the `data/` source repository folder:

| **🎲 Dataset** | **🏷️ Description** | **🔗 Source Link** |
| :-- | :-- | :-- |
| Bike Data | The dataset has information about San Francisco loan bike service from August 2013 to August 2015. | [Link](https://github.com/databricks/Spark-The-Definitive-Guide/tree/master/data/bike-data) |
| Brazilian E-Commerce | The dataset has information of 100k orders from 2016 to 2018 made at multiple marketplaces in Brazil. | [Link](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) |
| Flights Data | This dataset has information about flight travels in the United States. | [Link](https://github.com/databricks/Spark-The-Definitive-Guide/tree/master/data/flight-data) |
| Airbnb | A dataset with interactions with Airbnb in many of their services. There are 700 attributes to be explored. | [Link](https://github.com/databricks/Spark-The-Definitive-Guide/tree/master/data) |
| Blogs | A small and fake dataset with information of blogs published on internet | [Link](https://github.com/databricks/Spark-The-Definitive-Guide/tree/master/data) |
| IoT Devices | A fake dataset with measurements from IoT devices collected in a company facility | [Link](https://github.com/databricks/LearningSparkV2/tree/master/databricks-datasets/learning-spark-v2/iot-devices) |

In the future, it's highly possible that new datasets are included in the *datadelivery*, so users will have a wider range of possibilities.

So, now that you know the content of the `data/` folder, it's possible to turn back to the `storage.tf` file and see how the upload process to S3 works:

```json
# Adding local files on SoR bucket
resource "aws_s3_object" "data_sources" {
  for_each               = fileset(local.data_path, "**")
  bucket                 = aws_s3_bucket.this["sor"].bucket
  key                    = each.value
  source                 = "${local.data_path}${each.value}"
  server_side_encryption = "aws:kms"
}
```

In the end, it's all about using the [`fileset()`](https://developer.hashicorp.com/terraform/language/functions/fileset) Terraform function to get the contents of a local path (represented by a local value called `data_path`). The target is pointed as the SoR bucket (as we are talking about raw files, it makes sense to store it in the System of Records layer).

The `data_path` local value is nothing more than a combination between the path module and the `data/` folder, as you can see below:

```
# Referencing a data folder where the files to be uploaded are located
data_path = "${path.module}/data/"
```

And this is how the storage structure was built. After all, the users will have a set of S3 buckets and public datasets stored in the SoR bucket.

This is just the beginning.

### Crawling the Data

We know that uploading raw files to S3 isn't enough to build all the elements needed to explore analytics services on AWS. It is also necessary to **catalog** data in order to make it accessible.

The first step taken to accomplish this mission was to crate a [`catalog.tf`](https://github.com/ThiagoPanini/datadelivery/blob/main/catalog.tf) Terraform file to declare all the infrastructure needed to input the metadata from the raw data files provided into `storage.tf` into the Data Catalog.

So, we start by defining a [aws_glue_catalog_database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_catalog_database) resource to create different databases into Glue Data Catalog in order to receive new tables.

```json
# Creating Glue databases on Data Catalog
resource "aws_glue_catalog_database" "mesh" {
  for_each    = var.glue_db_names
  name        = each.value
  description = "Database ${each.value} for storing tables in this specific layer"
}
```

Here we can see the `glue_db_names` variables taken from a `variables.tf` Terraform file which handles all the acceptable variables for the *datadelivery* module. The definition of database names can be seen below:

```json
variable "glue_db_names" {
  description = "List of database names for storing Glue catalog tables"
  type        = map(string)
  default = {
    "sor"  = "db_datadelivery_sor",
    "sot"  = "db_datadelivery_sot",
    "spec" = "db_datadelivery_spec"
  }
}
```

For each entry in the `glue_db_names` map variable, a new database will be created on the target AWS account. Here it's important to say that only the "db_datadelivery_sor" database will receive the catalogged data (well, the SoR layer handles raw data, so it's far enough to create tables in this database). The similar SoT and Spec databases are provided just in case if users want to input their own tables from process like jobs Glue or Athena queries.

Then, the most important resource to make things happen is the [aws_glue_crawler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/glue_crawler), but before showing the Terraform declaration block, let's take a look into the definition of a Glue Crawler.

???+ info "About Glue Crawlers"
    According to the [official AWS documentation page](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html):

    > You can use a crawler to populate the AWS Glue Data Catalog with tables. This is the primary method used by most AWS Glue users. A crawler can crawl multiple data stores in a single run. Upon completion, the crawler creates or updates one or more tables in your Data Catalog. Extract, transform, and load (ETL) jobs that you define in AWS Glue use these Data Catalog tables as sources and targets. The ETL job reads from and writes to the data stores that are specified in the source and target Data Catalog tables.
    > 
    > [...]
    > 
    > When a crawler runs, it takes the following actions to interrogate a data store:
    >
    > - Classifies data to determine the format, schema, and associated properties of the raw data
    > - Groups data into tables or partitions
    > - Writes metadata to the Data Catalog

With that in mind, the following Terraform code declares a Glue Crawler resource with some special attributes that will be explained later.

```json
# Defining a Glue Crawler
resource "aws_glue_crawler" "sor" {
  database_name = var.glue_db_names["sor"]
  name          = "terracatalog-glue-crawler-sor"
  role          = aws_iam_role.glue_crawler_role.arn

  s3_target {
    path = "s3://${local.bucket_names_map["sor"]}"
  }

  schedule = local.crawler_cron_expr

  depends_on = [
    aws_s3_object.data_sources,
    aws_iam_policy.glue_policies,
    aws_iam_role.glue_crawler_role
  ]
}
```

Some points need to be clarified here:

- The target database for the Crawler is the SoR database
- The target storage location for the Crawler is the SoR S3 bucket
- A new IAM role is previously created on the [`iam.tf`](https://github.com/ThiagoPanini/datadelivery/blob/main/iam.tf) Terraform file with all the permissions needed to run a Glue Crawler (you can check the source link if you want do see it in details)
- :material-alert-decagram:{ .mdx-pulse .warning } A cron expression is defined in the `locals.tf` file to **run the Crawler** 2 minutes (by default) after finishing the infrastructure deploy

The last point is surely a great way out to automate the crawling process without the need to access the AWS account and run it manually. So let's take a deep dive into it.

Coming back to the `locals.tf` Terraform file, to be able to create a valid cron expression that runs the Crawler a couple of minutes before the infrastructure deployment, it was important to get the current time in execution time. The way chosen to do that envolved the use of the [`timestamp()`](https://developer.hashicorp.com/terraform/language/functions/timestamp) and [`timeadd()`](https://developer.hashicorp.com/terraform/language/functions/timeadd) Terraform functions.

```json
# [...]

# Extracting current timestamp and adding a delay
timestamp_to_run = timeadd(timestamp(), var.delay_to_run_crawler)
```

The `delay_to_run_crawler` variable can be passed by user in a *datadelivery* module call. Its default value is "2m", pointing that the actual current timestamp value to be used to create a cron expression is delayed by 2 minutes.

So, the next step was about to extract all elements needed in valid a cron expression. It could be done by calling the [`formatdate()`](https://developer.hashicorp.com/terraform/language/functions/formatdate) Terraform function with different date format arguments:

```json
# Getting date information
cron_day    = formatdate("D", local.timestamp_to_run)
cron_month  = formatdate("M", local.timestamp_to_run)
cron_year   = formatdate("YYYY", local.timestamp_to_run)
cron_hour   = formatdate("h", local.timestamp_to_run)
cron_minute = formatdate("m", local.timestamp_to_run)
```

And then, the last step was about to create the cron expression with the individual local values for each cron attribute:

```json
# Building a cron expression for Glue Crawler to run minutes after infrastructure deploy
crawler_cron_expr = "cron(${local.cron_minute} ${local.cron_hour} ${local.cron_day} ${local.cron_month} ? ${local.cron_year})"
```

For example, if a user calls the *datadelivery* Terraform module at 6:45PM, and supposing that the infrastructure deployment takes about 5 minutes to finish (at 6:50PM to be exactly), then a Glue Crawler will run in the AWS target account at 6:52PM (and never more).

![A gif from the Neflix TV show called Dark where Jonas, the main charactere, is asking "What day is it today?"](https://media.giphy.com/media/v1.Y2lkPTc5MGI3NjExMDFkMTc4ODgwZjFjZmU0MDhhZGYwNmVjZjY4NDUyY2MxM2Y4MDEyYyZjdD1n/ftT0TTGmIZ7omfdvMc/giphy.gif)

So, coming back to the `catalog.tf` Terraform file, the last thing that is done is the cretion of an Athena workgroup through [aws_athena_workgroup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/athena_workgroup) Terraform resource.

```json
# Defining an Athena preconfigured workgroup
resource "aws_athena_workgroup" "analytics" {
  name          = "terracatalog-workgroup"
  force_destroy = true

  configuration {
    result_configuration {
      output_location = "s3://${local.bucket_names_map["athena"]}"

      encryption_configuration {
        encryption_option = "SSE_KMS"
        kms_key_arn       = data.aws_kms_key.s3.arn
      }
    }
  }
}
```

The great thing about it is that this is a preconfigured workgroup to store Athena query results in the *datadelivery* Athena parametrized bucket (taken from `buckets_map` local value). Users will be able to start using the Athena query editor without worry about any other settings.

So, with `storage.tf` and `catalog.tf` files, users can extract the real power from *datadelivery* Terraform module. The `iam.tf` file, as said before, is also extremely useful to an IAM policies and role context (especially when we talk about the crawler process).

## So What About Now?

Well, by now I really invite all the readers to join and read more about the *datadelivery* Terraform module. There is a [huge documentation page](https://datadelivery.readthedocs.io/en/latest/) hosted on [readthedocs](https://readthedocs.org/) with many useful information about how this project can help users on their analytics journey in AWS.

![](https://media.tenor.com/WKQz9MoMtZEAAAAC/dark-dark-netflix.gif)

By the way, with all the things presented here, to start using *datadelivery* in your AWS account, you just need to call the module from the source GitHub repository using the following example:

```json
# Calling datadelivery module with default configuration
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

And finally, If you want to know more, I reinforce: don't forget to check the [official documentation page](https://datadelivery.readthedocs.io/en/latest/). I really feel that all the users using AWS to learn more about analytics can be helped with *datadelivery* and its features!

___

## References

- [Terraform - Local Values](https://developer.hashicorp.com/terraform/language/values/locals)
- [Terraform - The `for_each` Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [Terraform - `formatdate` Function](https://developer.hashicorp.com/terraform/language/functions/formatdate)
- [Terraform - `fileset` Function](https://developer.hashicorp.com/terraform/language/functions/fileset)
- [AWS - Defining Crawlers in AWS Glue](https://docs.aws.amazon.com/glue/latest/dg/add-crawler.html)
- [AWS - How Crawlers Work](https://docs.aws.amazon.com/glue/latest/dg/crawler-running.html)
- [Terraform - `timestamp` Function](https://developer.hashicorp.com/terraform/language/functions/timestamp)
- [Terraform - `timeadd` Function](https://developer.hashicorp.com/terraform/language/functions/timeadd)