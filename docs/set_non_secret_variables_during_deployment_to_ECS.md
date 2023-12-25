<h1 align="center"> Instructions for Passing environments Non-Secret Variables during deployment to ECS </h1>
Usually applications use environment variables. This is documentation about how to pass non-secret environment variables during deployment to ECS 

After creating the `terragrunt-infrastructure-live` directory with your application inside, you'll need to store information about non-secret variables for each environment. This instruction provides an example path and code for configuring these variables.

#### 1. Navigating to Non-Secret Variables
- Navigate to the folder corresponding to your environment, for example: `terragrunt-infrastructure-live/accelerator/accounts/accelerator/regions/eu-central-1/applications/javaapp`.
- In this folder, you should have a file named `env.hcl` containing information about non-sensitive variables for that environment.

#### 2. Adding Non-Secret Variables in the `env.hcl` File
- Open the `env.hcl` file for editing.
- In this file, there is a piece of code that describes non-sensitive variables for different environments (`dev, qa, uat`). This code is presented as a list, with each variable having a name and value.

```
env_vars = {
    dev = [
      {
        name = "DEV_VAR1",
        value = "DEV_VALUE1"
      },
      {
        name = "DEV_VAR2",
        value = "DEV_VALUE2"
      }
    ]

    qa  = [
      {
        name = "QA_VAR1",
        value = "QA_VALUE1"
      },
      {
        name = "QA_VAR2",
        value = "QA_VALUE2"
      }
    ]

    uat = [
      {
        name = "UAT_VAR1",
        value = "UAT_VALUE1"
      },
      {
        name = "UAT_VAR2",
        value = "UAT_VALUE2"
      }
    ]
  }
```
- For each environment (`dev, qa, uat`), add the non-secret variables required for your application.
- Replace `name` and `value` with the appropriate values for your application.

#### 4. Deployment Workflow
- Save the `env.hcl` file after adding the non-secret variables.
- Push the changes to the repository.
- Create a pull request and Atlantis will run the `terragrunt plan` command.
- If everything fine after `terragrunt plan`, add pull request comment - `atlantis apply` to apply changes.
  
  **_Attention!_** Do not specified secrets in `env_vars`! Secret should not be stored in plain text in Git.
  See documentation [Instructions for Passing environments Secret Variables during deployment to ECS](../docs/set_secret_variables_during_deployment_to_ECS.md) how to use secrets.

Please make sure to replace `NAME` and `VALUE` with the actual values used by your application.


