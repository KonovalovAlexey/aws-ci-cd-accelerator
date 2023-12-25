#=============================== Atlantis Variables ==========================#
variable "atlantis_url_events" {
  description = "The URL for handling Atlantis events on Git platforms"
  type        = string
}

variable "atlantis_webhook_secret" {
  description = "The secret used for securing Atlantis webhook communication on Git platforms"
  type        = string
}

#==================================== GitLab Variables =======================#
variable "atlantis_gitlab_user_token" {
  description = "The GitLab user token for Atlantis integration"
  type        = string
  sensitive   = true
}

variable "atlantis_gitlab_hostname" {
  description = "The GitLab hostname"
  type        = string
}

variable "project_id" {
  description = "The GitLab project identifier"
  type        = string
}