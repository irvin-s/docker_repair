#
# Node.js build & development container for the WebApp
#
FROM node:7.0.0

# Install python & the AWS CLI
# The AWS CLI relies on Python
# https://aws.amazon.com/cli/
RUN apt-get update &&  \
    apt-get install python python-setuptools --yes && \
    easy_install pip && \
    pip install awscli && \
    mkdir -p /usr/src/app && \
    rm -rf /var/lib/apt/lists/*

# Copy AWS credentials
COPY deployment/.aws /root/.aws

# Add docker-entrypoint.sh
COPY deployment/docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Set the app source code as workdir
WORKDIR /usr/src/app

# Install app dependencies
COPY app/package.json /usr/src/app/
RUN npm install --no-optional

# Bundle app source
COPY app /usr/src/app

# Build the actual app
# Sample build. You should replace this with a build command of your WebApp stack, e.g: React, Angular2, ...
RUN	npm run build

# Take the latest commit hash as unique version
# Is used by the docker-entrypoint.sh to build artifacts
COPY .git/refs/heads/master /commit_hash.txt

# Create & upload
RUN /usr/local/bin/docker-entrypoint.sh create
RUN /usr/local/bin/docker-entrypoint.sh upload docker-tmp-release
