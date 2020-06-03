FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-centos:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="base-httpd"

RUN set -e && \
    set -x && \
    yum install -y \
        httpd \
        mod_ssl \
        mod_wsgi && \
    yum clean all && \
    sed -i 's/^Listen 80/#Listen 80/' /etc/httpd/conf/httpd.conf && \
    sed -i 's/^Listen 443 https/#Listen 443 https/' /etc/httpd/conf.d/ssl.conf && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
