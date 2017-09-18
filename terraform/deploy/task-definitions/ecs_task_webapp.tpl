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
    "environment": [
      { "name": "NODE_ENV"   , "value": "production" },
      { "name": "DB_USER"    , "value": "${db_user}" },
      { "name": "DB_PASS"    , "value": "${db_pass}" },
      { "name": "DB_ADDRESS" , "value": "${db_address}" },
      { "name": "DB_DB"      , "value": "${db_db}" }
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
