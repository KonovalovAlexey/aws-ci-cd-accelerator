# Set common variables for the environment. This is automatically pulled in in the root terragrunt.hcl configuration to
# feed forward to the child modules.

locals {
  # Accounts and regions for stages
  stages = {
    # Accounts and regions for stages
    dev = { account = "", regions = [], region_names = [] }
    qa  = { account = "", regions = [], region_names = [] }
    uat = { account = "", regions = [], region_names = [] }
  }

  #======================= Application CI/CD =================#
  repo_name = "" # Application Git Repository Name

  #============== Variables for Application Infrastructure =======#
  target_type           = "ip" #"ip" # "instance" , "eks", "kube_cluster"
  #================= Parameters for Sonar =========================#
  sonar_url             = "https://sonarcloud.io"
  sonarcloud_token_name = "/${local.repo_name}/sonar/token"
  project_key           = "" # Sonar project key
  organization_name     = "" # Sonar organization name
  #======================= AI =======================================#
  ai_handler_create     = true
  llm_model             = "text-davinci-003"
  openai_api_endpoint   = "https://api.openai.com/v1/completions"
  openai_token_name     = "/accelerator/openai_token"
  github_token_name     = "/${local.repo_name}/user/token"
  connection_provider   = "GitHub"# Bitbucket, GitHub, or GitHubEnterpriseServer. Leave "" for CodeCommit
}








