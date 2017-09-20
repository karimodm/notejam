output "instance_id" {
  value = "${module.webapp_rds.rds_instance.id}"
}

output "instance_address" {
  value = "${module.webapp_rds.rds_instance.address}"
}

output "instance_dbname" {
  value = "${module.webapp_rds.rds_instance.name}"
}
