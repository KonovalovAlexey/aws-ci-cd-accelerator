#==================== Parameter Store Variables ===================#
locals {
  openai_token      = "" # AI Token
  infracost_api_key = "" # Token for Infracost.
  cognito_password  = "" # Password  you will replace during your first visit to DLT Test Web Page.
  rp_token          = "" # Token for Report Portal.
  c7n_user          = "" # EPAM Custodian User Name.
  c7n_password      = "" # Password from EPAM Custodian.
  c7n_api_url       = "" # EPAM Custodian URL.
  dojo_api_key      = "" # Token from DOJO if you use EPAM Custodian.

  #========================= Atlantis ==============================#
  # Complete only one of the following blocks, depending on the type of IaC repository.
  #************************* For Github ***************************#
  github_user                = "" # GitHub technical user
  atlantis_github_user_token = "" # GitHub technical user token
  github_owner               = ""
  repo_names                 = [] # GitHub repos to connect to Atlantis
  vcs                        = "github" # Don't change, the name of folder to deploy Git-Atlantis integration
  #************************* For GitLab ***************************#
#  gitlab_user                = "" # GitLab technical user
#  atlantis_gitlab_user_token = "" # GitLab technical user token
#  atlantis_gitlab_hostname   = "" # GitLab hostname URL
#  project_id                 = "" # GitLab project id
#  vcs                        = "gitlab"

  ##*********************** For BitBucket **********************4****#
#  bitbucket_user                = "" # BitBucket technical user
#  atlantis_bitbucket_user_token = "" # BitBucket technical user token
#  atlantis_bitbucket_base_url   = "" # BitBucket base URL
#  infra_repo_name               = ""
#  vcs                           = "bitbucket"

}
