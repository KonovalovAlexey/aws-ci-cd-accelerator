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
  # Automatically load parameter-store-accelerator-account-level variables
  parameter_vars = read_terragrunt_config(find_in_parent_folders("parameter_store.hcl"))


  # Expose the base source URL so different versions of the module can be deployed in different environments. This will
  # be used to construct the terraform block in the child terragrunt configurations.
  # base_source_url = "git::git@github.com:gruntwork-io/terragrunt-infrastructure-modules-example.git//mysql"
  base_source_url = "${get_path_to_repo_root()}//modules//core/atlantis/"
}

dependencies {
  # If we use run-all command
  paths = ["${get_terragrunt_dir()}/../vpc", "${get_terragrunt_dir()}/../common_parameters"]
}

dependency "vpc" {
  config_path  = "${get_terragrunt_dir()}/../vpc"
  mock_outputs = {
    vpc_id          = "temporary-dummy-id"
    public_subnets  = ["subnet-1"]
    private_subnets = ["subnet-2"]
  }
  mock_outputs_allowed_terraform_commands = ["validate", "plan", "destroy"]
}

# ---------------------------------------------------------------------------------------------------------------------
# MODULE PARAMETERS
# These are the variables we have to pass in to use the module. This defines the parameters that are common across all
# environments.
# ---------------------------------------------------------------------------------------------------------------------

inputs = merge(
  local.parameter_vars.locals,
  {
    vpc_id                            = dependency.vpc.outputs.vpc_id
    public_subnet_ids                 = dependency.vpc.outputs.public_subnets
    private_subnet_ids                = dependency.vpc.outputs.private_subnets
    #Custom environment variables for AWS Fargate task
    custom_environment_secrets_gitlab = [
      {
        "name" : "GITLAB_TOKEN",
        "valueFrom" : "/atlantis/gitlab/user/token"
      }
    ]
    custom_environment_secrets_github = [
      {
        "name" : "GITHUB_TOKEN",
        "valueFrom" : "/atlantis/github/user/token"
      }
    ]
    custom_environment_secrets_bitbucket = [
      {
        "name" : "BITBUCKET_TOKEN",
        "valueFrom" : "/atlantis/bitbucket/user/token"
      }
    ]
  }
)

