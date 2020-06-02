FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-keystone-fedora:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="keystone-api"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    chown keystone:keystone /etc/keystone/sso_callback_template.html && \
    chmod 0640 /etc/sudoers && \
    echo "keystone ALL = (root) NOPASSWD: /usr/sbin/httpd" >> /etc/sudoers && \
    echo "Defaults!/usr/sbin/httpd !requiretty" >> /etc/sudoers && \
    chmod 0440 /etc/sudoers

USER keystone

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
