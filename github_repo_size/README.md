# Script which returns repo size in MB.

This bash script returns the size of a GitHub repository in MB.

## Prerequisite

- Works good with Linux.
- Needs `brew install jq` for mac

## Usage

`export GITHUB_TOKEN=<your-github-token>`

`bash repo.sh $GITHUB_TOKEN <org/user_name> <repo_name>`

## Dependencies

- Depends on GitHub API.
- Requires GitHub token for private repo's.
