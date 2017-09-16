##
# Some of these variables may be removed from this file if the default value exists
# For better understanding, let's specify all variables explicitly here
##
name_prefix = "notejam"
aws_region = "eu-central-1"
count_webapp = 2
desired_capacity_on_demand = 2
ec2_key_name = "andrea"
instance_type = "t2.nano"
minimum_healthy_percent_webapp = 50

webapp_docker_image_name = "gruntwork/docker-test-webapp"
webapp_docker_image_tag = "latest"
container_port = 3000
