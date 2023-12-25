variable "storage_bucket_prefix" {
  description = "The prefix to be used for naming storage buckets"
  type        = string
}

variable "aws_account_id" {
  description = "The AWS account ID where the infrastructure will be deployed"
  type        = string
}

variable "region" {
  description = "The AWS region to deploy the infrastructure into"
  type        = string
}

variable "project" {
  description = "The project name used for resource tagging and naming"
  type        = string
}