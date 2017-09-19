output "rds_instance_id" {
  value = "${module.webapp_rds.rds_instance.id}"
}

output "rds_instance_address" {
  value = "${module.webapp_rds.rds_instance.address}"
}

output "rds_instance_dbname" {
  value = "${module.webapp_rds.rds_instance.name}"
}
