import requests
import os
from github import Github
from github import Auth

api_endpoint = "https://api.openai.com/v1/completions"
api_key = os.getenv("OPENAI_TOKEN")
llm_model = "text-davinci-003"

# using an access token
auth = Auth.Token(os.getenv("GITHUB_TOKEN"))
access_token = os.getenv("GITHUB_TOKEN")

# read internal environment variables of repository
repo_name = os.getenv("HEAD_REPO_NAME")
repo_owner = os.getenv("BASE_REPO_OWNER")
current_pull_request_number = os.getenv("PULL_NUM")
workspace = os.getenv("WORKSPACE")
home = os.getenv("HOME")
base_branch_name = os.getenv("BASE_BRANCH_NAME")
head_branch_name = os.getenv("HEAD_BRANCH_NAME")

# Public Web GitHub
g = Github(auth=auth)

output_file_name = "regula_report.log"


def communicate_with_ai(api_endpoint, api_key, error):
    request_headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + api_key
    }
    request_data = {
        "model": f"{llm_model}",
        "prompt": f"In this Regula report: {error} \n please generate a terraform code for each error with the title of the issue description. All text as a comment",
        "max_tokens": 1500,
        "temperature": 0.7
    }

    response = requests.post(api_endpoint, headers=request_headers, json=request_data)

    if response.status_code == 200:
        error_fix = response.json()["choices"][0]["text"]
        return error_fix
    else:
        return None


def leave_pull_request_comment(access_token, repo_owner, repo_name, current_pull_request_number, comment,
                               file_name=None):
    g = Github(access_token)
    repo = g.get_repo(f"{repo_owner}/{repo_name}")

    # by default current_pull_request_number considers as not an integer value, so we forced convert it
    pull_request = repo.get_pull(int(current_pull_request_number))

    # we use ``` to make a comment more pretty and wrapped as a code in terms of GitHub
    if file_name:
        pull_request.create_issue_comment(f"{file_name}\n" + f"```{comment}")
    else:
        pull_request.create_issue_comment("Please review an example of a Regula report correction\n" + f"```{comment}")


with open(output_file_name) as file:
    report_lines = file.read()
    file.close

error_fix = communicate_with_ai(api_endpoint, api_key, report_lines)
comment = f"{error_fix}"
leave_pull_request_comment(access_token, repo_owner, repo_name, current_pull_request_number, comment)
