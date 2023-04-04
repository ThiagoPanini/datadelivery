# Getting Started with terracatalog

In order to start using *terracatalog* to deploy an AWS toolkit for explore public dasets using analytics services, users will need:

- ☁️ [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/) available for use
- 🔑 [Programatic access](https://docs.aws.amazon.com/general/latest/gr/aws-sec-cred-types.html) on the account with an `access_key_id` and a `secret_access_key`
- ⛏ [Terraform](https://www.terraform.io/) installed (version >=1.0)

???+ tip "Two ways for using terracatalog"
    In fact, there are two ways for using *terracatalog* and all its features:
    
    1. By calling it from another Terraform project (prefered one)
    2. By cloning the source repo and deploying infrastructure by running the Terraform commands

    In this section users will take the chance to precisely look at both usage modes in order to select the one that best suits their needs.

___

## Calling terracatalog Module

As stated in the official Terraform documentation:

> A module is a container for multiple resources that are used together. You can use modules to create lightweight abstractions, so that you can describe your infrastructure in terms of its architecture, rather than directly in terms of physical objects.

If you already have a Terraform project and you want to add *terracatalog* features to it, you can just call the module directly from [GitHub](https://github.com/ThiagoPanini/terracatalog) using the following sintax:

```json
# Calling terracatalog module with default configuration
module "terracatalog" {
  source = "git::https://github.com/ThiagoPanini/terracatalog"
}
```

Check out the demo gifs below to see this working in practice.

??? example "Creating a Terraform project"
    There are different ways to use Terraform. In fact, different users can adopt different styles according to their own preferences. The [Terraform language documentation](https://developer.hashicorp.com/terraform/language) will always be a good friend to help users to find their own development style.

    Here, to make things simpler, let's just create a new folder and a `main.tf` file to be our main file of our project root module.

    ![Creating a main.tf in a Terraform project](https://github.com/ThiagoPanini/terracatalog/blob/feature/first-deploy/docs/assets/gifs/terracatalog-quickstart-01-maintf.gif?raw=true)


??? example "Calling the terracatalog module from GitHub"
    The next step to have *terracatalog* features available is to call its module directly from GitHub. It can be define by defining a Terraform `module` call passing the GitHub repository reference as source.

    ![Declaring the Terraform module block to call terracatalog source module from GitHub](https://github.com/ThiagoPanini/terracatalog/blob/feature/first-deploy/docs/assets/gifs/terracatalog-quickstart-02-module.gif?raw=true)


??? example "Initializing the module with terraform init"
    So here we start the Terraform comands to deploy the *terracatalog* module infrastructure provided. The first one is the command used to initialize the module and install all files needed in the project.

    ![Initializing the module with terraform init](https://github.com/ThiagoPanini/terracatalog/blob/feature/first-deploy/docs/assets/gifs/terracatalog-quickstart-03-init.gif?raw=true)


??? example "Planning the deploy with terraform deploy"
    And now that the Terraform project has all components from *terracatalog* module installed, it's time to see the deployment plan through `terraform plan` command.

    ![Planning the deploy with terraform deploy](https://github.com/ThiagoPanini/terracatalog/blob/feature/first-deploy/docs/assets/gifs/terracatalog-quickstart-04-plan.gif?raw=true)


??? example "Deploying infrastructure with terraform apply"
    Finally, we can deploy the infrastructure using the `terraform apply` command. By executing this comand, the user will have all elements from *terracatlog* deployed in its AWS account.

    ![Deploying infrastructure with terraform apply](https://github.com/ThiagoPanini/terracatalog/blob/feature/first-deploy/docs/assets/gifs/terracatalog-quickstart-05-apply.gif?raw=true)
