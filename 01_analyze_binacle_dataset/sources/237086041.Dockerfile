FROM jenkins/jenkins:lts

MAINTAINER Jiří Šimeček <jirka@simecek.org>

USER root

RUN apt-get update && apt-get install -y \
    apt-transport-https \
    software-properties-common

RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu xenial stable"

RUN apt-get update && apt-get install -y \
    docker-ce

RUN usermod -aG docker,staff jenkins

USER jenkins

# Install Jenkins plugins
RUN install-plugins.sh \
    blueocean \
    docker-workflow \
    locale \
    workflow-aggregator \
    pipeline-stage-view \
    git \
    cloudbees-bitbucket-branch-source \
    github-organization-folder
