resource "aws_elb" "main" {
    security_groups = ["${var.security_group}"]
    subnets = ["${split(",", var.subnets)}"]

    listener {
        instance_port = "${var.container_port}"
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 3
        unhealthy_threshold = 3
        timeout = 5
        target = "HTTP:${var.container_port}/${var.http_health_target}"
        interval = 60
    }

    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400
    cross_zone_load_balancing = true

    lifecycle { 
        create_before_destroy = true
    }

    tags {
        Name = "${var.name_prefix}_webapp_elb"
    }
}

resource "aws_lb_cookie_stickiness_policy" "elb_stickiness" {
  name                     = "${var.name_prefix}-elb-stickiness"
  load_balancer            = "${aws_elb.main.id}"
  lb_port                  = 80
  cookie_expiration_period = 1800
}
