#========================== Atlantis SG ==============================#
locals {
  alb_ingress_cidr_blocks = length(var.atlantis_prefix_list_ids) == 0 ? compact(concat( var.gitlab_user != "" ? var.gitlab_webhooks_cidr_blocks :
  var.github_user != "" ? var.github_webhooks_cidr_blocks :
  var.bitbucket_webhooks_cidr_blocks)) : []
}

# To be created if we define ALB Cidr Block through Prefix List
module "security-group" {
  count   = length(var.atlantis_prefix_list_ids) != 0 ? 1 : 0
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.1.0"

  name                    = "${var.atlantis_name}-${var.project}"
  use_name_prefix         = false
  description             = "Atlantis security group for  HTTPS access"
  vpc_id                  = var.vpc_id
  ingress_prefix_list_ids = var.atlantis_prefix_list_ids
  ingress_rules           = ["https-443-tcp"]
}