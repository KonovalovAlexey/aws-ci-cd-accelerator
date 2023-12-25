# Set common variables for the environment. This is automatically pulled in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  #========================== VPC =========================#
  cidr                     = "10.0.0.0/16"
  enable_nat_gateway       = true
  single_nat_gateway       = true
  reuse_nat_ips            = true
  external_nat_ip_ids      = [] # Reserved Elastic IP (The parameter is required only when reuse_nat_ips = true).
  nat_prefix_list_ids      = [] # Prefix List IDs for access to NAT.
  atlantis_prefix_list_ids = [] # Prefix List IDs for access to Atlantis
  #======================= Atlantis ========================#
  allowed_cidr_blocks      = [local.cidr] # to avoid creating Atlantis SG Ingress Rule with 0.0.0.0/0
  atlantis_name            = "atlantis"
  repo_whitelist           = []
  route53_zone_name        = "" # Route53 zone name for the project.
  #========================= DLT ===========================#
  dlt_create               = true
  admin_name               = ""
  admin_email              = ""
}
