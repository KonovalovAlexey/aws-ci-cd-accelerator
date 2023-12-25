module "vpc" {
  count               = var.vpc_create ? 1 : 0
  source              = "../../core/vpc"
  project             = var.project
  enable_nat_gateway  = var.enable_nat_gateway
  external_nat_ip_ids = var.external_nat_ip_ids
  reuse_nat_ips       = var.reuse_nat_ips
  single_nat_gateway  = var.single_nat_gateway
  egress_cidr_blocks  = var.egress_cidr_blocks
  nat_prefix_list_ids = var.nat_prefix_list_ids
}
module "kms" {
  count             = var.target_type == "ip" ? 1 : 0
  source            = "../kms"
  key_service_users = var.key_service_users
  key_users         = var.key_users
  region            = var.region
  repo_name         = var.repo_name
}
module "acm_certificate" {
  source            = "../../acm_certificate"
  route53_zone_name = var.route53_zone_name
}

module "alb" {
  source                  = "../alb_deploy"
  environments            = var.environments
  repo_name               = var.repo_name
  health_path             = var.health_path
  project                 = var.project
  route53_zone_name       = var.route53_zone_name
  vpc_id                  = var.vpc_create ? module.vpc[0].vpc_id : var.vpc_id
  public_subnet_ids       = var.vpc_create ? module.vpc[0].public_subnets : var.public_subnet_ids
  target_type             = var.target_type
  aws_acm_certificate_arn = module.acm_certificate.aws_acm_certificate_arn
  target_port             = var.application_port
  allowed_cidr_blocks     = var.allowed_cidr_blocks
  allowed_prefix_list_ids = var.allowed_prefix_list_ids
  egress_cidr_blocks      = var.egress_cidr_blocks
  dns_record_names        = var.dns_record_names
  region                  = var.region
  region_name             = var.region_name
  nat_security_group_id   = var.vpc_create ? module.vpc[0].vpc_nat_security_group : var.nat_security_group_id
}

module "asg" {
  count                  = var.target_type == "instance" ? 1 : 0
  source                 = "../autoscaling_groups"
  repo_name              = var.repo_name
  elb_target_group_arn   = module.alb.target_group_arn
  lb_id                  = module.alb.alb_id
  asg_security_groups    = compact(concat([module.alb.security_group_self_port], var.additional_security_groups))
  private_subnet_ids     = var.vpc_create ? module.vpc[0].private_subnets : var.private_subnet_ids
  instance_type          = var.instance_type
  desired_capacity       = var.desired_capacity
  max_size               = var.max_size
  min_size               = var.min_size
  environments           = var.environments
  artifact_bucket_prefix = var.artifact_bucket_prefix
  region                 = var.region
  project                = var.project
}


module "ecs" {
  count                  = var.target_type == "ip" ? 1 : 0
  source                 = "../ecs"
  region                 = var.region
  repo_name              = var.repo_name
  vpc_id                 = var.vpc_create ? module.vpc[0].vpc_id : var.vpc_id
  ecs_security_groups    = compact(concat([module.alb.security_group_self_port], var.additional_security_groups))
  private_subnet_ids     = var.vpc_create ? module.vpc[0].private_subnets : var.private_subnet_ids
  container_name         = var.container_name
  cpu                    = var.cpu
  desired_capacity       = var.desired_capacity
  application_port       = var.application_port
  environments           = var.environments
  memory                 = var.memory
  target_group_blue_arn  = module.alb.target_group_blue_arn
  aws_account_id         = var.aws_account_id
  aws_kms_arn            = module.kms[0].kms_key_arn
  ecr_repo_name          = var.ecr_repo_name
  accelerator_account_id = var.accelerator_account_id
  accelerator_region     = var.accelerator_region
}

module "codedeploy" {
  source                  = "../codedeploy"
  asg_name                = var.target_type == "instance" ? module.asg[0].asg_name : null
  conf_all_at_once        = var.conf_all_at_once
  conf_one_at_time        = var.conf_one_at_time
  desired_capacity        = var.desired_capacity
  ecs_cluster_name        = var.target_type == "ip" ? module.ecs[0].cluster_name : null
  ecs_service_name        = var.target_type == "ip" ? module.ecs[0].service_name : null
  environments            = var.environments
  main_listener           = module.alb.main_listener
  repo_name               = var.repo_name
  target_group_blue_name  = var.target_type == "ip" ? module.alb.target_group_blue_name : null
  target_group_green_name = var.target_type == "ip" ? module.alb.target_group_green_name : null
  target_type             = var.target_type
  codedeploy_role_names   = var.codedeploy_role_names
  codedeploy_role_arns    = var.codedeploy_role_arns
  artifact_bucket_prefix  = var.artifact_bucket_prefix
  region                  = var.region
  codedeploy_role_create  = var.codedeploy_role_create
  accelerator_account_id = var.accelerator_account_id
}

