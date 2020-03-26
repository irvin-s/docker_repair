FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-neutron-alpine:%%DOCKER_TAG%%

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories && \
    apk add --no-cache --virtual run-deps  \
        arping \
        ip6tables \
        openvswitch && \
    chmod 0640 /etc/sudoers && \
    echo "neutron ALL = (root) NOPASSWD: /usr/bin/neutron-rootwrap-daemon" >> /etc/sudoers && \
    echo "Defaults!/usr/bin/neutron-rootwrap-daemon !requiretty" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers

USER neutron

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
