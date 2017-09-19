variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "aws_region" {
    description = "Determine AWS region endpoint to access."
}

variable "autoscaling_min_size" { }
variable "autoscaling_max_size" { }

variable "environment" {
    value = "stage"
}

variable "subnets_azs" { }

/* Region settings for AWS provider */
provider "aws" {
    region = "${var.aws_region}"
}
