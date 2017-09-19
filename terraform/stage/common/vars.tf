variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "aws_region" {
    description = "Determine AWS region endpoint to access."
}

variable "environment" {
    value = "stage"
}

/* Region settings for AWS provider */
provider "aws" {
    region = "${var.aws_region}"
}
