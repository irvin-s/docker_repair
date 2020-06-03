# The jenkinZ CI environment uses dind.  
# This environment consists of a jenkins-master and a build-agent

FROM docker:stable-dind as jenkinz

ARG JENKINS_USER
ARG JENKINS_MASTER
ARG AGENT_NAME
ARG AGENT_EXECUTORS
ARG AGENT_LABEL
ARG FS_ROOT

ENV JENKINS_USER ${JENKINS_USER}
ENV JENKINS_MASTER ${JENKINS_MASTER}
ENV AGENT_NAME ${AGENT_NAME}
ENV AGENT_EXECUTORS ${AGENT_EXECUTORS}
ENV AGENT_LABEL ${AGENT_LABEL}
ENV FS_ROOT ${FS_ROOT}


RUN apk update && apk add openjdk8 bash make git jq curl python python-dev py-pip

# The Swarm client jar is used to connect the build agent to the jenkins master
ADD swarm-client-3.15.jar /opt/swarm.jar

# The jenkins-cli jar is used to manage the build life cycle
ADD jenkins-cli.jar /opt/jenkins-cli.jar

# The jenkins-commands script container helper functions for managing the life cycle of jenkinz
COPY commands /usr/bin/

# Install docker-compose
#RUN pip install 'docker-compose==1.20.0'

# Add config for squid http proxy. Disable for now.
#RUN mkdir /root/.docker
#ADD config.json /root/.docker/config.json

# This script contains a simple dns entry which may be removable in future
ADD jenkinz-entrypoint.sh /usr/local/bin/dockerd-entrypoint.sh
RUN chmod +x /usr/local/bin/dockerd-entrypoint.sh 
