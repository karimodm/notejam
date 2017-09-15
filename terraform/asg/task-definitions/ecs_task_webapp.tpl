[
  {
    "name": "${container_name}",
    "image": "${webapp_docker_image}",
    "cpu": 1024,
    "memory": 400,
    "essential": true,
    "portMappings": [
      {
        "containerPort": ${container_port},
        "hostPort": ${container_port}
      }
    ],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${awslogs_group}",
        "awslogs-region": "${aws_region}",
        "awslogs-stream-prefix": "web"
      }
    },
    "command": [],
    "entryPoint": [],
    "links": [],
    "mountPoints": [],
    "volumesFrom": []
  }
]
