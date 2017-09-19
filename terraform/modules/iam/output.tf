output "ecs_instance_profile" {
        value = "${aws_iam_instance_profile.ecs_instance_profile.arn}"
}

output "ecs_service_role" {
        value = "${aws_iam_role.ecs_service_role.name}"
}

output "ecs_autoscaling_role_arn" {
        value = "${aws_iam_role.ecs_autoscaling_role.arn}"
}
