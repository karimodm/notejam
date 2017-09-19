variable "db_user" { }
variable "db_pass" { }
variable "instance_class" { }
variable "allocated_storage" { }
variable "multi_az" { }

variable "engine_version" {
    default = "5.6.27"
}

variable "backup_window" {
    default = "03:54-04:24"
}

variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "aws_region" {
    description = "AWS region endpoint to access."
}

variable "environment" {
    value = "stage"
    description = "Environment in the pipeline."
}

provider "aws" {
    region = "${var.aws_region}"
}
