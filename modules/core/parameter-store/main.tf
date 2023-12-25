#=============== Core Parameter Store =====================#
resource "aws_ssm_parameter" "infracost_api" {
  name        = "/infracost/api/key"
  description = "Infracost API Key"
  type        = "SecureString"
  value       = var.infracost_api_key
  overwrite   = true
}
resource "aws_ssm_parameter" "cognito_password" {
  name        = "/cognito/password"
  description = "Password for Cognito User"
  type        = "SecureString"
  value       = var.cognito_password
  overwrite   = true
}
#============================= EPAM Custodian Parameters ==============================#
resource "aws_ssm_parameter" "c7n_user" {
  count       = var.c7n_user != "" ? 1 : 0
  name        = "/C7N/user"
  description = "EPAM Custodian User Name"
  type        = "SecureString"
  value       = var.c7n_user
  overwrite   = true
}
resource "aws_ssm_parameter" "c7n_password" {
  count       = var.c7n_user != "" ? 1 : 0
  name        = "/C7N/PASSWORD"
  description = "Password for EPAM Custodian utils"
  type        = "SecureString"
  value       = var.c7n_password
  overwrite   = true
}

resource "aws_ssm_parameter" "c7n_api_url" {
  count       = var.c7n_user != "" ? 1 : 0
  name        = "/C7N/Api"
  description = "EPAM Custodian api url"
  type        = "SecureString"
  value       = var.c7n_api_url
  overwrite   = true
}

resource "aws_ssm_parameter" "dojo_api_key" {
  count       = var.dojo_api_key == "" ? 0 : 1
  name        = "/dojo/api/key"
  description = "Token for Dojo if you use EPAM Custodian"
  type        = "SecureString"
  value       = var.dojo_api_key
  overwrite   = true
}

resource "aws_ssm_parameter" "openai_token" {
  count       = var.openai_token == "" ? 0 : 1
  name        = "/accelerator/openai_token"
  description = "AI Token"
  type        = "SecureString"
  value       = var.openai_token
  overwrite   = true
}





