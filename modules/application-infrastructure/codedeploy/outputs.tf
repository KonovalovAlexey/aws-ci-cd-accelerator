output "application_name" {
  value = aws_codedeploy_app.application.name
}
output "deployment_group_name_ec2" {
  value = var.target_type == "instance" ? aws_codedeploy_deployment_group.ec2.*.deployment_group_name : null
}
output "deployment_group_name_ecs" {
  value = var.target_type == "ip" ? aws_codedeploy_deployment_group.ecs.*.deployment_group_name : null
}
output "codedeploy_role_name" {
  value = var.codedeploy_role_create ? aws_iam_role.codedeploy_role.*.name : null
}
output "codedeploy_role_arn" {
  value = var.codedeploy_role_create ? aws_iam_role.codedeploy_role.*.arn : null
}