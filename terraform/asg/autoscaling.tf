resource "aws_launch_configuration" "webapp_on_demand" {
    instance_type = "${var.instance_type}"
    image_id = "${lookup(var.ecs_image_id, var.aws_region)}"
    iam_instance_profile = "${data.terraform_remote_state.static.ecs_instance_profile}"
    user_data = "${data.template_file.autoscaling_user_data.rendered}"
    key_name = "${var.ec2_key_name}"
    security_groups = ["${data.terraform_remote_state.common.sg_webapp_instances_id}"]
    associate_public_ip_address = true

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "webapp_on_demand" {
    name = "${var.name_prefix}_webapp_on_demand"
    max_size = 10
    min_size = 2
    desired_capacity = "${var.desired_capacity_on_demand}" 
    health_check_grace_period = 300
    health_check_type = "EC2"
    force_delete = true
    launch_configuration = "${aws_launch_configuration.webapp_on_demand.name}"
    vpc_zone_identifier = ["${data.terraform_remote_state.common.subnet_ids}"]

    tag {
        key = "Name"
        value = "${var.name_prefix}-webapp-on-demand"
        propagate_at_launch = true
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_autoscaling_policy" "webapp_scale_up" {
    name = "${var.name_prefix}_webapp_scale_up"
    scaling_adjustment = 2
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.webapp_on_demand.name}"
}

resource "aws_autoscaling_policy" "webapp_scale_down" {
    name = "${var.name_prefix}_webapp_scale_down"
    scaling_adjustment = -2
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.webapp_on_demand.name}"
}

resource "aws_cloudwatch_metric_alarm" "cpuaverage_high" {
    alarm_name = "cpuaverage_high"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "70"

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.webapp_on_demand.name}"
    }

    alarm_description = "This metric monitors Average CPU Utilization over 2 minutes"
    alarm_actions     = ["${aws_autoscaling_policy.webapp_scale_up.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "cpuaverage_low" {
    alarm_name = "cpuaverage_low"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "20"

    dimensions {
        AutoScalingGroupName = "${aws_autoscaling_group.webapp_on_demand.name}"
    }

    alarm_description = "This metric monitors Average CPU Utilization over 2 minutes"
    alarm_actions     = ["${aws_autoscaling_policy.webapp_scale_down.arn}"]
}

data "template_file" "autoscaling_user_data" {
    template = "${file("autoscaling_user_data.tpl")}"
    vars {
        ecs_cluster = "${aws_ecs_cluster.webapp_cluster.name}"
    }
}
