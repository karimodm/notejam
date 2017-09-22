output "instance_id" {
  value = "${module.rds.rds_instance_id}"
}

output "instance_address" {
  value = "${module.rds.rds_instance_address}"
}

output "instance_dbname" {
  value = "${module.rds.rds_instance_dbname}"
}
