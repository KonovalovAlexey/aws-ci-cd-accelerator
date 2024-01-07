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

variable "service_bucket" {
  description = "Bucket where additional files store(for ECS task definitions, deb script)"
  type        = string
}
variable "aws_kms_key" {
  type = string
}
variable "aws_kms_key_arn" {
  type = string
}
variable "region_name" {
  type = string
}
variable "target_type" { type = string }
variable "codebuild_role" {
  type = string
}
variable "codepipeline_role" {
  type = string
}
variable "codeartifact_domain" {
  description = "Use for Java application"
  type        = string
}
variable "codeartifact_repo" {
  description = "Use for Java application"
  type        = string
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
  type        = string
}
variable "dlt_ui_url" {
  type = string
}
variable "cognito_password_name" {
  type = string
}
variable "admin_name" {
  type = string
}
variable "dlt_api_host" {
  type = string
}
variable "cognito_user_pool_id" {
  type = string
}
variable "cognito_client_id" {
  type = string
}
variable "cognito_identity_pool_id" {
  type = string
}
variable "dlt_fqdn" {
  type = string
}
variable "dlt_test_name" {
  type = string
}
variable "dlt_test_id" {
  type = string
}
variable "dlt_test_type" {
  type = string
}
variable "dlt_task_count" {
  type = number
}
variable "concurrency" {
  type = number
}
variable "ramp_up" {
  type = string
}
variable "hold_for" {
  type = string
}

#============================ EKS ==========================#

variable "buildspec_eks" {
  type = string
}
variable "cluster_name" {
  type = string
}
variable "eks_role_arn" {
  type = string
}
variable "ecr_repo_name" {
  type = string
}
variable "cluster_region" {
  type = string
}
variable "cluster_config" {
  description = "Name of AWS Parameter Store Variable, where K8s Cluster config stored in base64"
  type        = string
}
variable "docker_user" {
  description = "User for Docker Registry to get Image from"
  type        = string
}
variable "docker_password" {
  description = "AWS Parameter Store variable Name to get password for Docker Registry"
  type        = string
}
variable "docker_repo" {
  description = "Name for Docker Registry REPO/NAME"
  type        = string
}
variable "helm_chart" {
  description = "Helm Chart URL with release"
  type        = string
}
variable "helm_chart_version" {
  type = string
}

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

variable "artifact_bucket_prefix" {
  type = string
}

#=============== Carrrier =======================
variable "carrier_create" {
  type = bool
}
variable "buildspec_carrier" {
  description = "The name of buildspec file if we use Carrier "
  type        = string
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