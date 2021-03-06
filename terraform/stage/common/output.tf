output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}

output "subnets_ids" {
  value = "${module.vpc.subnets_ids}"
}

output "webapp_instances_sg_id" {
  value = "${module.vpc.sg_webapp_instances_id}"
}

output "webapp_elb_sg_id" {
  value = "${module.vpc.sg_webapp_elb_id}"
}

output "ecs_cluster_name" {
  value = "${module.ecs.cluster_name}"
}

output "ecs_instance_profile" {
  value = "${module.iam.ecs_instance_profile}"
}

output "ecs_service_role" {
  value = "${module.iam.ecs_service_role}"
}

output "ecs_autoscaling_role_arn" {
  value = "${module.iam.ecs_autoscaling_role_arn}"
}

output "ecr_repository_url" {
  value = "${module.ecr.ecr_repository_url}"
}

output "autoscaling_asg_policy_down_arn" {
  value = "${module.asg.autoscaling_asg_policy_down_arn}"
}

output "autoscaling_asg_policy_up_arn" {
  value = "${module.asg.autoscaling_asg_policy_up_arn}"
}
