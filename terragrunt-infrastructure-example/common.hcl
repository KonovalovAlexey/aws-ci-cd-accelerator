locals {
  # Define variables to form Terraform State Bucket
  project                = ""
  backend_bucket_prefix  = "backend"
  # Define prefixes for ci/cd buckets
  artifact_bucket_prefix = "codepipeline-artifacts"
  storage_bucket_prefix  = "storage-bucket"
  service_bucket_prefix  = "service-bucket"
  default_tags           = {
    Project    = local.project
    Team       = "DevOps",
    DeployedBy = "Terragrunt",
    OwnerEmail = "devops@example.com"
    Terraform  = "true"
  }
}