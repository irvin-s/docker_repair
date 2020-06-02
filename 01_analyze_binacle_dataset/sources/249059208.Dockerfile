FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="apache-auth-proxy"

RUN set -e && \
    set -x && \
    dnf install -y \
        httpd \
        mod_ssl \
        mod_wsgi \
        mod_auth_mellon && \
    sed -i 's/^Listen 80/#Listen 80/' /etc/httpd/conf/httpd.conf && \
    sed -i 's/^Listen 443 https/#Listen 443 https/' /etc/httpd/conf.d/ssl.conf && \
    dnf clean all && \
    container-base-systemd-reset.sh

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    rm -rfv /etc/httpd/conf.d/* && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets
