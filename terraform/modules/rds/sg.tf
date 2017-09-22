# Default Security Group for DB instances
resource "aws_security_group" "db" {
  name        = "${var.rds_instance_name}-db"
  description = "Security Group for ${var.rds_instance_name}"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${var.sg-minion}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${var.vpc_id}"
}
