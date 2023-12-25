output "service_name" {
  value = aws_ecs_service.app_ecs_service[*].name
}
output "cluster_name" {
  value = aws_ecs_cluster.ecs_cluster.name
}
output "ecs_execution_role_arn" {
  value = aws_iam_role.ecs_execution_role.arn
}
output "ecs_task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}
output "log_group_arn" {
  value = aws_cloudwatch_log_group.logs_group[*].arn
}