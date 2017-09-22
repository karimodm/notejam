variable "db_user" { }
variable "db_pass" { }
variable "instance_class" { }
variable "allocated_storage" { }
variable "backup_retention_period" { }
variable "multi_az" { }

variable "subnets" {
  type = "list"
}

variable "subnet_azs" {
  type = "string"
  default = "a,b"
}

variable "engine_version" {
    default = "5.6.27"
}

variable "backup_window" {
    default = "03:54-04:24"
}

variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "environment" {
    default = "prod"
    description = "Environment in the pipeline."
}

variable "aws_region" {
    description = "AWS region endpoint to access."
}

provider "aws" {
    region = "${var.aws_region}"
}
