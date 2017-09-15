##
# Some of these variables may be removed from this file if the default value exists
# For better understanding, let's specify all variables explicitly here
##
name_prefix = "notejam"
aws_region = "eu-central-1"
count_webapp = 2
desired_capacity_on_demand = 2
ec2_key_name = "andrea"
instance_type = "t2.micro"
minimum_healthy_percent_webapp = 50

##
# This is a sample (public) Docker image from which can be accessed at https://github.com/docker-training/webapp
# This sample image utilizes Flask and it's not RECOMMENDED to run it directly in production (performance degradation)
# This web server binds to port 5000
##
webapp_docker_image_name = "training/webapp"
webapp_docker_image_tag = "latest"

##
# These variables are required, please fill it out with your environment outputs
##
sg_webapp_elbs_id = "sg-1e26c874"
sg_webapp_instances_id = "sg-d529c7bf"
subnet_ids = "subnet-a48a79cf,subnet-2f427155"

ecs_instance_profile = "arn:aws:iam::713644162845:instance-profile/notejam_ecs_instance_profile"
ecs_service_role = "notejam_ecs_service_role"
