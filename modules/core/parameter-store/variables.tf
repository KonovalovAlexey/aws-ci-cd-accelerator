variable "infracost_api_key" {
  description = "The API key for InfraCost integration"
  type        = string
}

variable "cognito_password" {
  description = "The password for DLT Cognito authentication"
  type        = string
}

variable "c7n_password" {
  description = "The password for EPAM Cloud Custodian authentication"
  type        = string
}

variable "c7n_api_url" {
  description = "The API URL for EPAM Cloud Custodian integration"
  type        = string
}

variable "c7n_user" {
  description = "The username for EPAM Cloud Custodian authentication"
  type        = string
}

variable "dojo_api_key" {
  description = "The API key for Dojo integration"
  type        = string
}

variable "openai_token" {
  description = "AI Token"
  type        = string
}