resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.rds_instance_name}-private-db"
  description = "RDS subnet group for ${var.rds_instance_name}"
  subnet_ids  = ["${split(",", var.db_subnets)}"]
}
