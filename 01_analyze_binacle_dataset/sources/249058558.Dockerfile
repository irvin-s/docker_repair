FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%marina-base:%%DOCKER_TAG%%

RUN set -e && \
    set -x && \
    sed -i '/\[fedora\]/a exclude=ipsilon*' /etc/yum.repos.d/fedora.repo && \
    sed -i '/\[updates-testing\]/a exclude=ipsilon*' /etc/yum.repos.d/fedora-updates-testing.repo && \
    dnf install -y \
        ipsilon-client \
        expect && \
    dnf clean all  && \
    sed -i "s|/login/form|/login/ldap|g" /usr/bin/ipsilon-client-install && \
    container-base-systemd-reset.sh

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    /bin/rm -rf /opt/harbor/assets && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
