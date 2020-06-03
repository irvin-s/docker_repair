FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

ENV OS_COMP="gnocchi" \
    OS_REPO_URL="https://github.com/openstack/gnocchi.git" \
    OS_REPO_BRANCH="master" \
    GNOCCHI_STORAGE_BACKEND="file"

COPY ./common-assets/opt/harbor/build/dockerfile.sh /opt/harbor/build/dockerfile.sh

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps  \
        libxml2 \
        libxslt \
        libcurl \
        openssl && \
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
        build-base && \
    /opt/harbor/build/dockerfile.sh && \
    apk del build-deps

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
