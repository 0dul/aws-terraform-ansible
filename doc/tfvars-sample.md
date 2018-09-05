# Instance specific variables that MUST NOT be saved to the repository
# the name of this file MUST be pass inline when execturing terraform using '-var-file=my.auto.tfvars'
# any of these variables can be override inline using '-var <varname>=<value>'

aws_region  = "eu-west-3"     # region where will be deployed the instance
aws_profile = "your-profile"  # name of the profile configured to access your instance of AWS; see setup documentation
vpc_cidr    = "10.0.0.0/16"   # wide open, because again this is a lab
cidrs       = {
  public1  = "10.0.1.0/24"
  public2  = "10.0.2.0/24"
  private1 = "10.0.3.0/24"
  private2 = "10.0.4.0/24"
  rds1     = "10.0.5.0/24"
  rds2     = "10.0.6.0/24"
  rds3     = "10.0.7.0/24"
}
local_ip                = "your-ip/mask"        # ip of the local server with terraform
user_data               = "userdata"            # file where will be written userdata config
lc_instance_type        = "t2.micro"            # type of image to use
asg_max                 = "2"                   # max 2 instances should be enought
asg_min                 = "1"                   # keep at least 1 alive
asg_grace               = "300"                 # standard value
asg_type                = "EC2"                 # we are looking for ec2
asg_capacity            = "2"                   # no less than max
elb_healthy_threshold   ="2"                    # standard value
elb_unhealthy_threshold ="2"                    # standard value
elb_timeout             ="3"                    # standard value
elb_interval            ="30"                   # standard value
domain_name             ="your-domain"          # will be used during network configuration
key_name                ="your-ke               # created during setup; see setup documentation
public_key_path         ="~/.ssh/your-key.pub"  # copied manually during setup; see setup documentation
dev_instance_type       ="t2.micro"             # keep it small
dev_ami                 ="ami-0370f4064dbc392b9"  # template that contains image config (os, apps, etc.). get that from aws console if you don't have yours
delegation_set          = "your-set"            # use same service in different domain; see setup documentation
db_instance_class       = "db.t2.micro"         # keep is small
dbname                  = "your-db-name"        # as you see fit
dbuser                  = "your-db-user"        # as you see fit
dbpassword              = "your-db-password"    # as you see fit
