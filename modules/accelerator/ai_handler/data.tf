data "aws_region" "current" {}

data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "vcs_token" {
  name = "/${var.repo_name}/user/token"
}