resource "aws_ecs_cluster" "webapp_cluster" {
    name = "${var.name_prefix}_webapp_cluster"
}

/* ECS service definition */
resource "aws_ecs_service" "webapp_service" {
    name = "${var.name_prefix}_webapp_service"
    cluster = "${aws_ecs_cluster.webapp_cluster.id}"
    task_definition = "${aws_ecs_task_definition.webapp_definition.arn}"
    desired_count = "${var.count_webapp}"
    deployment_minimum_healthy_percent = "${var.minimum_healthy_percent_webapp}"
    iam_role = "${data.terraform_remote_state.static.ecs_service_role}"

    load_balancer {
        elb_name = "${aws_elb.main.id}"
        container_name = "${var.name_prefix}-webapp"
        container_port = "${var.container_port}"
    }

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_ecs_task_definition" "webapp_definition" {
    family = "${var.name_prefix}_webapp"
    container_definitions = "${data.template_file.task_webapp.rendered}"

    lifecycle {
        create_before_destroy = true
    }
}

data "template_file" "task_webapp" {
    template= "${file("task-definitions/ecs_task_webapp.tpl")}"

    vars {
        container_name = "${var.name_prefix}-webapp"
        awslogs_group = "${aws_cloudwatch_log_group.awslogs-webapp.name}"
        webapp_docker_image = "${var.webapp_docker_image_name}:${var.webapp_docker_image_tag}"
        aws_region = "${var.aws_region}"
        container_port = "${var.container_port}"
    }
}
