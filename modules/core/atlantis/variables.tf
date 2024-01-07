variable "atlantis_name" {
  description = "Name to use on all resources created (VPC, ALB, etc)"
  type        = string
  default     = "atlantis"
}

# VPC
variable "vpc_id" {
  description = "ID of an existing VPC where resources will be created"
  type        = string
}

variable "cidr" {
  description = "The CIDR block for the VPC which will be created if `vpc_id` is not specified"
  type        = string
  default     = ""
}

# Route53
variable "route53_zone_name" {
  description = "Route53 zone name to create ACM certificate in and main A-record, without trailing dot"
  type        = string
}

variable "atlantis_repo_allowlist" {
  description = "List of allowed repositories Atlantis can be used with"
  type        = list(string)
  default     = []
}

# Github
variable "github_user" {
  description = "GitHub username that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "atlantis_github_user_token" {
  description = "GitHub token of the user that is running the Atlantis command"
  type        = string
  default     = ""
}

# Gitlab
variable "gitlab_user" {
  description = "Gitlab username that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "atlantis_gitlab_user_token" {
  description = "Gitlab token of the user that is running the Atlantis command"
  type        = string
  default     = ""
}

# Bitbucket
variable "bitbucket_user" {
  description = "Bitbucket username that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "atlantis_bitbucket_user_token" {
  description = "Bitbucket token of the user that is running the Atlantis command"
  type        = string
  default     = ""
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "public_subnet_ids" {
  type = list(string)
}

variable "aws_account_id" {
  type = string
}

variable "region" {
  type = string
}

variable "atlantis_prefix_list_ids" {
  description = "Prefix lists with IPs for VCS where Terraform code is stored to connect to Atlantis"
  type        = list(string)
  default     = []
}

variable "allowed_prefix_list_ids" {
  description = "Prefix lists with IPs allowed to access to Atlantis"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules of the ALB."
  type        = list(string)
  default     = []
}

variable "github_webhooks_cidr_blocks" {
  description = "List of IPv4 CIDR blocks used by GitHub webhooks"
  # This is hardcoded to avoid dependency on github provider. Source: https://api.github.com/meta
  type    = list(string)
  default = ["140.82.112.0/20", "185.199.108.0/22", "192.30.252.0/22", "143.55.64.0/20"]
}

variable "gitlab_webhooks_cidr_blocks" {
  description = "List of IPv4 CIDR blocks used by GitLab webhooks"
  type        = list(string)
  default     = ["174.128.60.0/24"]
}

variable "bitbucket_webhooks_cidr_blocks" {
  description = "List of IPv4 CIDR blocks used by BitBucket webhooks"
  type        = list(string)
  default     = ["140.82.112.0/20", "185.199.108.0/22", "192.30.252.0/22", "143.55.64.0/20"]
}

variable "c7n_user" {
  type        = string
  description = "C7N User Name"
}

variable "project" {
  type        = string
  description = "Name of Project"
}

