# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name    = "accelerator" # This name is used as a part of Terraform State Bucket Name
  aws_account_id  = "" # TODO: replace me with your AWS account ID!
  assume_role_arn = null
}
