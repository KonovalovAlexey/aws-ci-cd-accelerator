# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.
locals {
  # Accounts for stages
  stages = {
    dev = { account = "", regions = [], region_names = [] }
    qa  = { account = "", regions = [], region_names = [] }
    uat = { account = "", regions = [], region_names = [] }
  }
  env_vars = {
    dev = []
    qa  = []
    uat = []
  }
  secrets = {
    dev = []
    qa  = []
    uat = []
  }
  #======================= Application Pipeline =================#
  repo_name           = "${repo_name}" # Git Repository Name
  repo_default_branch = "" # Git Branch AWS CodePipeline works with
  email_addresses     = [] # E-mails for Notification
  connection_provider = "" # Bitbucket, GitHub, or GitHubEnterpriseServer. Leave "" for CodeCommit
  target_type         = "ip" # "ip", "instance", "eks" or "kube_cluster"
  app_fqdn            = [] # FQDN for application endpoints to be tested

  #================= Parameters for Sonar =========================#
  sonar_url             = "https://sonarcloud.io"
  sonarcloud_token_name = "/$${local.repo_name}/sonar/token"
  project_key           = "" # A Sonar unique identifier for your project
  organization_name     = "" # Sonar Name of the organization
  #=========================== AI ==================================#
  ai_handler_create     = false
  llm_model             = "text-davinci-003"
  openai_api_endpoint   = "https://api.openai.com/v1/completions"
  github_token_name     = "/$${local.repo_name}/user/token"
  openai_token_name     = "/accelerator/openai_token"
  #================ Create Selenium Test Stage ======================#
  selenium_create       = false
  #================ Create Synthetics Test Stage ====================#
  synthetics_create     = false
  #================ Parameters for Artifact Bucket ==================#
  force_destroy         = true #  Delete bucket when destroy: true or false

  #======================== Parameters for Notifications ===================#
  build_success = false # If true, you will also get notifications about successful builds
  display_name  = "AWS CodePipeline Notification" # A title of E-mail notification

  #================================ Report Portal ===========================#
  rp_token_name = "/$${local.repo_name}/report/portal/token"
  rp_project    = ""
  rp_endpoint   = ""

  #=============================== DLT Block ================================#
  dlt_create              = false
  dlt_test_id             = ""
  admin_name              = "user"
  cognito_password_name   = "/cognito/password"
  dlt_test_name           = "DLT-JMeter-Test-$${local.repo_name}"
  dlt_test_type           = "jmeter"
  dlt_task_count          = 1
  concurrency             = 10
  ramp_up                 = "1m"
  hold_for                = "1m"
   #================================= Carrier ==================================#
  carrier_create          = false
  carrier_auth_token_name = ""
  carrier_project_id      = ""
  carrier_test_id         = ""
  carrier_url             = ""
  #============================ ECS Task Definition ===========================#
  cpu                     = 256
  memory                  = 512
  #============================= ECR ==========================================#
  image_tag_mutability    = "IMMUTABLE"
  tryvi_severity          = "CRITICAL" # Can be CRITICAL, HIGH, LOW
  #======================================= EKS ===============================##
  # These variables depends on Helm Chart                                     ##
  # This is an example with test Helm Chart

  eks_cluster_name = ""
  eks_role_arn     = "" # The role created EKS Cluster administrator to manage Helm Chart
  cluster_region   = ""
  #================================= Stand Alone Cluster ==================================#
  cluster_config   = ""
  docker_repo      = ""
  docker_user      = ""
  docker_password  = ""

  #================================ Common Variables for any Kubernetes Cluster ============#
  helm_chart         = "" # Helm Chart Store
  helm_chart_version = "" # Helm Chart version

  #=========================================================================================#

  #===================== Automatically defined variables ===================================#
  #                 Don't change anything, all variables compute automatically              #
  #=========================================================================================#
  environments = keys(local.stages)

  stage_accounts = [for stage in local.environments : local.stages["$${stage}"].account]

  # Regions for stages
  stage_regions = [for stage in local.environments : local.stages["$${stage}"].regions]

  deployment_group_names = [for stage in local.environments : "$${local.repo_name}-$${stage}"]
  application_name       = local.repo_name

  codedeploy_role_arns = [
    for stage in local.environments :
    "arn:aws:iam::$${local.stages["$${stage}"].account}:role/Codedeploy-$${local.repo_name}-$${stage}"
  ]
  ec2_profile_role_arns = local.target_type == "instance" ? [
    for stage in local.environments :
    "arn:aws:iam::$${local.stages["$${stage}"].account}:role/EC2-Profile-Role-$${local.repo_name}-$${stage}"
  ] : []
  account_identifiers = distinct(local.stage_accounts)

  ecr_identifiers = [
    for account in local.account_identifiers :"arn:aws:iam::$${account}:role/Ecs-Execution-$${local.repo_name}"
  ]

  kms_identifiers = concat(local.codedeploy_role_arns, local.ec2_profile_role_arns)

  artifact_bucket_identifiers = concat(local.codedeploy_role_arns, local.ec2_profile_role_arns)

  #======================= CodeBuild Variables are generated dynamically =============#

  #=== Report Portal Block ======#
  report_portal_environments = [
    {
      name  = "RP_PROJECT"
      value = local.rp_project
    },
    {
      name  = "RP_ENDPOINT"
      value = local.rp_endpoint
    },
    {
      name  = "RP_TOKEN_NAME"
      value = local.rp_token_name
    }
  ]

}




