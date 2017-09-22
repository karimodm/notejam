resource "aws_db_subnet_group" "main_db_subnet_group" {
  name        = "${var.rds_instance_name}-private-db"
  description = "RDS subnet group for ${var.rds_instance_name}"
  subnet_ids  = ["${aws_subnet.rds_subnet.*.id}"]
}

resource "aws_subnet" "rds_subnet" {
    count                   = 2
    vpc_id                  = "${var.vpc_id}"
    cidr_block              = "${element(var.subnets, count.index)}"
    map_public_ip_on_launch = false
    availability_zone       = "${var.aws_region}${element(split(",", var.subnets_azs), count.index)}"

    tags {
        Name = "${var.name_prefix}-webapp-rds"
    }
}
