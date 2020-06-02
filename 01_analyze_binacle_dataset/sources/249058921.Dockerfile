FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-nova-alpine:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="nova-api-metadata"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    chmod 0640 /etc/sudoers && \
    echo "nova ALL = (root) NOPASSWD: /usr/bin/nova-rootwrap" >> /etc/sudoers && \
    echo "Defaults!/usr/bin/nova-rootwrap !requiretty" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers

USER nova

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
