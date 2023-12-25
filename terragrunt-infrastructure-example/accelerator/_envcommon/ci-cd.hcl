# ---------------------------------------------------------------------------------------------------------------------
# COMMON TERRAGRUNT CONFIGURATION
# This configuration will be merged into the environment configuration
# via an include block.
# ---------------------------------------------------------------------------------------------------------------------

# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder. If any environment
# needs to deploy a different module version, it should redefine this block with a different ref to override the
# deployed version.
terraform {
  #  source = "${local.base_source_url}?ref=v0.7.0"
  source = "${local.base_source_url}"
  after_hook "validate_tflint" {
    commands = ["validate"]
    execute  = [
      "sh", "-c", <<EOT
            echo "---------------- TFLint Report --------------"
            tflint -v || exit 0
            tflint --init --config "${get_repo_root()}/.tflint.hcl" || exit 0
            tflint --config "${get_repo_root()}/.tflint.hcl" || exit 0
          EOT
    ]
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# Locals are named constants that are reusable within the configuration.
# ---------------------------------------------------------------------------------------------------------------------
locals {

  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  # base_source_url = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//mysql"
  base_source_url = "${get_path_to_repo_root()}//modules/accelerator/main-module/"
}

dependency "vpc" {
  config_path  = "${get_terragrunt_dir()}/../../../core/vpc"
  mock_outputs = {
    vpc_id                 = "temporary-dummy-id"
    public_subnets         = ["subnet-1111111"]
    private_subnets        = ["subnet-2222222"]
    vpc_nat_security_group = "sg-1111111111"
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan"]
}
dependency "dlt" {
  config_path = "${get_terragrunt_dir()}/../../../core/dlt"
}

inputs = {
  #========================= VPC Block ==================================#
  vpc_id          = dependency.vpc.outputs.vpc_id
  security_groups = [
    dependency.vpc.outputs.vpc_nat_security_group
  ]

  private_subnet_ids       = dependency.vpc.outputs.private_subnets
  public_subnet_ids        = dependency.vpc.outputs.public_subnets
  vpc_range                = dependency.vpc.outputs.vpc_cidr_block
  #============================ DLT ======================================#
  dlt_ui_url               = dependency.dlt.outputs.console
  dlt_api_host             = dependency.dlt.outputs.api
  cognito_client_id        = dependency.dlt.outputs.cognito_client_id
  cognito_identity_pool_id = dependency.dlt.outputs.cognito_identity_pool_id
  cognito_user_pool_id     = dependency.dlt.outputs.cognito_user_pool_id
  dlt_fqdn                 = dependency.dlt.outputs.dlt_fqdn
}

