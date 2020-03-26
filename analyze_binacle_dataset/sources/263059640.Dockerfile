# Docker Cli

FROM alpine:latest AS dockercli

ARG DOCKER_VERSION=18.09.0

RUN wget -O docker.tgz https://download.docker.com/linux/static/stable/x86_64/docker-$DOCKER_VERSION.tgz && \
    tar -xvzf docker.tgz && \
    chmod +x docker/docker

# Jenkins-Slave

FROM jenkins/jnlp-slave:3.27-1-alpine

COPY --from=dockercli docker/docker /usr/local/bin/docker  
USER root # This is required for the Docker Sock 

ENTRYPOINT ["jenkins-slave"]
