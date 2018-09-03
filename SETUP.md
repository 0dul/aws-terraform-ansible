# Setting up the environment

This setup is a prerequisite to be able configuring and deploying this project's lab environment on AWS cloud platform. It has been tested on `Ubuntu 16.04.5 LTS` only.

> __NOTE__: this is a lab. This MUST NOT be used in a production environment.

The tools listed below have been tested on these versions only, if you want to try newer versions that's up to you.

* python, v2.7.12
* pip, v18.0
* terraform, v0.11.8
* aws-cli, v1.16.6
* ansible, v2.6.3

## Deployment machine setup

The machine used to execute terraform and ansible during the deployment needs to be installed and configured prior working on the lab.

> __NOTE__: installations MUST be done with sudo access, use that power wisely and at your own risks. Don't forget to update the repositories with `apt update` before doing the installations.

### Python, PIP

Install python 2 (version 3 would be a better choice but pip can be a pain with it) and pip

``` sh
# we will work with python 2
apt install python
python --version
# install and upgrade pip
apt install python-pip
pip install --upgrade pip
pip --version
```

### Terraform

Download terraform from [HashiCorp's official repository](https://www.terraform.io/downloads.html), unzip it and add it to the path. 

``` sh
wget https://releases.hashicorp.com/terraform/0.11.8/terraform_0.11.8_linux_amd64.zip
mkdir /bin/terraform
unzip terraform_0.11.8_linux_amd64.zip -d /bin/terraform
export PATH=$PATH:/bin/terraform
terraform --version
```

### AWS cli
Install Amazon Web Services Command Line Interface using PIP

``` sh
pip install awscli --upgrade
aws --version
```

### Ansible
Ansible repository is usually not available by default.

``` sh
# ensure that you can manage repositories
apt install software-properties-common
# add ansible repository and install it
apt-add-repository ppa:ansible/ansible
apt update
apt install ansible
ansible --version
```

### Key management

Generate your private key and add it to the ssh-agent.
The machine will be used to deploy on your cloud platform. To do so, you will need to identified and authorized your client using its key. 

``` sh
# generate key /root/.ssh/<keyname>
ssh-keygen ~/.ssh/<keyname>
ssh-agent bash
ssh-add ~/.ssh/<keyname>
ssh-add -l
```

Because this is a lab and MUST NOT be used in production, we can disable host key checking in ansible configuration.

``` sh
# disable host key checking
vim /etc/ansible/ansible.cfg
# search for SSH key host checking
host_key_checking = False
``` 

### Working environment

Create a working directory from where you'll work

``` sh
mkdir ~/aws-deploy
cd ~/aws-deploy
```

***

## AWS related configuration
Some of the AWS configuration cannot be done using terraform and MUST be done manually via amazon's web console.

### 1. Terraform access
We need to give terraform the permissions it needs to deploy all the resources. A dedicated user SHOULD be created for this task.

* IAM console > Users > create a user new user `terraform` with `programmatic access`.
* Attach existing policies `AdministratorAccess` directly to the user.
* Download credentials for this user (aka. `Download .csv`)

### 2. Configure terraform machine to use AWS
Now that we configured AWS, let's configure the terraform server to use the user's credentials to connect to AWS programmatically.

``` sh
# create a profile specific for this environment
aws configure --profile lab
# enter AWS access key ID obtained during user creation
[ACESS_KEY_ID]
# enter AWS secret key corresponding to the access key
[SECRET_ACCESS_KEY]
# enter default region, closer to your location
eu-west-3
# keep default output format empty
[]
```

### 3. Check your access 
Make sure that you have access to your AWS instance from your terraform machine.

``` sh
# should output JSON with your instances
aws ec2 describe-instances --profile lab
```

This will output at least something like this:
``` json
{
    "Reservations": []
}
```

### 4. Configure Route 53 delegation (optional)
If you have a domain name and want to use it in your configuration, you can configure Route 53 to use it. While RECOMMENDED, this part is optional. If you don't use a domain name you will have to adapt the lab scripts accordingly.

* AWS Route 53 > Registered Domain
* Create a new domain or transfer one that you own already

If you decided to use a domain name, you SHOULD configure the delegation of domain to allow you keeping the same name of service no matter what domain you are using.

``` sh
# create reusable delegation set
aws route53 create-reusable-delegation-set --caller-reference 1234 --profile lab
```

This will output something similar to this, which include the ID you will use to call the service. Make sure to put that aside.
``` json
{
  "Location": "https://route53.amazonws.com/YYYY-MM-DD/delegationset/SET-UNIQUE-ID",
  "DelegationSet": {
    "NameServers": ["server1", "server2"],
    "CallerReference": "1234",
    "Id": "/delegationset/SET-UNIQUE-ID"
  }
}
```

Go back to the AWS console to complete the reusable delegation configuration.

* AWS Route 53 > Registered Domain, select your domain
* On the right, select `Add or edit name servers`
* Add the name of the servers you get in `NameServers` when creating the reusable delegation ("server1", "server2")

> __NOTE__ make sure the same name servers of the hosted zone you are working with match the one from your domain configuration.