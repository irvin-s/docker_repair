FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%centos:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="openvswitch-base"

RUN set -e && \
    set -x && \
    yum install -y \
        openvswitch && \
    yum clean all && \
    container-base-systemd-reset.sh

VOLUME ["/var/run/openvswitch"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
