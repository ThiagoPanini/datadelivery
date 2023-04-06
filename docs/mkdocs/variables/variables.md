# Module Variables

When calling the *datadelivery* module from GitHub, users can set some variables to apply custom configurations. The acceptable variables are shown on the table below:

| **Variable** | **Type** | **Description** | **Default** |
| :-- | :-- | :-- | :-- |
| flag_s3_block_public_access | `bool` | Flag for blocking all public access for buckets created in this project | true |
| crawler_role_name | `string` | Role name for Glue Crawler IAM role | "datadelivery-glue-crawler-role" |
| glue_db_names | `map` | List of database names for storing Glue catalog tables | [Check the source](https://github.com/ThiagoPanini/datadelivery/blob/main/variables.tf#L56) |
| delay_to_run_crawler | `string` | A string representation to be considered as a time difference between the time of infrastructure deploy and the time to run the Glue Crawler | "2m" |

???+ example "Calling the module with variables"
    In case this is all new for you, to set up a variable in the *datadelivery*, you just need to pass its value on module call:

    ```json
    # Calling datadelivery with special configs
    module "datadelivery" {
        source = "git::https://github.com/ThiagoPanini/datadelivery"

        crawler_role_name    = "analytics-crawler-role"
        delay_to_run_crawler = "5m"

        glue_db_names = {
            "sor" = "db_sandbox_sor",
            "sot" = "db_sandbox_sot",
            "spe" = "db_sandbox_spec"
        }
    }
    ```

Eventually, new module variables can come up. Users will can always look at this section to see an updated list of variables to be used.