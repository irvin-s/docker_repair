FROM node:9.2.1-alpine

ENV AWS_CLI_VERSION 1.14.7
ENV CLOUD_SDK_VERSION 182.0.0
ENV WATCHMAN_VERSION 4.9.0
ENV DOCKER_COMPOSE_VERSION 1.17.0
ENV PATH /google-cloud-sdk/bin:$PATH
ENV GOOGLE_APPLICATION_CREDENTIALS /gcp-key.json

RUN set -ex; \
    apk add --no-cache bash git openssl-dev openssh-client ca-certificates curl g++ libc6-compat \
        linux-headers make autoconf automake libtool python-dev py-crcmod py2-pip libc6-compat; \
    # AWS CLI
    pip install awscli==${AWS_CLI_VERSION}; \
    aws --version; \
    # Google Cloud SDK
    curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz; \
    ln -s /lib /lib64; \
    gcloud config set core/disable_usage_reporting true; \
    gcloud config set component_manager/disable_update_check true; \
    gcloud components install kubectl; \
    gcloud --version; \
    # Docker
    apk add --no-cache docker; \
    docker --version; \
    # Docker Compose
    pip install docker-compose==${DOCKER_COMPOSE_VERSION}; \
    docker-compose --version; \
    # Watchman
    cd /tmp; curl -LO https://github.com/facebook/watchman/archive/v${WATCHMAN_VERSION}.tar.gz; \
    tar xzf v${WATCHMAN_VERSION}.tar.gz; rm v${WATCHMAN_VERSION}.tar.gz; \
    cd watchman-${WATCHMAN_VERSION}; \
    ./autogen.sh; ./configure; make && make install; \
    cd /tmp; rm -rf watchman-${WATCHMAN_VERSION}; \
    watchman --version;
