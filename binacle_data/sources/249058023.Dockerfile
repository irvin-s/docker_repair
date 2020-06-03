FROM centos:latest

MAINTAINER Port Direct <support@port.direct>

ENV OS_DISTRO="HarborOS-Centos" \
    container=docker \
    OS_REPO_BRANCH="master" \
    HARBOR_ETCD_RELEASE_VERSION="v3.0.4" \
    HARBOR_KUBE_RELEASE_VERSION="v1.3.6" \
    HARBOR_REPO_OVS="%%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openvswitch-rpm:%%DOCKER_TAG%%"


COPY ./common-assets /opt/harbor/common-assets

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    yum install -y \
        epel-release && \
    yum update -y && \
    yum upgrade -y && \
    yum install -y \
        findutils \
        iproute \
        bind-utils && \
    yum clean all && \
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
