# CodeStar Connections
resource "aws_codestarconnections_connection" "codestar_connection" {
  count         = contains(["GitHub", "Bitbucket", "GitHubEnterpriseServer"], var.connection_provider) ? 1 : 0
  name          = "${var.connection_provider}-${var.region_name}-${var.repo_name}"
  provider_type = var.connection_provider
  lifecycle {
    ignore_changes = all
  }
}

locals {
  codestarconnection = {
    ConnectionArn        = aws_codestarconnections_connection.codestar_connection[0].arn
    FullRepositoryId     = "${var.organization_name}/${var.repo_name}"
    OutputArtifactFormat = "CODEBUILD_CLONE_REF"
    BranchName           = var.repo_default_branch
  }
  codecommit = {
    RepositoryName = var.repo_name
    BranchName     = var.repo_default_branch
    OutputArtifactFormat : "CODEBUILD_CLONE_REF"
  }
  provider = contains([
    "GitHub", "Bitbucket", "GitHubEnterpriseServer"
  ], var.connection_provider) ? "CodeStarSourceConnection" : "CodeCommit"
}
