locals {
  stage_regions = [for stage in keys(var.stages) : var.stages[stage].regions]
  regions       = [for region in distinct(flatten(local.stage_regions)) : region]
  buckets       = [for region in local.regions : "${var.artifact_bucket_prefix}-${var.repo_name}-${region}"]
}
