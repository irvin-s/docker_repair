FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

ENV OS_COMP="cinder" \
    OS_REPO_URL="https://github.com/openstack/cinder.git" \
    OS_REPO_BRANCH="master"

COPY ./common-assets /opt/harbor/common-assets

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    cat /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache --virtual run-deps \
        py-mysqldb \
        libxml2 \
        libxslt \
        libcurl \
        openssl && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        musl-dev \
        python-dev \
        linux-headers \
        libffi-dev \
        postgresql-dev \
        openssl-dev \
        libxml2-dev \
        libxslt-dev && \
    /opt/harbor/build/dockerfile.sh && \
    apk del build-deps

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
