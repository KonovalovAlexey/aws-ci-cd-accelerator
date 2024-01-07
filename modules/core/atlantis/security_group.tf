#========================== Atlantis SG ==============================#
locals {
  alb_ingress_cidr_blocks = length(var.atlantis_prefix_list_ids) == 0 ? compact(concat( var.gitlab_user != "" ? var.gitlab_webhooks_cidr_blocks :
  var.github_user != "" ? var.github_webhooks_cidr_blocks :
  var.bitbucket_webhooks_cidr_blocks)) : []
}

#module "security_group_https" {
#  source  = "terraform-aws-modules/security-group/aws"
#  version = "5.1.0"
#
#  name                    = "${var.atlantis_name}-${var.project}-https"
#  use_name_prefix         = false
#  description             = "Security Group for HTTPS ALB-Atlantis interaction"
#  vpc_id                  = var.vpc_id
#  ingress_rules           = ["https-443-tcp"]
#  ingress_cidr_blocks     = compact(concat(local.alb_ingress_cidr_blocks, var.allowed_cidr_blocks))
#  ingress_prefix_list_ids = var.atlantis_prefix_list_ids
#
#  egress_rules = ["all-tcp"]
#}

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                    = "${var.atlantis_name}-${var.project}-http"
  use_name_prefix         = false
  description             = "Security Group for HTTP ALB-Atlantis interaction"
  vpc_id                  = var.vpc_id
  ingress_rules           = ["http-80-tcp"]
  ingress_cidr_blocks     = compact(concat(local.alb_ingress_cidr_blocks, var.allowed_cidr_blocks))
  ingress_prefix_list_ids = var.atlantis_prefix_list_ids

  egress_rules = ["all-tcp"]
}

module "security_group_alowed" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                    = "${var.atlantis_name}-${var.project}-https-allowed"
  use_name_prefix         = false
  description             = "Atlantis security group for ALB https allowed access"
  vpc_id                  = var.vpc_id
  ingress_rules           = ["https-443-tcp"]
  ingress_cidr_blocks     = compact(concat(local.alb_ingress_cidr_blocks, var.allowed_cidr_blocks))
  ingress_prefix_list_ids = var.allowed_prefix_list_ids

  egress_rules = ["all-tcp"]
}