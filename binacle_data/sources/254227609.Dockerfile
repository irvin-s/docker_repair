FROM alpine:latest
MAINTAINER William Huba <william.huba@docurated.com>

ENV VAULT_VERSION 0.6.1

RUN apk update && apk add --no-cache \
    openssl \
    jq \
    curl \
    bash

# Download, unzip the given version of vault and set permissions
RUN wget -qO /tmp/vault.zip https://releases.hashicorp.com/vault/${VAULT_VERSION}/vault_${VAULT_VERSION}_linux_amd64.zip && \
      unzip -d /bin /tmp/vault.zip && rm /tmp/vault.zip && chmod 755 /bin/vault

ADD assets/ /opt/resource/
RUN chmod +x /opt/resource/*
