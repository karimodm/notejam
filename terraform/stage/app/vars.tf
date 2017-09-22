variable "db_user" { }
variable "db_pass" { }

variable "name_prefix" {
    description = "Name prefix for this environment."
}

variable "environment" {
    default = "stage"
}

variable "desired_capacity_on_demand" { }
variable "ec2_key_name" { }
variable "instance_type" { }
variable "minimum_healthy_percent_webapp" {
  default = 50
}
variable "webapp_docker_image_tag" { }
variable "container_port" { }
variable "logs_retention_days" { }
variable "http_health_target" {
  default = "/"
}


variable "aws_region" {
    description = "Determine AWS region endpoint to access."
}

provider "aws" {
    region = "${var.aws_region}"
}
