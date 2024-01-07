#output "storage_bucket" {
#  value = module.s3_storage_bucket.s3_bucket_id
#}
#
#output "storage_bucket_arn" {
#  value = module.s3_storage_bucket.s3_bucket_arn
#}
output "artifact_bucket_arn" {
  value = module.s3_bucket_artifact.s3_bucket_arn
}
output "artifact_bucket" {
  value = module.s3_bucket_artifact.s3_bucket_id
}
output "aws_kms_key" {
  value = module.kms.key_id
}

output "aws_kms_key_arn" {
  value = module.kms.key_arn
}
output "ecr_repo_name" {
  value = var.target_type != "instance" ? aws_ecr_repository.this[0].name : null
}
