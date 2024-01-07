locals {
}

data "aws_route53_zone" "selected" {
  name         = var.route53_zone_name
  private_zone = false
}


module "atlantis" {
  source  = "terraform-aws-modules/atlantis/aws"
  version = "4.0.8"

  name = var.atlantis_name

  # ECS Container Definition
  atlantis = {
    image = "${aws_ecr_repository.atlantis.repository_url}:latest"
    environment = [
      {
        name  = "ATLANTIS_GH_USER"
        value = var.github_user
      },
      {
        name  = "ATLANTIS_GITLAB_USER"
        value = var.gitlab_user
      },
      {
        name  = "ATLANTIS_BITBUCKET_USER"
        value = var.bitbucket_user
      },
      {
        name  = "ATLANTIS_REPO_ALLOWLIST"
        value = join(",", var.atlantis_repo_allowlist)
      },
      {
        name  = "ATLANTIS_ENABLE_DIFF_MARKDOWN_FORMAT"
        value = "true"
      },
      {
        name : "ATLANTIS_REPO_CONFIG_JSON",
        value : jsonencode(yamldecode(file("${path.module}/repos.yaml")))
      },
      {
        name  = "CUSTODIAN_ROLE"
        value = var.c7n_user != "" ? "arn:aws:iam::${var.aws_account_id}:role/Read-Only-Access-For-Custodian-${var.region}" : ""
      },
    ]
    secrets = [
      {
        name      = var.atlantis_github_user_token != "" ? "ATLANTIS_GH_WEBHOOK_SECRET" : (var.atlantis_gitlab_user_token != "" ? "ATLANTIS_GITLAB_WEBHOOK_SECRET" : "ATLANTIS_BITBUCKET_WEBHOOK_SECRET")
        valueFrom = aws_ssm_parameter.atlantis_webhook_secret.arn
      },
      {
        name      = var.atlantis_github_user_token != "" ? "ATLANTIS_GH_TOKEN" : (var.atlantis_gitlab_user_token != "" ? "ATLANTIS_GITLAB_TOKEN" : "ATLANTIS_BITBUCKET_TOKEN")
        valueFrom = var.atlantis_github_user_token != "" ? aws_ssm_parameter.atlantis_github_user_token[0].arn : (var.atlantis_gitlab_user_token != "" ? aws_ssm_parameter.atlantis_gitlab_user_token[0].arn : aws_ssm_parameter.atlantis_bitbucket_user_token[0].arn)
      },
#      {
#        name      = var.openai_token != "" ? "OPENAI_TOKEN" : null
#        valueFrom = var.openai_token_arn
#      },
      {
        name      = var.atlantis_github_user_token != "" ? "GITHUB_TOKEN" : null
        valueFrom = var.atlantis_github_user_token != "" ? aws_ssm_parameter.atlantis_github_user_token[0].arn : null
      },
    ]
  }

  # ECS Service
  service = {
    task_exec_ssm_param_arns = [
      "arn:aws:ssm:${var.region}:${var.aws_account_id}:parameter/*"
#      aws_ssm_parameter.atlantis_webhook_secret.arn,
#      var.atlantis_github_user_token != "" ? aws_ssm_parameter.atlantis_github_user_token[0].arn : (var.atlantis_gitlab_user_token != "" ? aws_ssm_parameter.atlantis_gitlab_user_token[0].arn : aws_ssm_parameter.atlantis_bitbucket_user_token[0].arn)
    ]
    # Provide Atlantis permission necessary to create/destroy resources
    tasks_iam_role_policies = {
      AdministratorAccess = "arn:aws:iam::aws:policy/AdministratorAccess"
    }
    tasks_iam_role_name                = "${var.atlantis_name}-ecs-task-role"
    tasks_iam_role_use_name_prefix     = false
    task_exec_iam_role_name            = "${var.atlantis_name}-task-execution-role"
    task_exec_iam_role_use_name_prefix = false
  }
  service_subnets = var.private_subnet_ids
  vpc_id          = var.vpc_id

  # ALB
  alb = {
    enable_deletion_protection     = false
    create_security_group          = true
    security_group_name            = "${var.atlantis_name}-created-by-module"
    security_group_use_name_prefix = false
    security_groups = [
      module.security_group.security_group_id,
      module.security_group_alowed.security_group_id,
      #      module.security_group_https.security_group_id
    ]
    security_group_ingress_rules = {
      #      all_http = {
      #        from_port      = 80
      #        to_port        = 80
      #        ip_protocol    = "tcp"
      #        description    = "HTTP web traffic"
      #        prefix_list_id = var.atlantis_prefix_list_ids[0]
      #      }
      all_https = {
        from_port      = 443
        to_port        = 443
        ip_protocol    = "tcp"
        description    = "HTTPS web traffic"
        prefix_list_id = var.atlantis_prefix_list_ids[0]
      }
    }
    security_group_egress_rules = {
      all = {
        ip_protocol = "-1"
        cidr_ipv4   = var.cidr
      }
    }
  }

  alb_subnets        = var.public_subnet_ids
  create_certificate = false
  certificate_arn    = module.acm_certificate.aws_acm_certificate_arn
  #  certificate_domain_name = var.route53_zone_name
  route53_zone_id = data.aws_route53_zone.selected.id

  depends_on = [null_resource.image_create, module.acm_certificate]
}

################################################################################
# Supporting Resources
################################################################################

resource "random_password" "webhook_secret" {
  length  = 32
  special = false
}

# If we use EPAM Cloud Custodian we create this role with read only access
module "read_only_role" {
  count             = var.c7n_user != "" ? 1 : 0
  source            = "../c7n_epam"
  atlantis_role_arn = module.atlantis.service["tasks_iam_role_arn"]
  region            = var.region
  depends_on        = [module.atlantis]
}

module "acm_certificate" {
  source            = "../../acm_certificate"
  route53_zone_name = var.route53_zone_name
}