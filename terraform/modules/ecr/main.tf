resource "aws_ecr_repository" "webapp" {
  name = "${var.name_prefix}"
}
