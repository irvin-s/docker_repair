FROM alpine:3.7
MAINTAINER Eerik Kuoppala <eerik.kuoppala@protacon.com>

ENV DOCKER_HOST unix:///var/run/docker.sock
ARG DOCKER_PATH="/usr/bin"
ARG DOCKER_VERSION="18.03.1"
ARG DOCKER_URI="https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}-ce.tgz"
ARG DOCKER_GID="412"
ARG KUBECTL_VERSION="1.9.2"
ARG KUBECTL_URI="https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
ARG CLOUD_SDK_VERSION="183.0.0"
ENV PATH="/usr/local/google-cloud-sdk/bin:$PATH"

USER root

ADD $WORKSPACE/clairctl /usr/local/bin/
ADD clairctl.yml clairctl.groovy /usr/share/

RUN apk update && \
    apk --no-cache add bash libc6-compat curl openssh-client python py-crcmod && \
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    tar xvzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
    mv google-cloud-sdk /usr/local/google-cloud-sdk && \
    chmod -vR +x /usr/local/google-cloud-sdk/bin && \
    ln -s /lib /lib64 && \
    gcloud config set core/disable_usage_reporting true && \
    gcloud config set component_manager/disable_update_check true && \
    gcloud config set metrics/environment github_docker_image && \
    gcloud --version && \
    curl ${DOCKER_URI} -o /tmp/docker-${DOCKER_VERSION}.tgz && \
    cd /tmp && \
    tar -xvzf /tmp/docker-${DOCKER_VERSION}.tgz docker/docker && \
    mv -v docker/docker ${DOCKER_PATH}/docker && \
    rmdir -v docker && \
    rm -v /tmp/docker-${DOCKER_VERSION}.tgz && \
    chmod -v +x ${DOCKER_PATH}/docker && \
    curl -LO ${KUBECTL_URI} && \
    chmod -v +x ./kubectl && \
    mv -f ./kubectl /usr/local/bin/kubectl && \
    addgroup -S -g ${DOCKER_GID} docker && \
    adduser -S -G docker docker && \
    adduser -G docker -u 10000 -D jenkins && \
    chmod -v +x /usr/local/bin/clairctl && \
    chmod -v +x /usr/share/clairctl.groovy && \
    curl -O https://releases.hashicorp.com/terraform/0.11.3/terraform_0.11.3_linux_amd64.zip && \
    unzip terraform_0.11.3_linux_amd64.zip && \
    rm -v terraform_0.11.3_linux_amd64.zip && \
    mv -f ./terraform /usr/local/bin/terraform && \
    chmod -v +x /usr/local/bin/terraform

USER jenkins
