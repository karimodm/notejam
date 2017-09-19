variable "name_prefix" { }
variable "tasks_desired_count" { }
variable "minimum_healthy_percent" {
  default = 50
}
variable "service_role" { }
variable "elb_name" { }
variable "container_port" { }
variable "container_definition_rendered" { }
