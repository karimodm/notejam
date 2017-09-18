/* Security group */
output "sg_webapp_elbs_id" {
    value = "${aws_security_group.webapp_elbs.id}"
}

output "sg_webapp_instances_id" {
    value = "${aws_security_group.webapp_instances.id}"
}

/* Subnet IDs */
output "subnet_ids" {
    value = "${join(",", aws_subnet.subnet.*.id)}"
}

/* ECR Registry URL for Docker images */
output "ecr_repository_url" {
    value = "${aws_ecr_repository.webapp.repository_url}"
}

output "rds_instance_address" {
    value = "${module.webapp_rds.rds_instance_address}"
}

output "rds_instance_dbname" {
    value = "${module.webapp_rds.rds_instance_dbname}"
}

output "rds_instance_port" {
    value = "${module.webapp_rds.rds_instance_port}"
}
