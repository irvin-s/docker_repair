FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-nova-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="nova-compute-docker"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    apk add --no-cache --virtual run-deps \
        docker \
        ethtool \
        openvswitch \
        sysfsutils \
        open-iscsi \
        util-linux && \
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
