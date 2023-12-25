#=================================== Bitbucket Variables ===========================#
variable "bitbucket_user" {
  description = "The Bitbucket username associated with the Atlantis command"
  type        = string
}

variable "atlantis_bitbucket_user_token" {
  description = "The Bitbucket token for the user running the Atlantis command"
  type        = string
}

variable "atlantis_bitbucket_base_url" {
  description = "The base URL of the Bitbucket Server, used for on-premises Bitbucket installations (formerly Stash)"
  type        = string
}

variable "infra_repo_name" {
  description = "The name of the infrastructure repository"
  type        = string
}

variable "atlantis_webhook_secret" {
  description = "The secret used for securing Atlantis webhook communication"
  type        = string
}

variable "atlantis_url_events" {
  description = "The URL for handling Atlantis events"
  type        = string
}