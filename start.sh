#!/bin/bash

OWNER=$OWNER
REPO=$REPO
ACCESS_TOKEN=$ACCESS_TOKEN

# Visit https://docs.github.com/en/rest/actions/self-hosted-runners?apiVersion=2022-11-28 for more API calls
REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token | jq .token --raw-output)

cd /home/runner/actions-runner

./config.sh --url https://github.com/${OWNER}/${REPO} --token ${REG_TOKEN}

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
