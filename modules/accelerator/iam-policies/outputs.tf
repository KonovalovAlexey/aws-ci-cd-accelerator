
output "codepipeline_role_arn" {
  value = aws_iam_role.codepipeline_role.arn
}
output "codebuild_role_arn" {
  value = aws_iam_role.codebuild_role.arn
}
output "codepipeline_role_name" {
  value = aws_iam_role.codepipeline_role.id
}
#output "codedeploy_role_arn" {
#  value = var.target_type == "ip" || var.target_type == "instance" ? aws_iam_role.codedeploy_role[0].arn : ""
#}


