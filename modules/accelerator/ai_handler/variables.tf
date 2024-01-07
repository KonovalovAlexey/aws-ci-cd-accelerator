variable "region_name" {
  type = string
}
variable "repo_name" {
  description = "The name of the GitHub/Bitbucket/CodeCommit repository (e.g. new-repo)."
  type        = string
}
variable "build_timeout" {
  description = "The time to wait for a CodeBuild to complete before timing out in minutes (default: 5)"
  type        = string
  default     = "10"
}
variable "connection_provider" {
  type        = string
  description = "Valid values are Bitbucket, GitHub, or GitHubEnterpriseServer."
}
variable "organization_name" {
  description = "The organization name for Sonar"
  type        = string
}
variable "bitbucket_user" {
  description = "Bitbucket User Name"
  type        = string
  default     = ""
}

variable "github_base_url" {
  description = "GitHub base URL to use when creating a webhook (for GitHub Enterprise users)"
  type        = string
  default     = null
}
variable "llm_model" {
  description = "LLM Model for AI"
  type        = string
}
variable "openai_api_endpoint" {
  type        = string
  description = "Open AI Endpoint"
}
variable "openai_token_name" {
  type        = string
  description = "Parameter Store Variable Name for OPEN AI API KEY"
}
variable "github_token_name" {
  type        = string
  description = "Parameter Store Variable Name for GitHub"
}
variable "github_token" {
  type        = string
  description = "GitHub Token"
}
