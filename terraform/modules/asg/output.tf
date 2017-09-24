output "autoscaling_asg_policy_down_arn" {
  value = "${aws_autoscaling_policy.webapp_scale_down.arn}"
}

output "autoscaling_asg_policy_up_arn" {
  value = "${aws_autoscaling_policy.webapp_scale_up.arn}"
}
