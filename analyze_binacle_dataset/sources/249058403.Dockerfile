FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%freeipa-client:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="marina"


ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    yum install -y \
        ssmtp \
        mutt && \
    yum clean all && \
    pip install python-openstackclient && \
    mv /bin/hostnamectl /bin/hostnamectl-real && \
    /bin/cp -rf /opt/harbor/assets/* / && \
    /bin/rm -rf /opt/harbor/assets && \
    container-base-systemd-reset.sh

CMD ["/usr/sbin/init-systemd-env"]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
