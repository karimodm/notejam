variable "name_prefix" { }
variable "container_port" { }
variable "security_group" { }
variable "http_health_target" {
  default = "/"
}
variable "subnets" {
  type = "string"
}
