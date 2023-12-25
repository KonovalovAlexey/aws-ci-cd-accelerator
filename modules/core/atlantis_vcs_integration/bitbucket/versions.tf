terraform {
  required_providers {
    bitbucket = {
      source  = "DrFaust92/bitbucket"
      version = "2.20.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}