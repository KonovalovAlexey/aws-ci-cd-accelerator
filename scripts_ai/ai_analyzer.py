import requests
import os
import git
import re
import subprocess
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
limit_of_ai_iteration = 2

local_repo_path = f"{home}/.atlantis/repos/{repo_owner}/{repo_name}/{current_pull_request_number}/{workspace}"
output_file_name = "error.log"


def read_file_content(file_name, terraform_full_path):
    full_file_path = os.path.join(terraform_full_path, file_name)
    with open(full_file_path, 'r') as f:
        file_content = f.read()
    return file_content, full_file_path


def process_log_and_extract_errors(error_log):
    prefix_pattern = r'level=\w+ msg=Terraform invocation failed in (.+\.terragrunt-cache[^\s]+)'
    error_pattern = r'(Error:.+?)(?=Error:|$)'
    file_pattern = r'on (\S+\.tf)? ?line \d+.*\n *\d+: *'
    module_pattern = re.compile(r"modules/(.*)")
    prefix_matches = re.findall(prefix_pattern, error_log)
    error_matches = re.findall(error_pattern, error_log, flags=re.DOTALL)

    extracted_errors = []

    terrugrunt_prefix = ''
    if prefix_matches:
        terrugrunt_prefix = prefix_matches[0]

    for error in error_matches:
        error = error.strip()
        file_match = re.search(file_pattern, error)
        file_name = file_match.group(1) if file_match else None
        terraform_full_path = terrugrunt_prefix.rstrip()
        module_match = module_pattern.search(terraform_full_path)
        module_path = (f"modules/{module_match.group(1)}")
        file_in_module = (f"modules/{module_match.group(1)}/{file_name}")
        origin_file, full_file_path = read_file_content(file_name, terraform_full_path)
        extracted_errors.append(
            (origin_file, error, file_name, full_file_path, terraform_full_path, module_path, file_in_module))

    return extracted_errors


def communicate_with_ai(api_endpoint, api_key, origin_file, error, file_name, full_file_path, file_in_module):
    full_path_file_in_module = local_repo_path + "/" + file_in_module
    request_headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer " + api_key
    }
    request_data = {
        "model": f"{llm_model}",
        "prompt": f"Please read this {error} and the original content of the file {origin_file}. Rewrite a file {file_name} with the error fix.",
        "max_tokens": 1500,
        "temperature": 0.7
    }

    response = requests.post(api_endpoint, headers=request_headers, json=request_data)

    if response.status_code == 200:
        error_fix = response.json()["choices"][0]["text"]

        # Write the error_fix to the file
        with open(full_path_file_in_module, 'w') as f:
            f.write(error_fix)

        return error_fix
    else:
        return None


def get_branch_info(local_repo_path):
    repo = git.Repo(local_repo_path)
    active_branch = repo.active_branch.name
    return active_branch


def configure_git_user():
    # Set the Git user email and name globally
    git.Git().config("--global", "user.email", "open_ai@example.com")
    git.Git().config("--global", "user.name", "AI Robot")


def set_http_post_buffer(repository_path, buffer_size_bytes):
    repo = git.Repo(repository_path)
    config = repo.config_writer()

    config.set_value("http", "postBuffer", str(buffer_size_bytes))

    config.release()


def detect_ai_branches(access_token, repo_owner, repo_name, head_branch_name, g):
    # Get the repository object
    repo = g.get_repo(f"{repo_owner}/{repo_name}")
    # Get a list of all branches
    branches = repo.get_branches()

    # Filter and collect the names of branches containing the head_branch_name
    matching_branches = [branch.name for branch in branches if head_branch_name in branch.name]

    # Check for -ai-fix prefix and count occurrences
    ai_fix_suffixes = ["-ai-fix-{:03d}".format(i) for i in range(1, 1000)]  # Adjust the range as needed
    ai_fix_branches = [branch for branch in matching_branches if
                       any(branch.endswith(suffix) for suffix in ai_fix_suffixes)]
    ai_fix_count = len(ai_fix_branches)

    return ai_fix_count


def create_branch_and_push(access_token, head_branch_name, ai_branches_count):
    repo = git.Repo(f'{local_repo_path}')
    commit_message = "AI Proposal"

    # Create a new branch with the postfix "-ai-fix"
    new_branch_name = f"{head_branch_name}-ai-fix-{ai_branches_count}"
    repo.git.checkout(repo.active_branch)
    repo.git.branch(new_branch_name)
    repo.git.checkout(new_branch_name)

    # Add all changes to the staging area
    repo.git.add(all=True)

    # Commit the changes
    repo.git.commit(m=commit_message)

    # Push the changes to the new branch
    origin = repo.remote(name='origin')
    origin.push(new_branch_name)
    return new_branch_name


def create_new_pull_request(access_token, base_repo_owner, base_repo_name, head_branch, title, body):
    g = Github(access_token)
    repo = g.get_repo(f"{base_repo_owner}/{base_repo_name}")
    base_branch = repo.get_branch(
        head_branch_name)  # managed by atlantis.yaml as environment variable. Set the branch where we apply AI fixes
    head_ref = f"{base_repo_owner}:{head_branch}"

    pull_request = repo.create_pull(
        title=title,
        body=body,
        base=base_branch.name,
        head=head_ref
    )

    print(f"A new pull request created successfully. Number: {pull_request.number}")
    return pull_request.number


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
        pull_request.create_issue_comment(f"{comment}")


def main():
    g = Github(auth=auth)

    # Workaround to set HTTP buffer size for POST requests. 2GB satisfies this requirement
    set_http_post_buffer(local_repo_path, 2147483648)
    with open(output_file_name) as file:
        lines = file.read()
        print(lines)
        file.close()

    extracted_errors = process_log_and_extract_errors(lines)

    for origin_file, error, file_name, full_file_path, terraform_full_path, module_path, file_in_module in extracted_errors:
        error_fix = communicate_with_ai(api_endpoint, api_key, origin_file, error, file_name, full_file_path,
                                        file_in_module)
        print(f'Solution provided by AI: {error_fix}')
        # comment = f"{error_fix}"
        # leave_pull_request_comment(access_token, repo_owner, repo_name, current_pull_request_number, comment, file_name)

    ai_branches_count = detect_ai_branches(access_token, repo_owner, repo_name, head_branch_name, g)
    if ai_branches_count >= limit_of_ai_iteration:
        comment = f"AI analyzer limited by {limit_of_ai_iteration} attempts. Please try to fix the issue manually."
        print(f"AI analyzer limited by {limit_of_ai_iteration} attempts. Please try to fix the issue manually.")
        leave_pull_request_comment(access_token, repo_owner, repo_name, current_pull_request_number, comment)
        exit(1)
    else:
        ai_branches_count += 1  # Number of iteration starts from 1 (instead of 0)
        ai_branches_count = f"{ai_branches_count:03d}"
        new_branch_name = create_branch_and_push(access_token, head_branch_name, ai_branches_count)
        print(f"New Branch: {new_branch_name}")
        base_repo_owner = repo_owner
        base_repo_name = repo_name
        head_branch = new_branch_name
        title = f"refactor(AI Proposal): {head_branch}"
        body = "Pull Request Created by AI"

        new_pull_request_number = create_new_pull_request(access_token, base_repo_owner, base_repo_name, head_branch,
                                                          title, body)

        comment = f"A new pull request has been created with a number #{new_pull_request_number}"

        leave_pull_request_comment(access_token, base_repo_owner, base_repo_name, current_pull_request_number, comment)
        exit(1)


if __name__ == "__main__":
    main()
