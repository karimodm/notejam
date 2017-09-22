variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "autoscaling_min_size" { }
variable "autoscaling_max_size" { }
variable "ec2_key_name" { }
variable "ec2_instance_type" { }

variable "subnets_azs" { }

variable "environment" {
    default = "prod"
}

variable "aws_region" {
    description = "Determine AWS region endpoint to access."
}

provider "aws" {
    region = "${var.aws_region}"
}
