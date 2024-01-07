#==================== Parameter Store Variables ===================#
locals {
  env_vars        = read_terragrunt_config("env.hcl")
  repo_name       = local.env_vars.locals.repo_name
}
locals {
  github_token    = ""
  parameter_store = [
    {
      parameter_value = local.github_token # Token for Application Repo (GitHub, BitBucket).
      parameter_name  = "/${local.repo_name}/user/token"
      tier            = "Standard"
      description     = "Token for Application Repo (GitHub, BitBucket)."
    }
  ]
  # ===================== AWS-GITLAB Integration ====================#
  #   Define these variables if your application is hosted on GitLab #
  # ======================== GitLab Block ===========================#
  gitlab_hostname = ""
  project_id      = ""
  aws_user_name   = ""
  gitlab_token    = ""
  gitlab_user     = ""
  app_language    = "go" # "python", "java"

  #============================= PR Sonar ============================#
  sonarcloud_token = "" # Token for SonarCloud.
  #========================== Report Portal Token ====================#
  rp_token         = "" # Token for Report Portal.
  #============================= Teams Token =========================#
  teams_web_hook   = ""
  #============================== Slack Token ========================#
  slack_web_hook   = "" # Slack WebHook if you use Slack for Notifications.


}
