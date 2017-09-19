resource "aws_cloudwatch_log_group" "awslogs_webapp" {
  name = "${var.name_prefix}-webapp"
  retention_in_days = "365"
}
