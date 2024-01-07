output "atlantis_url" {
  description = "URL of Atlantis"
  value       = module.atlantis.url
}

output "atlantis_url_events" {
  description = "Webhook url for Atlantis"
  value = "${module.atlantis.url}/events"
}

output "webhook_secret" {
  description = "Webhook secret"
  value       = random_password.webhook_secret.result
  sensitive   = true
}

output "tasks_iam_role_name" {
  value = module.atlantis.service["tasks_iam_role_arn"]
}

