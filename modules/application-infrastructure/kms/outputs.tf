output "kms_key_id" {
  value = module.kms.key_id
}
output "kms_key_arn" {
  value = module.kms.key_arn
}
#output "artifact_bucket_id" {
#  value = module.s3-bucket.s3_bucket_id
#}
#output "artifact_bucket_arn" {
#  value = module.s3-bucket.s3_bucket_arn
#}