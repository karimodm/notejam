variable "name_prefix" { }
variable "aws_region" { }
variable "ec2_key_name" { }
variable "instance_type" { }
variable "instance_profile" { }
variable "subnet_ids" {
  type = "string"
}
variable "security_group" {
  type = "string"
}

/* ECS-optimized AMIs per region */
variable "ecs_image_id" {
  # amzn-ami-2017.03.f-amazon-ecs-optimized
  default = {
    eu-west-1      = "ami-4a2c192a"
    eu-central-1   = "ami-0460cb6b"
    us-east-1      = "ami-9eb4b1e5"
  }
}

