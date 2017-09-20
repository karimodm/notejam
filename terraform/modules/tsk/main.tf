resource "aws_ecs_cluster" "webapp_cluster" {
    name = "${var.name_prefix}_webapp_cluster"
}

/* ECS service definition */
resource "aws_ecs_service" "webapp_service" {
    name                               = "${var.name_prefix}_webapp_service"
    cluster                            = "${aws_ecs_cluster.webapp_cluster.id}"
    task_definition                    = "${aws_ecs_task_definition.webapp.arn}"
    desired_count                      = "${var.tasks_desired_count}"
    deployment_minimum_healthy_percent = "${var.minimum_healthy_percent}"
    iam_role                           = "${var.service_role}"

    load_balancer {
        elb_name = "${var.elb_name}"
        container_name = "${var.name_prefix}-webapp"
        container_port = "${var.container_port}"
    }

    lifecycle {
        create_before_destroy = true
        ignore_changes = ["desired_count"]
    }
}

resource "aws_ecs_task_definition" "webapp" {
    family = "${var.name_prefix}_webapp"
    container_definitions = "${var.container_definition_rendered}"

    lifecycle {
        create_before_destroy = true
    }
}
