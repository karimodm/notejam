module "webapp_rds" {
  source                = "./rds"
  vpc_id                = "${aws_vpc.main.id}"
  sg-minion             = "${aws_security_group.webapp_instances.id}"
  domain                = "${var.name_prefix}"
  rds_instance_name     = "${var.name_prefix}-webappdb"
  rds_engine_version    = "5.6.27"
  rds_instance_class    = "db.t2.micro"
  rds_allocated_storage = "10"
  rds_is_multi_az       = "true"
  rds_backup_window     = "03:54-04:24"
  database_user         = "sonar"
  database_password     = "yuo1eijue8Asaena"
  database_name         = "${var.name_prefix}"
  db_subnets            = "${join(",", aws_subnet.rds_subnet.*.id)}"
}

resource "aws_subnet" "rds_subnet" {
    count = 2
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "10.0.${count.index + 2}.0/24" /* + 2 to avoid clashing */
    map_public_ip_on_launch = false
    availability_zone = "${var.aws_region}${element(split(",", var.subnet_azs), count.index)}"

    tags {
        Name = "${var.name_prefix}-webapp-rds"
    }
}
