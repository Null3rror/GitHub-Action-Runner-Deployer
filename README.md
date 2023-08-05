# GitHub-Action-Runner-Deployer
Dockerized GitHub Action Runner Deployer

# Usage
## 1. Cloning
First, clone the project by running:
```
git clone https://github.com/Null3rror/GitHub-Action-Runner-Deployer.git
cd GitHub-Action-Runner-Deployer
```
## 2. Creating Access Token
Then generate an access token from https://github.com/settings/tokens with `repo` and `workflow` scopes. If you want to deploy a runner for your organization then enable `admin:org` scope too.
## 3. Setting up Environment Variables
Modify your [`docker-compose.yml`](https://github.com/Null3rror/GitHub-Action-Runner-Deployer/blob/master/docker-compose.yml) by: 
  1. Adding your `ACCESS_TOKEN` from the previous step
  2. Setting either `ORGANIZATION` or both `OWNER` and `REPO` environment variables
## 4. Deploying
Run: 
```
docker compose build
docker compose up -d
docker logs github-runner-builder-runner-1 -f
```
<br>You should see something like:<br>
```
--------------------------------------------------------------------------------
|        ____ _ _   _   _       _          _        _   _                      |
|       / ___(_) |_| | | |_   _| |__      / \   ___| |_(_) ___  _ __  ___      |
|      | |  _| | __| |_| | | | | '_ \    / _ \ / __| __| |/ _ \| '_ \/ __|     |
|      | |_| | | |_|  _  | |_| | |_) |  / ___ \ (__| |_| | (_) | | | \__ \     |
|       \____|_|\__|_| |_|\__,_|_.__/  /_/   \_\___|\__|_|\___/|_| |_|___/     |
|                                                                              |
|                       Self-hosted runner registration                        |
|                                                                              |
--------------------------------------------------------------------------------

# Authentication
√ Connected to GitHub
# Runner Registration
Enter the name of the runner group to add this runner to: [press Enter for Default]
Enter the name of runner: [press Enter for 74e3ef58aa36]
This runner will have the following labels: 'self-hosted', 'Linux', 'ARM64'
Enter any additional labels (ex. label-1,label-2): [press Enter to skip]
√ Runner successfully added
√ Runner connection is good
# Runner settings
Enter name of work folder: [press Enter for _work]
√ Settings Saved.
√ Connected to GitHub

Current runner version: '2.307.1'
2023-08-05 18:26:02Z: Listening for Jobs
```
