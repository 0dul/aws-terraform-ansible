# Variables to define with their default values; can be override inline using -var <varname>=<value>

variable "aws_region" {}
variable "aws_profile" {}
variable "vpc_cidr" {}

# data populated by aws to get the list of available zones
data "aws_availability_zones" "available" {}

variable "cidrs" {
  type = "map"
}

variable "local_ip" {}
variable "lc_instance_type" {}
variable "user_data" {}
variable "asg_max" {}
variable "asg_min" {}
variable "asg_grace" {}
variable "asg_type" {}
variable "asg_capacity" {}
variable "elb_healthy_treshold" {}
variable "elb_unhealthy_treshold" {}
variable "elb_timeout" {}
variable "elb_interval" {}
variable "domain_name" {}
variable "key_name" {}
variable "public_key_path" {}
variable "dev_instance_type" {}
variable "dev_ami" {}
