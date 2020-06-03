FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-alpine-common-deps:%%DOCKER_TAG%%

# https://review.openstack.org/#/c/346646/
ENV OS_COMP="neutron" \
    OS_REPO_URL="https://github.com/openstack/neutron.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="networking-ovn" \
    OS_REPO_URL_1="https://github.com/openstack/networking-ovn.git" \
    OS_REPO_BRANCH_1="master" \
    OS_REPO_PATCH_SET_1="refs/changes/46/346646/14" \
    OS_COMP_2="neutron-lbass" \
    OS_REPO_URL_2="https://github.com/openstack/neutron-lbaas.git" \
    OS_REPO_BRANCH_2="master"


COPY ./common-assets/opt/harbor/build/dockerfile.sh /opt/harbor/build/dockerfile.sh

COPY ./common-assets/etc/ /opt/harbor/common-assets/etc

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apk add --no-cache --virtual run-deps  \
        libxml2 \
        libxslt \
        libcurl \
        openssl \
        iproute2 \
        py-mysqldb && \
    pip --no-cache-dir install http://172.17.0.1/python/ovs.tar && \
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

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
