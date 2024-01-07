provider "github" {
  base_url = var.github_base_url
  token    = var.atlantis_github_user_token
  owner    = var.github_owner
}

resource "github_repository_webhook" "this" {
  count = length(var.repo_names)

  repository = var.repo_names[count.index]

  configuration {
    url          = var.atlantis_url_events
    content_type = "application/json"
    insecure_ssl = false
    secret       = var.atlantis_webhook_secret
  }

  events = [
    "issue_comment",
    "pull_request",
    "pull_request_review",
    "pull_request_review_comment",
  ]
}