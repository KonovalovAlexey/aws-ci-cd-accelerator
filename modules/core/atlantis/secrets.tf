resource "aws_ssm_parameter" "atlantis_github_user_token" {
  count       = var.atlantis_github_user_token == "" ? 0 : 1
  name        = "/atlantis/github/user/token"
  description = "GitHub Token"
  type        = "SecureString"
  value       = var.atlantis_github_user_token
#  overwrite   = true
}

resource "aws_ssm_parameter" "atlantis_gitlab_user_token" {
  count       = var.atlantis_gitlab_user_token == "" ? 0 : 1
  name        = "/atlantis/gitlab/user/token"
  description = "GitLab Token"
  type        = "SecureString"
  value       = var.atlantis_gitlab_user_token
#  overwrite   = true
}

resource "aws_ssm_parameter" "atlantis_bitbucket_user_token" {
  count       = var.atlantis_bitbucket_user_token == "" ? 0 : 1
  name        = "/atlantis/bitbucket/user/token"
  description = "Bitbucket Token"
  type        = "SecureString"
  value       = var.atlantis_bitbucket_user_token
}

resource "aws_ssm_parameter" "atlantis_webhook_secret" {
  name        = "/atlantis/webhook/secret"
  description = "Atlantis webhook secret"
  type        = "SecureString"
  value       = random_password.webhook_secret.result
}