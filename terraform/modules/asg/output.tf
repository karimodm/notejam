output "cloudwatch_metric_alarm_scale_down" {
  value = "${aws_cloudwatch_metric_alarm.cpuaverage_low.id}"
}

output "cloudwatch_metric_alarm_scale_up" {
  value = "${aws_cloudwatch_metric_alarm.cpuaverage_high.id}"
}
