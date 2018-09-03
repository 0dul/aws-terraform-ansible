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
