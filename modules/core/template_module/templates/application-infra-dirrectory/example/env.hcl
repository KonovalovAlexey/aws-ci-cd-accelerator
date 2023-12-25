# Set common variables for the environment. This is automatically pulled in the root terragrunt.hcl configuration to
# feed forward to the child modules.

locals {
  repo_name               = "${repo_name}"
  ecr_repo_name           = local.repo_name
  environments            = split("-", "${environments}" )
  vpc_create              = true
  vpc_id                  = "" # If vpc_create = false
  nat_security_group_id   = "" # If vpc_create = false
  public_subnet_ids       = []
  private_subnet_ids      = []
  enable_nat_gateway      = true # If vpc_create = true
  single_nat_gateway      = true # If vpc_create = true
  reuse_nat_ips           = false # If vpc_create = true
  cpu                     = 256
  memory                  = 512
  desired_capacity        = ["1"] # Desire capacity for AutoScaling, ECS or EKS deployment
  min_size                = ["1"]
  max_size                = ["1"]
  application_port        = "" # Application Port
  health_path             = "" # Path for LoadBalancer Health Check
  target_type             = "" # "instance", "ip", "eks" or "kube_cluster"
  route53_zone_name       = "" # Route53 Zone Record Name
  dns_record_names        = [] # DNS Records for each stage
  allowed_cidr_blocks     = [] # Cidr Blocks to be allowed access to Application through LoadBalancer
  allowed_prefix_list_ids = [] # Prefis List IDs to be allowed access to Application through LoadBalancer
  # ==================== CodeDeploy Block =======================
  codedeploy_role_create  = true # If we deploy the same infrastructure in a second region, set false
}
