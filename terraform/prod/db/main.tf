module "rds" {
  source                   = "../../modules/rds"
  vpc_id                   = "${data.terraform_remote_state.common.vpc_id}"
  sg-minion                = "${data.terraform_remote_state.common.webapp_instances_sg_id}"
  rds_instance_name        = "${var.name_prefix}-${var.environment}"
  rds_engine_version       = "${var.engine_version}"
  rds_instance_class       = "${var.instance_class}"
  rds_allocated_storage    = "${var.allocated_storage}"
  rds_is_multi_az          = "${var.multi_az}"
  rds_backup_window        = "${var.backup_window}"
  rds_bkp_retention_period = "${var.backup_retention_period}"
  database_user            = "${var.db_user}"
  database_password        = "${var.db_pass}"
  database_name            = "${var.name_prefix}"
  db_subnets               = "${join(",", aws_subnet.rds_subnet.*.id)}"
}

/* Not modular to avoid clashing */
resource "aws_subnet" "rds_subnet" {
    count                   = 2
    vpc_id                  = "${data.terraform_remote_state.common.vpc_id}"
    cidr_block              = "${element(var.subnets, count.index)}"
    map_public_ip_on_launch = false
    availability_zone       = "${var.aws_region}${element(split(",", var.subnet_azs), count.index)}"

    tags {
        Name = "${var.name_prefix}-webapp-rds"
    }
}
