variable "name" {
  default     = "openvpn"
  description = "OpenVPN instance name"
}

variable "vpc_id" {
default = "vpc-0325a3e6f5d716e35"
description = "ID of the VPC to use"
}

variable "vpc_cidr" {
default = "172.31.0.0/16"
description = "VPC CIDRs to use"
}


variable "public_subnet_ids" {
default = "subnet-092e82366475f1e18"
description = "Public Subnet IDs"
}

variable "route_zone_id" {
  default = "Z06783201VDZC42IU78MC"
  description = "Route Zone ID"
}

variable "domain" {
default = "cmcloudlab533.info"
description = "Public domain to assign to the openVPN host. With a value of 'example.com' The resulting value will be 'vpn.example.com"
}


variable "instance_type" {
default = "t2.micro"
description = "OPenVPN EC2 instance type"
}


variable "key_name" {
default = "sahib"
description = "Key Pair name"
}


variable "ebs_region" {
  default = "us-east-1"
  description = "Region for the EBS volume where we'll store credentials and certificates"
}

variable "ebs_size" {
  default = "40"
  description = "EBS volume size. 1GB should be fine in most cases"
}

variable "ami" {
default = "ami-048fecde5d7a46912" 
description = "AMI ID to use for the EC2 instance"
}
