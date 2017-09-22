module "elb" {
  source             = "../../modules/elb"
  name_prefix        = "${var.name_prefix}-${var.environment}"
  container_port     = "${var.container_port}"
  security_group     = "${data.terraform_remote_state.common.webapp_elb_sg_id}"
  http_health_target = "${var.http_health_target}"
  subnets            = "${data.terraform_remote_state.common.subnets_ids}"
}

module "log" {
  source         = "../../modules/log"
  name_prefix    = "${var.name_prefix}-${var.environment}"
  retention_days = "${var.logs_retention_days}"
}

module "tsk" {
  source                        = "../../modules/tsk"
  name_prefix                   = "${var.name_prefix}-${var.environment}"
  container_name                = "${var.name_prefix}-${var.environment}-webapp"
  cluster_id                    = "${data.terraform_remote_state.common.ecs_cluster_name}"
  tasks_desired_count           = "${var.desired_capacity_on_demand}"
  minimum_healthy_percent       = "${var.minimum_healthy_percent_webapp}"
  service_role                  = "${data.terraform_remote_state.common.ecs_service_role}"
  elb_name                      = "${module.elb.elb_name}"
  container_port                = "${var.container_port}"
  container_definition_rendered = "${data.template_file.task_webapp.rendered}"
}

module "aas" {
  source                             = "../../modules/aas"
  service_name                       = "${module.tsk.ecs_service_name}"
  cluster_id                         = "${data.terraform_remote_state.common.ecs_cluster_name}"
  autoscaling_role_arn               = "${data.terraform_remote_state.common.ecs_autoscaling_role_arn}"
}

data "template_file" "task_webapp" {
    template = "${file("task-definitions/ecs_task_webapp.tpl")}"

    vars {
        container_name      = "${var.name_prefix}-${var.environment}-webapp"
        awslogs_group       = "${module.log.awslogs_group}"
        webapp_docker_image = "${data.terraform_remote_state.common.ecr_repository_url}:${var.webapp_docker_image_tag}"
        db_user             = "${var.db_user}"
        db_pass             = "${var.db_pass}"
        db_address          = "${data.terraform_remote_state.db.instance_address}"
        db_db               = "${data.terraform_remote_state.db.instance_dbname}"
        aws_region          = "${var.aws_region}"
        container_port      = "${var.container_port}"
    }
}
