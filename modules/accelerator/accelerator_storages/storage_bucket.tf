# Bucket for storing files: for ECS, DLT ect.

# Script for creating deb package
resource "aws_s3_object" "deb_script" {
  count                  = var.target_type == "instance" ? 1 : 0
  bucket                 = local.storage_bucket
  key                    = "pack_to_deb.sh"
  source                 = "${path.module}/storage_bucket_files/pack_to_deb.sh"
  #  etag   = filemd5("${path.module}/storage_bucket_files/pack_to_deb.sh")
  kms_key_id             = module.kms.key_arn
  server_side_encryption = "aws:kms"
  force_destroy          = true
}

locals {
  storage_bucket = "${var.storage_bucket_prefix}-${var.project}-${var.region}"
}