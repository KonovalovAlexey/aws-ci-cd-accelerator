#=============================== GitHub Variables ==========================#
variable "atlantis_url_events" {
  description = "The URL for handling Atlantis events on GitHub"
  type        = string
}

variable "atlantis_github_user_token" {
  description = "GitHub token to use when creating a webhook"
  type        = string
}

variable "organization_name" {
  description = "GitHub organization name to use when creating a webhook"
  type        = string
}

variable "infra_repo_name" {
  description = "The name of the infrastructure repository on GitHub"
  type        = string
}

variable "atlantis_webhook_secret" {
  description = "The secret used for securing Atlantis webhook communication on GitHub"
  type        = string
}

variable "github_base_url" {
  description = "GitHub base URL to use when creating a webhook (for GitHub Enterprise users)"
  type        = string
  default     = null
}