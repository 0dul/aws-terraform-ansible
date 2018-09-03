# AWS Terraform Ansible deployment

This project deploys a lab environment to Amazon Web Services using Terraform and Ansible.

## Requirements

* [Terraform](https://www.terraform.io/downloads.html) v0.11.7 (version tested) or higher
* Cloud platform AWS

> __NOTE__: Don't forget to configure the access to your own cloud platform and update the configuration parameters accordingly.

### Configure terraform environment

Environment variables SHOULD be available as system environment variables. It is RECOMMENDED to defined them in a file that MUST be named `*.auto.tfvars`.

Variables specific to a user (e.g. username, password, etc.) MUST NOT be stored in the code source repository. It is RECOMMENDED to define them in a dedicated file name `my.auto.tfvars` that MUST be .gitignored.

Any tfvars file can be set inline using `-var-file=filename`.
Any variable can be set inline using `-var foo=bar`.

> __NOTE__: variable definitions can be found in the [Terraform OpenStack provider](https://www.terraform.io/docs/providers/openstack/index.html) documentation.

## Getting started

Clone this repository using Git. 

Before initializing your environment, create the file `./terraform/my.auto.tfvars` with your personal information like this:

``` sh
# User specific variables that MUST not be saved to the repository
# any of these variables can be override inline using -var <varname>=<value>

user_name = "<user-name>"              #user to login with
password = "<password>"                #password to login with
api_key = "<api_key>"                  #api key to access cloud platform
```

Initialize your terraform from its corresponding terraform folder using:

```sh
$ terraform init -var-file='../my.auto.tfvars'
```
Provider plugin will be downloaded.

> __NOTE__: On a Windows workstation, to be able using terraform CLI behind the authenticated proxy you MUST define the proxy configuration in your environment variables prior doing the initialization :

```sh
$ set http_proxy=http://<user>:<password>@<authenticated-proxy>:<port>
$ set https_proxy=http://<user>:<password>@<authenticated-proxy>:<port>
$ set no_proxy=127.0.0.1,localhost
```

## Usage

From your terraform folder, plan your deployment using:

```sh
# get the personal variables from parent folder
$ terraform plan -var-file='../my.auto.tfvars' -out my.plan
```

Deploy your plan using:

```sh
$ terraform apply -var-file='../my.auto.tfvars' my.plan
```

Or deploy all the resources by passing variables inline:

```sh
# get the personal variables from parent folder and set any other variable inline
terraform apply -var-file='../my.auto.tfvars' -var <var_name>=<var_value>
```

> __NOTE__: you MUST enter `yes` to validate your action. Use `-auto-approve` to deploy without confirmation.

To delete all the resources:

```sh
terraform destroy
```

Access to client and node:

```sh
# client can be access using <instance_name>.<public_network>.<domain>
ssh user@instance.pub.io
# node can be access internally using <instance_name>.<private_network>.<domain>
dig instance.int.local
```

> __NOTE__: you MUST enter `yes` to validate your action

## Contribute

* Add features: Fork and make a pull request
* Report Bugs: there is no support, but we will be very pleased to review your pull request to fix it.
