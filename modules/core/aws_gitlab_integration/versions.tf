terraform {
  required_providers {
    gitlab = {
      source  = "gitlabhq/gitlab"
      version = "15.10.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}