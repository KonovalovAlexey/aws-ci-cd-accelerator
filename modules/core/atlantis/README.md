# Atlantis on AWS Fargate Terraform Module

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.4  |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | \>= 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | = 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_atlantis"></a> [atlantis](#module\_atlantis) | terraform-aws-modules/atlantis/aws | 3.28.0  |
| <a name="module_read_only_role"></a> [read\_only\_role](#module\_read\_only\_role) | ../c7n_epam | n/a     |
| <a name="module_security-group"></a> [security-group](#module\_security-group) | terraform-aws-modules/security-group/aws | 5.1.0   |

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.atlantis](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.this](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/resources/ecr_repository_policy) | resource |
| [null_resource.image_create](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_iam_policy_document.aws_ecr_repository_policy](https://registry.terraform.io/providers/hashicorp/aws/5.0/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acm_certificate_domain_name"></a> [acm\_certificate\_domain\_name](#input\_acm\_certificate\_domain\_name) | Route53 domain name to use for ACM certificate. Route53 zone for this domain should be created in advance. Specify if it is different from value in `route53_zone_name` | `string` | `""` | no |
| <a name="input_alb_authenticate_oidc"></a> [alb\_authenticate\_oidc](#input\_alb\_authenticate\_oidc) | Map of Authenticate OIDC parameters to protect ALB (eg, using Auth0). See https://www.terraform.io/docs/providers/aws/r/lb_listener.html#authenticate-oidc-action | `any` | `{}` | no |
| <a name="input_alb_ingress_cidr_blocks"></a> [alb\_ingress\_cidr\_blocks](#input\_alb\_ingress\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules of the ALB. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_alb_log_bucket_name"></a> [alb\_log\_bucket\_name](#input\_alb\_log\_bucket\_name) | S3 bucket (externally created) for storing load balancer access logs. Required if alb\_logging\_enabled is true. | `string` | `""` | no |
| <a name="input_alb_log_location_prefix"></a> [alb\_log\_location\_prefix](#input\_alb\_log\_location\_prefix) | S3 prefix within the log\_bucket\_name under which logs are stored. | `string` | `""` | no |
| <a name="input_alb_logging_enabled"></a> [alb\_logging\_enabled](#input\_alb\_logging\_enabled) | Controls if the ALB will log requests to S3. | `bool` | `false` | no |
| <a name="input_allow_github_webhooks"></a> [allow\_github\_webhooks](#input\_allow\_github\_webhooks) | Whether to allow access for GitHub webhooks | `bool` | `false` | no |
| <a name="input_allow_repo_config"></a> [allow\_repo\_config](#input\_allow\_repo\_config) | When true allows the use of atlantis.yaml config files within the source repos. | `string` | `"false"` | no |
| <a name="input_allow_unauthenticated_access"></a> [allow\_unauthenticated\_access](#input\_allow\_unauthenticated\_access) | Whether to create ALB listener rule to allow unauthenticated access for certain CIDR blocks (eg. allow GitHub webhooks to bypass OIDC authentication) | `bool` | `false` | no |
| <a name="input_allow_unauthenticated_access_priority"></a> [allow\_unauthenticated\_access\_priority](#input\_allow\_unauthenticated\_access\_priority) | ALB listener rule priority for allow unauthenticated access rule | `number` | `10` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | List of IPv4 CIDR ranges to use on all ingress rules of the ALB. | `list(string)` | <pre>[<br>  "0.0.0.0/0"<br>]</pre> | no |
| <a name="input_atlantis_bitbucket_base_url"></a> [atlantis\_bitbucket\_base\_url](#input\_atlantis\_bitbucket\_base\_url) | Base URL of Bitbucket Server, use for Bitbucket on prem (Stash) | `string` | `""` | no |
| <a name="input_atlantis_bitbucket_user_token"></a> [atlantis\_bitbucket\_user\_token](#input\_atlantis\_bitbucket\_user\_token) | Bitbucket token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_bitbucket_user_token_ssm_parameter_name"></a> [atlantis\_bitbucket\_user\_token\_ssm\_parameter\_name](#input\_atlantis\_bitbucket\_user\_token\_ssm\_parameter\_name) | Name of SSM parameter to keep atlantis\_bitbucket\_user\_token | `string` | `"/atlantis/bitbucket/user/token"` | no |
| <a name="input_atlantis_fqdn"></a> [atlantis\_fqdn](#input\_atlantis\_fqdn) | FQDN of Atlantis to use. Set this only to override Route53 and ALB's DNS name. | `string` | `null` | no |
| <a name="input_atlantis_github_user_token"></a> [atlantis\_github\_user\_token](#input\_atlantis\_github\_user\_token) | GitHub token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_github_user_token_ssm_parameter_name"></a> [atlantis\_github\_user\_token\_ssm\_parameter\_name](#input\_atlantis\_github\_user\_token\_ssm\_parameter\_name) | Name of SSM parameter to keep atlantis\_github\_user\_token | `string` | `"/atlantis/github/user/token"` | no |
| <a name="input_atlantis_gitlab_hostname"></a> [atlantis\_gitlab\_hostname](#input\_atlantis\_gitlab\_hostname) | Gitlab server hostname, defaults to gitlab.com | `string` | `"gitlab.com"` | no |
| <a name="input_atlantis_gitlab_user_token"></a> [atlantis\_gitlab\_user\_token](#input\_atlantis\_gitlab\_user\_token) | Gitlab token of the user that is running the Atlantis command | `string` | `""` | no |
| <a name="input_atlantis_gitlab_user_token_ssm_parameter_name"></a> [atlantis\_gitlab\_user\_token\_ssm\_parameter\_name](#input\_atlantis\_gitlab\_user\_token\_ssm\_parameter\_name) | Name of SSM parameter to keep atlantis\_gitlab\_user\_token | `string` | `"/atlantis/gitlab/user/token"` | no |
| <a name="input_atlantis_image"></a> [atlantis\_image](#input\_atlantis\_image) | Docker image to run Atlantis with. If not specified, official Atlantis image will be used | `string` | `""` | no |
| <a name="input_atlantis_log_level"></a> [atlantis\_log\_level](#input\_atlantis\_log\_level) | Log level that Atlantis will run with. Accepted values are: <debug\|info\|warn\|error> | `string` | `"debug"` | no |
| <a name="input_atlantis_name"></a> [atlantis\_name](#input\_atlantis\_name) | Name to use on all resources created (VPC, ALB, etc) | `string` | `"atlantis"` | no |
| <a name="input_atlantis_port"></a> [atlantis\_port](#input\_atlantis\_port) | Local port Atlantis should be running on. Default value is most likely fine. | `number` | `4141` | no |
| <a name="input_atlantis_prefix_list_ids"></a> [atlantis\_prefix\_list\_ids](#input\_atlantis\_prefix\_list\_ids) | Prefix lists with IPs for VCS where Terraform code is stored to connect to Atlantis | `list(string)` | `[]` | no |
| <a name="input_atlantis_version"></a> [atlantis\_version](#input\_atlantis\_version) | Version of Atlantis to run. If not specified latest will be used | `string` | `"latest"` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | n/a | `string` | n/a | yes |
| <a name="input_aws_ssm_path"></a> [aws\_ssm\_path](#input\_aws\_ssm\_path) | AWS ARN prefix for SSM (public AWS region or Govcloud). Valid options: aws, aws-us-gov. | `string` | `"aws"` | no |
| <a name="input_bitbucket_user"></a> [bitbucket\_user](#input\_bitbucket\_user) | Bitbucket username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_bitbucket_webhooks_cidr_blocks"></a> [bitbucket\_webhooks\_cidr\_blocks](#input\_bitbucket\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by BitBucket webhooks | `list(string)` | <pre>[<br>  "140.82.112.0/20",<br>  "185.199.108.0/22",<br>  "192.30.252.0/22",<br>  "143.55.64.0/20"<br>]</pre> | no |
| <a name="input_c7n_user"></a> [c7n\_user](#input\_c7n\_user) | C7N User Name | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ARN of certificate issued by AWS ACM. If empty, a new ACM certificate will be created and validated using Route53 DNS | `string` | `""` | no |
| <a name="input_cloudwatch_log_retention_in_days"></a> [cloudwatch\_log\_retention\_in\_days](#input\_cloudwatch\_log\_retention\_in\_days) | Retention period of Atlantis CloudWatch logs | `number` | `7` | no |
| <a name="input_container_memory_reservation"></a> [container\_memory\_reservation](#input\_container\_memory\_reservation) | The amount of memory (in MiB) to reserve for the container | `number` | `512` | no |
| <a name="input_create_route53_record"></a> [create\_route53\_record](#input\_create\_route53\_record) | Whether to create Route53 record for Atlantis | `bool` | `true` | no |
| <a name="input_custom_environment_secrets_bitbucket"></a> [custom\_environment\_secrets\_bitbucket](#input\_custom\_environment\_secrets\_bitbucket) | List of additional secrets the container will use (list should contain maps with `name` and `valueFrom`) | <pre>list(object(<br>    {<br>      name      = string<br>      valueFrom = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_custom_environment_secrets_github"></a> [custom\_environment\_secrets\_github](#input\_custom\_environment\_secrets\_github) | List of additional secrets the container will use (list should contain maps with `name` and `valueFrom`) | <pre>list(object(<br>    {<br>      name      = string<br>      valueFrom = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_custom_environment_secrets_gitlab"></a> [custom\_environment\_secrets\_gitlab](#input\_custom\_environment\_secrets\_gitlab) | List of additional secrets the container will use (list should contain maps with `name` and `valueFrom`) | <pre>list(object(<br>    {<br>      name      = string<br>      valueFrom = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_custom_environment_variables"></a> [custom\_environment\_variables](#input\_custom\_environment\_variables) | List of additional environment variables the container will use (list should contain maps with `name` and `value`) | <pre>list(object(<br>    {<br>      name  = string<br>      value = string<br>    }<br>  ))</pre> | `[]` | no |
| <a name="input_ecs_service_assign_public_ip"></a> [ecs\_service\_assign\_public\_ip](#input\_ecs\_service\_assign\_public\_ip) | Should be true, if ECS service is using public subnets (more info: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_cannot_pull_image.html) | `bool` | `false` | no |
| <a name="input_ecs_service_deployment_maximum_percent"></a> [ecs\_service\_deployment\_maximum\_percent](#input\_ecs\_service\_deployment\_maximum\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment | `number` | `200` | no |
| <a name="input_ecs_service_deployment_minimum_healthy_percent"></a> [ecs\_service\_deployment\_minimum\_healthy\_percent](#input\_ecs\_service\_deployment\_minimum\_healthy\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment | `number` | `50` | no |
| <a name="input_ecs_service_desired_count"></a> [ecs\_service\_desired\_count](#input\_ecs\_service\_desired\_count) | The number of instances of the task definition to place and keep running | `number` | `1` | no |
| <a name="input_ecs_task_cpu"></a> [ecs\_task\_cpu](#input\_ecs\_task\_cpu) | The number of cpu units used by the task | `number` | `1024` | no |
| <a name="input_ecs_task_memory"></a> [ecs\_task\_memory](#input\_ecs\_task\_memory) | The amount (in MiB) of memory used by the task | `number` | `2048` | no |
| <a name="input_github_user"></a> [github\_user](#input\_github\_user) | GitHub username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_github_webhooks_cidr_blocks"></a> [github\_webhooks\_cidr\_blocks](#input\_github\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by GitHub webhooks | `list(string)` | <pre>[<br>  "140.82.112.0/20",<br>  "185.199.108.0/22",<br>  "192.30.252.0/22",<br>  "143.55.64.0/20"<br>]</pre> | no |
| <a name="input_gitlab_user"></a> [gitlab\_user](#input\_gitlab\_user) | Gitlab username that is running the Atlantis command | `string` | `""` | no |
| <a name="input_gitlab_webhooks_cidr_blocks"></a> [gitlab\_webhooks\_cidr\_blocks](#input\_gitlab\_webhooks\_cidr\_blocks) | List of IPv4 CIDR blocks used by GitLab webhooks | `list(string)` | <pre>[<br>  "174.128.60.0/24"<br>]</pre> | no |
| <a name="input_internal"></a> [internal](#input\_internal) | Whether the load balancer is internal or external | `bool` | `false` | no |
| <a name="input_policies_arn"></a> [policies\_arn](#input\_policies\_arn) | A list of the ARN of the policies you want to apply | `list(string)` | <pre>[<br>  "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"<br>]</pre> | no |
| <a name="input_private_subnet_ids"></a> [private\_subnet\_ids](#input\_private\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Name of | `string` | n/a | yes |
| <a name="input_public_subnet_ids"></a> [public\_subnet\_ids](#input\_public\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | n/a | yes |
| <a name="input_repo_whitelist"></a> [repo\_whitelist](#input\_repo\_whitelist) | List of allowed repositories Atlantis can be used with | `list(string)` | `[]` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | Name of Route53 record to create ACM certificate in and main A-record. If null is specified, var.name is used instead. Provide empty string to point root domain name to ALB. | `string` | `null` | no |
| <a name="input_route53_zone_name"></a> [route53\_zone\_name](#input\_route53\_zone\_name) | Route53 zone name to create ACM certificate in and main A-record, without trailing dot | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | List of one or more security groups to be added to the load balancer | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to use on all resources | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of an existing VPC where resources will be created | `string` | n/a | yes |
| <a name="input_vpc_range"></a> [vpc\_range](#input\_vpc\_range) | The CIDR block for the VPC which will be created if `vpc_id` is not specified | `string` | `""` | no |
| <a name="input_webhook_ssm_parameter_name"></a> [webhook\_ssm\_parameter\_name](#input\_webhook\_ssm\_parameter\_name) | Name of SSM parameter to keep webhook secret | `string` | `"/atlantis/webhook/secret"` | no |
| <a name="input_whitelist_unauthenticated_cidr_blocks"></a> [whitelist\_unauthenticated\_cidr\_blocks](#input\_whitelist\_unauthenticated\_cidr\_blocks) | List of allowed CIDR blocks to bypass authentication | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | Dns name of alb |
| <a name="output_alb_zone_id"></a> [alb\_zone\_id](#output\_alb\_zone\_id) | Zone ID of alb |
| <a name="output_atlantis_url"></a> [atlantis\_url](#output\_atlantis\_url) | URL of Atlantis |
| <a name="output_atlantis_url_events"></a> [atlantis\_url\_events](#output\_atlantis\_url\_events) | Webhook events URL of Atlantis |
| <a name="output_ecs_security_group"></a> [ecs\_security\_group](#output\_ecs\_security\_group) | Security group assigned to ECS Service in network configuration |
| <a name="output_ecs_task_definition"></a> [ecs\_task\_definition](#output\_ecs\_task\_definition) | Task definition for ECS service (used for external triggers) |
| <a name="output_task_role_arn"></a> [task\_role\_arn](#output\_task\_role\_arn) | The Atlantis ECS task role arn |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | ID of the VPC that was created or passed in |
| <a name="output_webhook_secret"></a> [webhook\_secret](#output\_webhook\_secret) | Webhook secret |
