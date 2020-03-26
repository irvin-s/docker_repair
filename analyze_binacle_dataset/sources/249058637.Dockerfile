FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

ENV OS_COMP="barbican" \
    OS_REPO_URL="https://github.com/openstack/barbican.git" \
    OS_REPO_BRANCH="master"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apk add --no-cache --virtual run-deps  \
        libxml2 \
        libxslt \
        libcurl \
        openssl \
        nss \
        nss-tools \
        uwsgi-python && \
    apk add --no-cache --virtual build-deps \
        gcc \
        git \
        musl-dev \
        linux-headers \
        libffi-dev \
        python-dev \
        postgresql-dev \
        openssl-dev \
        libxml2-dev \
        libxslt-dev \
        curl \
        cmake \
        pkgconf \
        unzip \
        build-base \
        nss-dev && \
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
