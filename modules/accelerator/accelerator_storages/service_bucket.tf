# Bucket for storing files: for ECS, DLT ect.

# Script for creating deb package
resource "aws_s3_object" "deb_script" {
  count                  = var.target_type == "instance" ? 1 : 0
  bucket                 = module.s3_bucket_service[0].s3_bucket_id
  key                    = "pack_to_deb.sh"
  source                 = "${path.module}/storage_bucket_files/pack_to_deb.sh"
  kms_key_id             = module.kms.key_arn
  server_side_encryption = "aws:kms"
  force_destroy          = true
}

locals {
  service_bucket = "${var.service_bucket_prefix}-${var.project}-${var.region}"
}

module "s3_bucket_service" {
  count = var.target_type == "instance" || var.target_type == "ip" ? 1 : 0
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.15.1"

  bucket                                = local.service_bucket
  policy                                = data.aws_iam_policy_document.s3_artifact.json
  force_destroy                         = var.force_destroy
  attach_policy                         = true
  attach_deny_insecure_transport_policy = true
  server_side_encryption_configuration  = {
    rule = {
      apply_server_side_encryption_by_default = {
        kms_master_key_id = module.kms.key_arn
        sse_algorithm     = "aws:kms"
      }
    }
  }
  versioning = {
    enabled    = true
    mfa_delete = false
  }
  lifecycle_rule = [
    {
      id                            = "service"
      enabled                       = true
      noncurrent_version_transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
          storage_class = "ONEZONE_IA"
        },
        {
          days          = 90
          storage_class = "GLACIER"
        },
      ]
      noncurrent_version_expiration = {
        days = 300
      }
    }
  ]
}