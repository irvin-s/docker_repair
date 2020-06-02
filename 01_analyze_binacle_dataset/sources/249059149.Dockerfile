FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%centos:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="openvswitch-ovn-base" \
    OVN_DIR="/var/lib/ovn" \
    OVN_SOCKET_DIR="/var/run/openvswitch"

RUN set -e && \
    set -x && \
    yum install -y \
        openvswitch-ovn-central \
        openvswitch-ovn-common && \
    yum clean all && \
    mkdir -p ${OVN_DIR} && \
    mkdir -p ${OVN_SOCKET_DIR} && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
