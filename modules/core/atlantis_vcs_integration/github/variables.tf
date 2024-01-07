#=============================== GitHub Variables ==========================#
variable "atlantis_url_events" {
  description = "The URL for handling Atlantis events on GitHub"
  type        = string
}

variable "atlantis_github_user_token" {
  description = "GitHub token to use when creating a webhook"
  type        = string
}

variable "github_owner" {
  description = "GitHub owner name to use when creating a webhook"
  type        = string
}

variable "repo_names" {
  description = "The name of the infrastructure repositories on GitHub"
  type        = list(string)
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