<h1 align="center"> Project variables </h1>

* [Account](#account)<br>
* [Region](#region)<br>
* [Sensetive](#sensetive)<br>
* [Core's environment variables](#core's-environment-variables)<br>
* [Application's environment variables](#application's-environment-variables)<br>
* [Sensitive Variables](#sensitive-Variables)<br>


<hr>

## Account

* Variables define account
  settings - [account.hcl](../modules/core/template_module/templates/account.hcl.tmpl)

| Variables              | Description                                          | Default |
|:-----------------------|:-----------------------------------------------------|:--------|
| aws_account_id         | Account ID                                           | -       |
| account_name           | Account Name                                         | -       |
| allowed_users          | User are allowed to assume role for account managing | []      |                                |
| accelerator_account_id | Accelerator account Id                               | -       |
| assume_role_arn        | Role to be assumed                                   |         |

## Region

* Variables define region
  settings - [region.hcl](../terragrunt-infrastructure-example/accelerator/accounts/accelerator/regions/example/region.hcl)

| Variables   | Description | Default |
|:------------|:------------|:--------|
| region      | AWS Region  | -       |
| region_name | Region Name | -       |

## Core's environment variables

* Variables define core
  settings - [env.hcl](../terragrunt-infrastructure-example/accelerator/accounts/accelerator/regions/example/core/env.hcl)
  in `core` folder

| Variables                | Description                                                                                                                                    | Default     |
|:-------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|:------------|
| cidr                     | VPC range                                                                                                                                      | 10.0.0.0/16 |                           
| enable_nat_gateway       | Should be true if you want to provision NAT Gateways for each of your private networks                                                         | true        |
| single_nat_gateway       | Should be true if you want to provision a single shared NAT Gateway across all of your private networks                                        | true        |
| reuse_nat_ips            | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | false       |
| external_nat_ip_ids      | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)                                                    | -           |
| nat_prefix_list_ids      | If we use Prefix Lists instead of Cider Blocks, we have to include EIP to this Prefix List for creating security group for NAT                 | -           |
| atlantis_prefix_list_ids | Contains all IPs from GitHub, GitLab, Bitbucket that are allowed to interact with `atlantis`                                                   | -           |
| allowed_prefix_list_ids  | Contains all allowed IPs to interact with our VPC                                                                                              | -           |
| allowed_cidr_blocks      | List of IPv4 CIDR ranges to use on all ingress rules                                                                                           | -           |
| atlantis_name            | Name for Atlantis                                                                                                                              | atlantis    |
| repo_whitelist           | List of repos atlantis will be managing                                                                                                        | -           |
| route53_zone_name        | Route53 zone name for the accelerator part                                                                                                     | -           |
| ======================== | ==== DLT ====                                                                                                                                  | =======     |
| dlt_create               | Chose if DLT framework to be created                                                                                                           | true        |
| admin_name               | User Name for DLT WEB Interface                                                                                                                | user        |
| admin_email              | E-MAIL on which DLT temporary password is to be sent                                                                                           |             |

## Application's environment variables

* Variables define application infrastructure
  settings - [env.hcl](../modules/core/template_module/templates/application-infra-dirrectory/example/env.hcl)
  in `infrastructure-module` folder

| Variables               | Description                                                                                                                                    | Default              |
|:------------------------|:-----------------------------------------------------------------------------------------------------------------------------------------------|:---------------------|
| repo_name               | The name of the application repository.                                                                                                        | "my_repo_name"       |
| ecr_repo_name           | AWS ECR to store built Docker Images from AWS CodePipeline                                                                                     | -                    |
| environments            | Environment names for AWS CodePipeline.                                                                                                        | ["dev", "qa", "uat"] |
| vpc_create              | To create new VPC for application                                                                                                              | true                 |
| cidr                    | VPC range                                                                                                                                      | 10.0.0.0/16          |                                |
| vpc_id                  | VPC Id, if vpc_create = false                                                                                                                  | ""                   |
| enable_nat_gateway      | Should be true if you want to provision NAT Gateways for each of your private networks                                                         | true                 |
| single_nat_gateway      | Should be true if you want to provision a single shared NAT Gateway across all of your private networks                                        | true                 |
| reuse_nat_ips           | Should be true if you don't want EIPs to be created for your NAT Gateways and will instead pass them in via the 'external_nat_ip_ids' variable | false                |
| external_nat_ip_ids     | List of EIP IDs to be assigned to the NAT Gateways (used in combination with reuse_nat_ips)                                                    | []                   |
| nat_prefix_list_ids     | If we use Prefix Lists instead of Cider Blocks, we have to include EIP to this Prefix List for creating security group for NAT                 | []                   |
| allowed_prefix_list_ids | Contains all allowed IPs to use on all ingress rules                                                                                           | []                   |
| allowed_cidr_blocks     | List of IPv4 CIDR ranges to use on all ingress rules                                                                                           | []                   |
| application_port        | External port for docker containers with application                                                                                           | "8080"               |
| cpu                     | CPU allocation (for ECS deployment type only).                                                                                                 | 256                  |
| memory                  | Memory allocation (Only for ECS deploy type).                                                                                                  | 512                  |
| desired_capacity        | Desired capacity of autoscale group or ECS task, accordine to `environment`                                                                    | []                   |
| max_size                | Maximum autoscale group or ECS task size.                                                                                                      | []                   |
| min_size                | Minimum autoscale group or ECS task size.                                                                                                      | []                   |
| target_type             | Deployment switch ("ip" for ECS deployment / "instance" for EC2 deployment)                                                                    | "ip"                 |
| route53_zone_name       | Route53 zone name for the accelerator part                                                                                                     | -                    |
| dns_record_names        | List of DNS Names for each stage for FQDN creation                                                                                             | -                    |
| instance_type           | Instance type for EC2 deployment.                                                                                                              | "t3.micro"           |
| health_path             | Health check path for application LoadBalancer.                                                                                                | "/"                  |
| codedeploy_role_create  | Create role for AWS CodeDeploy. I you have several regions, you need to create such role only one time. Set false for another regions.         | true                 |

* CI/CD
  Infrastructure [env.hcl](../modules/core/template_module/templates/ci-cd-dirrectory/env.hcl)

| Variables               | Description                                                                                                                                                                                                                                | Default                         |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------------------------------|
| stages                  | Map of list defines stage and account                                                                                                                                                                                                      |                                 |
| env_vars                | Variables for environment of ECS Task Definition                                                                                                                                                                                           | {}                              |
| admin_name              | Administrator account name for the DLT console. Any name.                                                                                                                                                                                  | "user"                          |
| app_fqdn                | FQDN for application endpoints to be tested                                                                                                                                                                                                |                                 |
| build_success           | If "true", you will also get notifications about successful builds.                                                                                                                                                                        | "false"                         |
| cognito_password_name   | The path for the dlt password in the AWS ParameterStore where DLT `password` store.  See the [dlt.md](dlt.md) file for more details.                                                                                                       | "/cognito/password"             |
| connection_provider     | Connection provider for pull requests (Bitbucket, GitHub, GitLab, CodeCommit).                                                                                                                                                             | "GitLab"                        |
| display_name            | Name that is displayed as a sender when you receive notifications on your email address.                                                                                                                                                   | "SNS-Email"                     |
| email_addresses         | List of email addresses for email notifications. First email will be used for receiving password from DLT.                                                                                                                                 | ["my_user@my_domain.com"]       |
| expiration_days         | Amount of days after artifacts from the AWS Code Pipeline will be removed.                                                                                                                                                                 | "30"                            |
| force_destroy           | Delete bucket when destroy: true or false                                                                                                                                                                                                  | true                            |
| organization_name       | Organization name for Sonar.                                                                                                                                                                                                               | -                               |
| project_key             | Project key for Sonar.                                                                                                                                                                                                                     | -                               |
| repo_default_branch     | Default branch name for AWS CodePipeline.                                                                                                                                                                                                  | "master"                        |
| repo_name               | The name of the application repository.                                                                                                                                                                                                    | "my_repo_name"                  |
| rp_endpoint             | ReportPortal endpoint URL.                                                                                                                                                                                                                 | "https://reportportal.epam.com" |
| rp_project              | Name of a project in ReportPortal.                                                                                                                                                                                                         | -                               |
| rp_token_name           | The path for the ReportPortal token in the AWS ParameterStore.                                                                                                                                                                             | "/report/portal/token"          |
| sonar_url               | Sonar node address.                                                                                                                                                                                                                        | "https://sonarcloud.io"         |
| sonarcloud_token_name   | The path for the Sonar login in the AWS ParameterStore.                                                                                                                                                                                    | "/sonar/token"                  |
| target_type             | Deployment switch ("ip" for ECS deployment / "instance" for EC2 deployment)                                                                                                                                                                | "ip"                            |
| cpu                     | CPU allocation,for ECS deployment type only, to be set in Task Definition.                                                                                                                                                                 | 256                             |
| memory                  | Memory allocation, for ECS deployment type only, to be set in Task Definition.                                                                                                                                                             | 512                             |
| ----------              | ----------- Carrier --------------                                                                                                                                                                                                         |                                 |
| carrier_create          | Create Carrier test action in AWS CodePipeline or not                                                                                                                                                                                      |                                 |
| carrier_auth_token_name | Carrier tocken to connect                                                                                                                                                                                                                  |                                 |
| carrier_project_id      | Carrier Project Id                                                                                                                                                                                                                         |                                 |
| carrier_test_id         | yCarrier test  nedds to be run                                                                                                                                                                                                             |                                 |
| carrier_url             | Carrier URL                                                                                                                                                                                                                                |                                 |
| -----------             | ------------------ DLT -----------                                                                                                                                                                                                         |                                 |
| dlt_create              | Create DLT test action in AWS CodePipeline or not                                                                                                                                                                                          | true                            |
| dlt_test_name           | Name of DLT test to be run                                                                                                                                                                                                                 |                                 |
| dlt_test_id             | DLT test ID to be run                                                                                                                                                                                                                      |                                 |
| dlt_test_type           | DLT test type: `simple` or `jmeter`                                                                                                                                                                                                        | simple                          |
| dlt_task_count          | Number of containers that will be launched in the Fargate cluster to run the test scenario. Additional tasks will not be created once the account limit on Fargate resources has been reached, however tasks already running will continue | 1                               |
| concurrency             | The number of concurrent virtual users generated per task. The recommended limit based on default settings is 200 virtual users.                                                                                                           | 1                               |
| ramp_up                 | The time to reach target concurrency                                                                                                                                                                                                       | 1m                              |
| hold_for                | Time to hold target concurrency.                                                                                                                                                                                                           | 1m                              |
| admin_name              | User Name for DLT WEB Interface                                                                                                                                                                                                            | user                            |

## Sensitive Variables

* Core Variables [parameter_store_example.hcl](../terragrunt-infrastructure-example/parameter_store_example.hcl)

| Variables         | Descriptions                                                             | Default |
|:------------------|:-------------------------------------------------------------------------|:--------|
| infracost_api_key | Token for Infracost.                                                     | -       |
| cognito_password  | Password  you will replace during your first visit to DLT Test Web Page. | -       |
| c7n_user          | EPAM Custodian User Name.                                                | -       |
| c7n_password      | Password from EPAM Custodian.                                            | -       |
| c7n_api_url       | EPAM Custodian URL.                                                      | -       |
| dojo_api_key      | Token from DOJO if you use EPAM Custodian.                               | -       |

| *Atlantis*: one of VSC we need to choose | Variables                     | Description                    | Default   |
|:-----------------------------------------|:------------------------------|:-------------------------------|:----------|
| GitHub                                   | github_user                   | GitHub technical user          | -         |
|                                          | atlantis_github_user_token    | GitHub technical user token    | -         |
|                                          | organization_name             | GitHub organization name       | -         |
|                                          | vcs                           | Name of vcs integration folder | github    |
| GitLab                                   | gitlab_user                   | GitLab technical user          | -         |
|                                          | atlantis_gitlab_user_token    | GitLab technical user token    | -         |
|                                          | atlantis_gitlab_hostname      | GitLab hostname URL            | -         |
|                                          | project_id                    | GitLab project id              | -         |
|                                          | vcs                           | Name of vcs integration folder | gitlab    |
|                                          |                               |                                |           |
| BitBucket                                | bitbucket_user                | BitBucket technical user       | -         |
|                                          | atlantis_bitbucket_user_token | BitBucket technical user token | -         |
|                                          | atlantis_bitbucket_base_url   | BitBucket base URL             | -         |
|                                          | vcs                           | Name of vcs integration folder | bitbacket |

* Application Parameter Store
  Variables [app_parameter_store_example.hcl](../terragrunt-infrastructure-example/accelerator/accounts/accelerator/regions/example/setup_folder/applications/example/app_parameter_store_example.hcl)

| Variables        | Descriptions                                          | Default                  |
|:-----------------|:------------------------------------------------------|:-------------------------|
| parameter_store  | List of Maps with Parameter Store Variables           | -                        |
| sonarcloud_token | Token for SonarCloud.                                 | -                        |
| teams_web_hook   | Teams WebHook if you use Teams for Notifications.     | -                        |
| slack_web_hook   | Slack WebHook if you use Slack for Notifications.     | -                        |
| rp_token         | Token for Report Portal.                              | -                        |
| ---              | --- AWS-GitLab Integration ---                        | ---                      |
| gitlab_hostname  | GitLab HostName                                       | -                        |
| project_id       | GitLab Project ID                                     | -                        |
| aws_user_name    | AWS User whose SSH key we use for AWS CodeCommit      | -                        |
| gitlab_token     | Token for GitLab Project                              | -                        |
| aws_repo_name    | Name of AWS CodeCommit Repository(The same as GitLab) | -                        |
| gitlab_user      | GitLab User Name                                      | -                        |
| app_language     | Language an application is written                    | "go", "python" or "java" |


