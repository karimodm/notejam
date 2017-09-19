module "iam" {
  source      = '../modules/iam'
  name_prefix = "${var.name_prefix}-${var.environment}"
}

module "vpc" {
  source      = "../modules/vpc"
  name_prefix = "${var.name_prefix}-${var.environment}"
  aws_region  = "${var.aws_region}"
  subnets_azs = "${var.subnets_azs}"
}

module "ecr" {
  source      = "../modules/ecr"
  name_prefix = "${var.name_prefix}-${var.environment}"
}

module "ecs" {
  source      = "../modules/ecs"
  name_prefix = "${var.name_prefix}-${var.environment}"
}

module "asg" {
  source           = "../modules/asg"
  name_prefix      = "${var.name_prefix}-${var.environment}"
  aws_region       = "${var.aws_region}"
  ec2_key_name     = "${var.ec2_key_name}"
  instance_type    = "${var.ec2_instance_type}"
  instance_profile = "${module.iam.ecs_instance_profile}"
  subnet_ids       = "${module.vpc.subnet_ids}"
  security_group   = "${module.vpc.sg_webapp_instances_id}"
  cluster_name     = "${module.ecs.cluster_name}"
  group_min_size = "${var.autoscaling_min_size}"
  group_max_size = "${var.autoscaling_max_size}"
}
