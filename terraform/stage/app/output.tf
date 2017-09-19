output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "webapp_instances_sg_id" {
  value = "${module.vpc.sg_webapp_instances_id}"
}
