resource "aws_appautoscaling_target" "webapp_target" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${var.cluster_id}/${var.service_name}"
  role_arn           = "${var.autoscaling_role_arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "webapp_tasks_down" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  metric_aggregation_type = "Maximum"
  name                    = "${var.service_name}-webapp_tasks_down"
  resource_id             = "service/${var.cluster_id}/${var.service_name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_upper_bound = 0
    scaling_adjustment          = -2
  }

  depends_on = ["aws_appautoscaling_target.webapp_target"]
}

resource "aws_appautoscaling_policy" "webapp_tasks_up" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  metric_aggregation_type = "Maximum"
  name                    = "${var.service_name}-webapp_tasks_up"
  resource_id             = "service/${var.cluster_id}/${var.service_name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = 2
  }

  depends_on = ["aws_appautoscaling_target.webapp_target"]
}

resource "aws_cloudwatch_metric_alarm" "cpuaverage_high" {
    alarm_name          = "${var.service_name}-task-cpuaverage_high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "60"
    statistic           = "Average"
    threshold           = "70"

    alarm_description = "This metric monitors Average CPU Utilization over 2 minutes"
    alarm_actions     = ["${list(var.autoscaling_asg_policy_up_arn, aws_appautoscaling_policy.webapp_tasks_up.arn)}"]
}

resource "aws_cloudwatch_metric_alarm" "cpuaverage_low" {
    alarm_name          = "${var.service_name}-task-cpuaverage_low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods  = "2"
    metric_name         = "CPUUtilization"
    namespace           = "AWS/EC2"
    period              = "60"
    statistic           = "Average"
    threshold           = "20"

    alarm_description = "This metric monitors Average CPU Utilization over 2 minutes"
    alarm_actions     = ["${list(var.autoscaling_asg_policy_down_arn, aws_appautoscaling_policy.webapp_tasks_down.arn)}"]
}
