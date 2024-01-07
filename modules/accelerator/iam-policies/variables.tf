variable "project" {
  type = string
}
variable "region_name" {
  type = string
}
variable "aws_account_id" {
  type = string
}
variable "repo_name" {
  type = string
}
variable "region" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}

variable "target_type" {
  type = string
}
variable "eks_role_arn" {
  type = string
}
variable "service_bucket_arn" {
  type = string
}

variable "codedeploy_role_arns" {
  type = list(string)
}
variable "stages" {
  description = "Map of stage settings"
  type = map(object({
    account      = string
    regions      = list(string)
    region_names = list(string)
  }))
}
variable "artifact_bucket_prefix" {
  type = string
}