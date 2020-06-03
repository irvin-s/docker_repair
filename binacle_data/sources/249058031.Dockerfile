FROM fedora:latest

MAINTAINER Port Direct <support@port.direct>

ENV OS_DISTRO="HarborOS-Fedora" \
    container=docker \
    OS_REPO_BRANCH="master" \
    HARBOR_ETCD_RELEASE_VERSION="v3.0.4" \
    HARBOR_KUBE_RELEASE_VERSION="v1.3.6" \
    HARBOR_REPO_IPSILON="%%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%ipsilon-rpm:%%DOCKER_TAG%%"  \
    HARBOR_REPO_FREEIPA="%%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%freeipa-rpm:%%DOCKER_TAG%%"

COPY ./common-assets /opt/harbor/common-assets

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    dnf update -y && \
    dnf upgrade -y && \
    dnf install -y \
        findutils \
        iproute \
        bind-utils && \
    dnf clean all && \
    container-base-systemd-reset.sh && \
    mkdir -p /var/run/harbor/secrets

ENTRYPOINT ["/init"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
