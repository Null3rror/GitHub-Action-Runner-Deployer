FROM ubuntu:22.04

ARG RUNNER_VERSION="2.307.1"

# update the base packages and add a non-sudo user
RUN apt-get update -y && apt-get upgrade -y && useradd -m runner

# install python and the packages that your code depends on along with jq so we can parse JSON responses from GitHub API
# add additional packages as necessary
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    curl jq build-essential libssl-dev libffi-dev python3 python3-venv python3-dev python3-pip

RUN ARCH="$(dpkg --print-architecture)" \
    && cd /home/runner && mkdir actions-runner && cd actions-runner \
    && curl -O -L https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-${ARCH}-${RUNNER_VERSION}.tar.gz

# set the ownership of /home/runner/* to runner and install some additional dependencies
RUN chown -R runner ~runner && /home/runner/actions-runner/bin/installdependencies.sh

COPY start.sh start.sh

RUN chmod +x start.sh

# since the config and run script for actions are not allowed to be run by root,
# set the user to "runner" so all subsequent commands are run as the runner user
USER runner

# set the entrypoint to the start.sh script
ENTRYPOINT ["./start.sh"]
