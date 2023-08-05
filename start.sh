#!/bin/bash

cd /home/runner/actions-runner

if ! [ -z $ORGANIZATION ]; then
    echo "Creating a runner for organization: ${ORGANIZATION}..."
    REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/orgs/${ORGANIZATION}/actions/runners/registration-token | jq .token --raw-output)
    ./config.sh --url https://github.com/${ORGANIZATION} --token ${REG_TOKEN}
elif ! [ -z $OWNER ] && ! [ -z $REPO ]; then
    echo "Creating a runner for ${OWNER}/${REPO}..."
    REG_TOKEN=$(curl -sX POST -H "Authorization: token ${ACCESS_TOKEN}" https://api.github.com/repos/${OWNER}/${REPO}/actions/runners/registration-token | jq .token --raw-output)
    ./config.sh --url https://github.com/${OWNER}/${REPO} --token ${REG_TOKEN}
else
    echo "ORGANIZATION or OWNER and REPO enviromental variables were not defined!"
    echo "Define either one of them in your docker-compose.yml"
    echo "Exiting..."
    exit 1
fi

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!
