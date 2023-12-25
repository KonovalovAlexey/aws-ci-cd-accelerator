variable "region" {}
variable "aws_account_id" {
  description = "The AWS account ID to deploy to"
}

variable "vpc_id" {}
variable "private_subnet_ids" {
  type = list(string)
}

variable "security_groups" {
  type = list(string)
}

variable "organization_name" {
  description = "The organization name for Sonar"
}
variable "repo_name" {
  description = "The name of the GitHub/Bitbucket/CodeCommit repository (e.g. new-repo)."
}
variable "repo_default_branch" {
  description = "The name of the default repository branch (default: master)"
}
variable "build_timeout" {
  description = "The time to wait for a CodeBuild to complete before timing out in minutes (default: 5)"
}
variable "build_compute_type" {
  description = "The build instance type for CodeBuild (default: BUILD_GENERAL1_SMALL)"
}
variable "build_image" {
  description = "The build image for CodeBuild to use (default: aws/codebuild/standard:4.0)"
}
variable "buildspec_sonar" {
  description = "The buildspec file to be used for the Sonar Test stage."
}

variable "buildspec_selenium" {
  description = "The buildspec file to be used for the Func Test stage."
}

variable "buildspec_package" {
  description = "The buildspec file to be used for the Package stage on EC2 or ECS"
}

variable "project_key" {
  description = "Project Key for Sonar"
  type        = string
}
variable "sonar_url" {
  description = "Sonar URL"
  type        = string
}

variable "sonarcloud_token_name" { type = string }

variable "environments" {
  description = "List of enviroments for deployments. Used for creation according CodeGuru profiling_groups"
  type        = list(string)
}

variable "connection_provider" {
  type        = string
  description = "Valid values are Bitbucket, GitHub, or GitHubEnterpriseServer."
}

variable "app_fqdn" {
  type = list(string)
}
variable "approve_sns_arn" {
  type = string
}

variable "storage_bucket" {
  description = "Bucket where additional artifacts store(for dlt, deb script)"
  type        = string
}
variable "aws_kms_key" {}
variable "aws_kms_key_arn" {}
variable "region_name" {}
variable "target_type" {}
variable "codebuild_role" {}
variable "codepipeline_role" {}
variable "codeartifact_domain" {
  description = "Use for Java application"
}
variable "codeartifact_repo" {
  description = "Use for Java application"
}

variable "selenium_create" {
  type = bool
}
#=============== Variables for DLT Test ==============
variable "dlt_create" {
  type = bool
}
variable "buildspec_dlt" {
  description = "The buildspec to be used for the Performance Test "
}
variable "dlt_ui_url" {
  type = string
}
variable "cognito_password_name" {}
variable "admin_name" {}
variable "dlt_api_host" {}
variable "cognito_user_pool_id" {}
variable "cognito_client_id" {}
variable "cognito_identity_pool_id" {}
variable "dlt_fqdn" {}
variable "dlt_test_name" {}
variable "dlt_test_id" {}
variable "dlt_test_type" {}
variable "dlt_task_count" {
  type = number
}
variable "concurrency" {
  type = number
}
variable "ramp_up" {}
variable "hold_for" {}

#============================ EKS ==========================#

variable "buildspec_eks" {}
variable "cluster_name" {}
variable "eks_role_arn" {}
variable "ecr_repo_name" {}
variable "cluster_region" {}
variable "cluster_config" {
  description = "Name of AWS Parameter Store Variable, where K8s Cluster config stored in base64"
}
variable "docker_user" {
  description = "User for Docker Registry to get Image from"
}
variable "docker_password" {
  description = "AWS Parameter Store variable Name to get password for Docker Registry"
}
variable "docker_repo" {
  description = "Name for Docker Registry REPO/NAME"
}
variable "helm_chart" {
  description = "Helm Chart URL with release"
}
variable "helm_chart_version" {}

#========================= Docker Image Scan ==================#
variable "tryvi_severity" {
  type = string
}

#======================= Unit Tests ===========================#
variable "buildspec_unit" {
  type = string
}
#=============== Codedeploy ===================================#
variable "deployment_group_names" {
  type = list(string)
}
variable "application_name" {
  type = string
}
variable "codedeploy_role_arns" {
  type = list(string)
}
variable "report_portal_environments" {
  type = list(map(string))
}

# Regions where application infrastructure for stage is deployed
variable "stage_regions" {
  type = list(list(string))
}

variable "artifact_bucket_prefix" {}

#=============== Carrrier =======================
variable "carrier_create" {
  type = bool
}
variable "buildspec_carrier" {
  description = "The name of buildspec file if we use Carrier "
}
variable "carrier_url" {
  type = string
}
variable "carrier_project_id" {
  type = string
}
variable "carrier_token_name" {
  type = string
}
variable "carrier_test_id" {
  type = string
}
#========================= Synthetics ======================#
variable "synthetics_create" {
  type = bool
}
variable "statemachine_arn" {
  type = string
}