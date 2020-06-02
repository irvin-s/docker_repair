FROM blacklabelops/cronium
MAINTAINER Steffen Bleul <sbl@blacklabelops.com>

# Image Build Date By Buildsystem
ARG BUILD_DATE=undefined

USER root

ENV DOCKER_MACHINE_VERSION=v0.13.0

RUN apk add --update \
      gpgme \
      curl \
      py-pip && \
    pip install --upgrade pip && \
    pip install docker-compose docker-cloud && \
    curl -L https://github.com/docker/machine/releases/download/${DOCKER_MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine && \
    chmod +x /usr/local/bin/docker-machine && \
    # Cleanup
    rm -rf /var/cache/apk/* && rm -rf /tmp/* && rm -rf /var/log/*

# Image Metadata
LABEL com.blacklabelops.application.cronium-docker.docker.version=$DOCKER_VERSION \
      com.blacklabelops.application.cronium-docker.docker-machine.version=$DOCKER_MACHINE_VERSION \
      com.blacklabelops.image.builddate.cronium-docker=${BUILD_DATE}

COPY imagescripts /opt/cloud
ENTRYPOINT ["/sbin/tini","--","/sbin/tini","--","/opt/cloud/docker-entrypoint.sh"]
CMD ["cronium"]
