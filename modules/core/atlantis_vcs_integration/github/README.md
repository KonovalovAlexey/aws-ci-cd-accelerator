## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_repository_webhook.this](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository_webhook) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_atlantis_github_user_token"></a> [atlantis\_github\_user\_token](#input\_atlantis\_github\_user\_token) | GitHub token to use when creating a webhook | `string` | n/a | yes |
| <a name="input_atlantis_url_events"></a> [atlantis\_url\_events](#input\_atlantis\_url\_events) | The URL for handling Atlantis events on GitHub | `string` | n/a | yes |
| <a name="input_atlantis_webhook_secret"></a> [atlantis\_webhook\_secret](#input\_atlantis\_webhook\_secret) | The secret used for securing Atlantis webhook communication on GitHub | `string` | n/a | yes |
| <a name="input_github_base_url"></a> [github\_base\_url](#input\_github\_base\_url) | GitHub base URL to use when creating a webhook (for GitHub Enterprise users) | `string` | `null` | no |
| <a name="input_github_owner"></a> [github\_owner](#input\_github\_owner) | GitHub owner name to use when creating a webhook | `string` | n/a | yes |
| <a name="input_repo_names"></a> [repo\_names](#input\_repo\_names) | The name of the infrastructure repositories on GitHub | `list(string)` | n/a | yes |

## Outputs

No outputs.
