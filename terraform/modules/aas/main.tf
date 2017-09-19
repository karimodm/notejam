resource "aws_appautoscaling_target" "webapp_target" {
  max_capacity       = 10
  min_capacity       = 2
  resource_id        = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  role_arn           = "${var.ecs_autoscaling_role_arn}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = "ecs"
}

resource "aws_appautoscaling_policy" "webapp_tasks_down" {
  adjustment_type         = "ChangeInCapacity"
  cooldown                = 300
  metric_aggregation_type = "Maximum"
  name                    = "webapp_tasks_down"
  resource_id             = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
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
  name                    = "webapp_tasks_up"
  resource_id             = "service/${var.ecs_cluster_name}/${var.ecs_service_name}"
  scalable_dimension      = "ecs:service:DesiredCount"
  service_namespace       = "ecs"

  step_adjustment {
    metric_interval_lower_bound = 0
    scaling_adjustment          = 2
  }

  depends_on = ["aws_appautoscaling_target.webapp_target"]
}