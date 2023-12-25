# Create CF Stack for tests
# Original solution: https://s3.amazonaws.com/solutions-reference/distributed-load-testing-on-aws/latest/distributed-load-testing-on-aws.template
locals {
  storage_bucket = "${var.storage_bucket_prefix}-${var.project}-${var.region}"
  dlt_dns_name = "dlt-${var.region_name}"
}

module "acm_usa" {
  providers = {
    aws = aws.east
  }
  source            = "../../acm_certificate"
  route53_zone_name = var.route53_zone_name
}
resource "aws_cloudformation_stack" "dlt_test" {
  name         = "DLT-Load-Test-${var.region_name}"
  capabilities = ["CAPABILITY_IAM"]
  template_url = "https://${local.storage_bucket}.s3.${var.region}.amazonaws.com/dlt.yml"

  parameters = {
    DNSAlias         = "${local.dlt_dns_name}.${var.route53_zone_name}"
    ACMCertificate   = module.acm_usa.aws_acm_certificate_arn
    AdminName        = var.admin_name
    AdminEmail       = var.admin_email
    ExistingVPCId    = var.vpc_id
    ExistingSubnetA  = var.private_subnet_ids[0]
    ExistingSubnetB  = var.private_subnet_ids[1]
    VpcCidrBlock     = var.vpc_cidr_block
    SubnetACidrBlock = var.private_subnets[0]
    SubnetBCidrBlock = var.private_subnets[1]
  }
  on_failure = "DELETE"
}

data "aws_cloudfront_distribution" "test" {
  id = aws_cloudformation_stack.dlt_test.outputs.DistributionId
}

data "aws_route53_zone" "poc" {
  name = var.route53_zone_name
}

resource "aws_route53_record" "record" {
  zone_id = data.aws_route53_zone.poc.zone_id
  name    = local.dlt_dns_name
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.test.domain_name
    zone_id                = data.aws_cloudfront_distribution.test.hosted_zone_id
    evaluate_target_health = false
  }
}