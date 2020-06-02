FROM ubuntu:latest

MAINTAINER Port Direct <support@port.direct>

ENV OS_DISTRO="HarborOS-Ubuntu" \
    container=docker \
    OS_REPO_BRANCH="master" \
    HARBOR_ETCD_RELEASE_VERSION="v3.0.4" \
    HARBOR_KUBE_RELEASE_VERSION="v1.3.6" \
    DEBIAN_FRONTEND="noninteractive"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        findutils \
        iproute \
        dnsutils && \
    apt-get clean all && \
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
