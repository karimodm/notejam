name_prefix = "notejam"
aws_region = "eu-central-1"
desired_capacity_on_demand = 2
ec2_key_name = "andrea"
logs_retention_days = 7

# Image will be pulled from notejam ECR repo
webapp_docker_image_tag = "latest"
http_health_target = "/signup"
container_port = 3000
