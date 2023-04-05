# Getting Started with datadelivery

In order to start using *datadelivery* to deploy an AWS toolkit for explore public dasets using analytics services, users will need:

- ☁️ [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) available for use
- 🔑 [Programatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) on the account with an `access_key_id` and a `secret_access_key`
- ⛏ [Terraform](https://www.terraform.io/) installed (version >=1.0)

???+ tip "Two ways for using datadelivery"
    In fact, there are two ways for using *datadelivery* and all its features:
    
    1. By calling it from another Terraform project (prefered one)
    2. By cloning the source repo and deploying infrastructure by running the Terraform commands

    In this section users will take the chance to precisely look at both usage modes in order to select the one that best suits their needs.

___

## Calling datadelivery Module

As stated in the official Terraform documentation:

> A module is a container for multiple resources that are used together. You can use modules to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

If you already have a Terraform project and you want to add *datadelivery* features to it, you can just call the module directly from [GitHub](https://github.com/ThiagoPanini/datadelivery) using the following sintax:

```json
# Calling datadelivery module with default configuration
module "datadelivery" {
  source = "git::https://github.com/ThiagoPanini/datadelivery"
}
```

Check out the demo gifs below to see this working in practice.

??? example "Creating a Terraform project"
    There are different ways to use Terraform. In fact, different users can adopt different styles according to their own preferences. The [Terraform language documentation](https://developer.hashicorp.com/terraform/language) will always be a good friend to help users to find their own development style.

    Here, to make things simpler, let's just create a new folder and a `main.tf` file to be our main file of our project root module.

    ![Creating a main.tf in a Terraform project](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/gifs/datadelivery-quickstart-01-maintf.gif?raw=true)


??? example "Calling the datadelivery module from GitHub"
    The next step to have *datadelivery* features available is to call its module directly from GitHub. It can be define by defining a Terraform `module` call passing the GitHub repository reference as source.

    ![Declaring the Terraform module block to call datadelivery source module from GitHub](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/gifs/datadelivery-quickstart-02-module.gif?raw=true)


??? example "Initializing the module with terraform init"
    So here we start the Terraform comands to deploy the *datadelivery* module infrastructure provided. The first one is the command used to initialize the module and install all files needed in the project.

    ![Initializing the module with terraform init](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/gifs/datadelivery-quickstart-03-init.gif?raw=true)


??? example "Planning the deploy with terraform deploy"
    And now that the Terraform project has all components from *datadelivery* module installed, it's time to see the deployment plan through `terraform plan` command.

    ![Planning the deploy with terraform deploy](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/gifs/datadelivery-quickstart-04-plan.gif?raw=true)


??? example "Deploying infrastructure with terraform apply"
    Finally, we can deploy the infrastructure using the `terraform apply` command.

    ![Deploying infrastructure with terraform apply](https://github.com/ThiagoPanini/datadelivery/blob/feature/first-deploy/docs/assets/gifs/datadelivery-quickstart-05-apply.gif?raw=true)

And with the steps above, users will have all elements from *datadelivery* that will help them to improve their analytics skills using a preconfigured environment that offers a bunch of public datasets already cataloged in Data Catalog that can be used for many purposes.

As said before, calling the *datadelivery* source module from GitHub is probably the best way to use its features. The demo videos considered the simplest use case ever possible where a brand new Terraform project was created just for using *datadelivery*, but the idea was to show that users can call *datadelivery* module in huge Terraform projects to fill their needs.

:material-alert-decagram:{ .mdx-pulse .warning } By the other hand, users also can choose to clone the source GitHub repository by their own and run the Terraform commands to deploy the infrastructure. The main problem of this approach is that users won't have the latest *datadelivery* features until they pull new updates from the source repo. It means that users should always pay attention to new features and releases from the source repository.

## Cloning the Source Repo (Optional)

This approach considers the following steps to use *datadelivery* features in an AWS account:

```bash
# 1. Cloning the source repo via HTTPS
git clone https://github.com/ThiagoPanini/datadelivery.git

# 2. Navigating to the local repository
cd datadelivery/

# 3. Initializing Terraform modules
terraform init

# 4. Planning the deploy
terraform plan

# 5. Deploying infra
terraform apply
```

???+ success "Do whatever you feel more comfortable to"
    As much as I stated here that calling the *datadelivery* source GitHub module should be the best way to use its features, in truth the best way is that one you feel more comfortable.

    If cloning the repo pleases you, feel free to do it.

    What matters most is users exploring all the good features provided by *datadelivery*!