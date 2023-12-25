provider "github" {
  alias    = "ai_webhook"
  base_url = var.github_base_url
  token    = data.aws_ssm_parameter.vcs_token.value
  owner    = var.organization_name
}

resource "github_repository_webhook" "ai_handler" {
  provider    = github.ai_webhook
  repository = var.repo_name

  configuration {
    url          = aws_lambda_function_url.webhook_url.function_url
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["issue_comment"]
}