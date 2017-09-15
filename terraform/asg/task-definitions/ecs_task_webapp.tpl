[
  {
    "name": "webapp",
    "image": "${webapp_docker_image}",
    "cpu": 1024,
    "memory": 768,
    "essential": true,
    "portMappings": [
      {
        "containerPort": 5000,
        "hostPort": 3000
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
