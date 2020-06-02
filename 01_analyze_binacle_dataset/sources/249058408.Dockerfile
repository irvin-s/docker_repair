FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-client:%%DOCKER_TAG%%

USER root

ENV OS_COMP="kuryr-uplink" \
    UPLINK_IMAGE="%%DOCKER_FULLIMAGE%%"

COPY ./common-assets/ /opt/harbor/common-assets

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    apk add --no-cache --virtual run-deps  \
        util-linux \
        iptables \
        ip6tables \
        docker \
        iproute2 \
        jq && \
    pip install python-neutronclient

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
