FROM alpine

ARG BUILD_DATE=undefined

ENV BLACKLABELOPS_HOME=/var/blacklabelops \
    DOCKERIZE_VERSION=v0.6.0

RUN apk upgrade --update && \
    apk add \
      bash \
      tzdata \
      vim \
      tini \
      su-exec \
      gzip \
      tar \
      wget \
      curl && \
    # Network fix
    echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' >> /etc/nsswitch.conf && \
    # Blacklabelops Feature Script Folder
    mkdir -p ${BLACKLABELOPS_HOME} && \
    # Install dockerize
    wget -O /tmp/dockerize.tar.gz https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-alpine-linux-amd64-$DOCKERIZE_VERSION.tar.gz && \
    tar -C /usr/local/bin -xzvf /tmp/dockerize.tar.gz && \
    # Clean up
    apk del curl \
      wget && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/* && \
    rm -rf /var/log/*

COPY imagescripts/ ${BLACKLABELOPS_HOME}/
COPY imagescripts/dockerwait.sh /usr/bin/dockerwait

LABEL maintainer="Steffen Bleul <sbl@blacklabelops.com>" \
      com.blacklabelops.maintainer.name="Steffen Bleul" \
      com.blacklabelops.maintainer.email="sbl@blacklabelops.com" \
      com.blacklabelops.support="https://www.hipchat.com/gEorzhvnI" \
      com.blacklabelops.image.os="alpine" \
      com.blacklabelops.image.osversion="3.7" \
      com.blacklabelops.image.name.alpine="alpine-base-image" \
      com.blacklabelops.image.builddate.alpine=${BUILD_DATE}
