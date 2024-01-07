## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_acm_certificate"></a> [acm\_certificate](#module\_acm\_certificate) | ../../acm_certificate | n/a |
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | terraform-aws-modules/atlantis/aws | 4.0.8 |
| <a name="module_read_only_role"></a> [read\_only\_role](#module\_read\_only\_role) | ../c7n_epam | n/a |
| <a name="module_security_group"></a> [security\_group](#module\_security\_group) | terraform-aws-modules/security-group/aws | 5.1.0 |
| <a name="module_security_group_alowed"></a> [security\_group\_alowed](#module\_security\_group\_alowed) | terraform-aws-modules/security-group/aws | 5.1.0 |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.atlantis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_ssm_parameter.atlantis_bitbucket_user_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.atlantis_github_user_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.atlantis_gitlab_user_token](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.atlantis_webhook_secret](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [null_resource.image_create](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [random_password.webhook_secret](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [aws_iam_policy_document.aws_ecr_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules of the ALB. | `list(string)` | `[]` | no |
| <a name="input_allowed_prefix_list_ids"></a> [allowed\_prefix\_list\_ids](#input\_allowed\_prefix\_list\_ids) | Prefix lists with IPs allowed to access to Atlantis | `list(string)` | `[]` | no |
| <a name="input_atlantis_bitbucket_user_token"></a> [atlantis\_bitbucket\_user\_token](#input\_atlantis\_bitbucket\_user\_token) | Bitbucket token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_github_user_token"></a> [atlantis\_github\_user\_token](#input\_atlantis\_github\_user\_token) | GitHub token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_gitlab_user_token"></a> [atlantis\_gitlab\_user\_token](#input\_atlantis\_gitlab\_user\_token) | Gitlab token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_name"></a> [atlantis\_name](#input\_atlantis\_name) | Name to use on all resources created (VPC, ALB, etc) | `string` | `"atlantis"` | no |
| <a name="input_atlantis_prefix_list_ids"></a> [atlantis\_prefix\_list\_ids](#input\_atlantis\_prefix\_list\_ids) | Prefix lists with IPs for VCS where Terraform code is stored to connect to Atlantis | `list(string)` | `[]` | no |
| <a name="input_atlantis_repo_allowlist"></a> [atlantis\_repo\_allowlist](#input\_atlantis\_repo\_allowlist) | List of allowed repositories Atlantis can be used with | `list(string)` | `[]` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_bitbucket_user"></a> [bitbucket\_user](#input\_bitbucket\_user) | Bitbucket username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_bitbucket_webhooks_cidr_blocks"></a> [bitbucket\_webhooks\_cidr\_blocks](#input\_bitbucket\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by BitBucket webhooks | `list(string)` | <pre>[<br>  "140.82.112.0/20",<br>  "185.199.108.0/22",<br>  "192.30.252.0/22",<br>  "143.55.64.0/20"<br>]</pre> | no |
| <a name="input_c7n_user"></a> [c7n\_user](#input\_c7n\_user) | C7N User Name | `string` | n/a | yes |
| <a name="input_cidr"></a> [cidr](#input\_cidr) | The CIDR block for the VPC which will be created if `vpc_id` is not specified | `string` | `""` | no |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | GitHub username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_github_webhooks_cidr_blocks"></a> [github\_webhooks\_cidr\_blocks](#input\_github\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by GitHub webhooks | `list(string)` | <pre>[<br>  "140.82.112.0/20",<br>  "185.199.108.0/22",<br>  "192.30.252.0/22",<br>  "143.55.64.0/20"<br>]</pre> | no |
| <a name="input_gitlab_user"></a> [gitlab\_user](#input\_gitlab\_user) | Gitlab username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_gitlab_webhooks_cidr_blocks"></a> [gitlab\_webhooks\_cidr\_blocks](#input\_gitlab\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by GitLab webhooks | `list(string)` | <pre>[<br>  "174.128.60.0/24"<br>]</pre> | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Route53 zone name to create ACM certificate in and main A-record, without trailing dot | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of an existing VPC where resources will be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_atlantis_url"></a> [atlantis\_url](#output\_atlantis\_url) | URL of Atlantis |
| <a name="output_atlantis_url_events"></a> [atlantis\_url\_events](#output\_atlantis\_url\_events) | Webhook url for Atlantis |
| <a name="output_tasks_iam_role_name"></a> [tasks\_iam\_role\_name](#output\_tasks\_iam\_role\_name) | n/a |
| <a name="output_webhook_secret"></a> [webhook\_secret](#output\_webhook\_secret) | Webhook secret |
