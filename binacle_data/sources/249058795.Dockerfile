FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

ENV OS_COMP="ceilometer" \
    OS_REPO_URL="https://github.com/openstack/ceilometer.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="python-gnocchiclient" \
    OS_REPO_URL_1="https://github.com/openstack/python-gnocchiclient.git" \
    OS_REPO_BRANCH_1="master"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    mkdir -p /opt/harbor/build && \
    cp -rfav /opt/harbor/common-assets/opt/harbor/build/dockerfile.sh /opt/harbor/build/dockerfile.sh && \
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
    apk del build-deps && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    (rm -rfv /usr/lib/python2.7/site-packages/ceilometer/event/storage/impl_elasticsearch.pyc || true)

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
