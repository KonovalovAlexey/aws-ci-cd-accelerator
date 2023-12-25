variable "repo_name" {
  type = string
}
variable "codepipeline_arn" {
  type = string
}
variable "codepipeline_name" {
  type = string
}
variable "email_addresses" {
  type = list(string)
}

variable "build_success" {
  description = "If true, you will also get notifications about successful builds"
  type = bool
}
variable "lambda_file" {
  type    = string
  default = "notification_lambda.py"
}

variable "lambda_zip_file" {
  type    = string
  default = "notification_lambda.zip"
}
variable "display_name" {
  type = string
}
variable "region_name" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "security_groups" {
  type = list(string)
}
variable "aws_kms_key" {
  type = string
}

