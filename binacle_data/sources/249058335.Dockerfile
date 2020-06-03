FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-fedora:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="keystone-fedora" \
    OS_COMP="keystone" \
    OS_REPO_URL="https://github.com/openstack/keystone.git" \
    OS_REPO_BRANCH="master"

RUN set -e && \
    set -x && \
    dnf install -y \
        openldap-clients \
        cyrus-sasl \
        python-ldap \
        python-ldappool \
        httpd \
        mod_ssl \
        mod_wsgi \
        mod_auth_mellon && \
    sed -i 's/^Listen 80/#Listen 80/' /etc/httpd/conf/httpd.conf && \
    dnf clean all && \
    container-base-systemd-reset.sh

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    rm -rfv /etc/httpd/conf.d/* && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    dnf install -y \
        gcc \
        git \
        libgcc \
        openssl-devel \
        python-devel \
        libffi-devel \
        openldap-devel \
        redhat-rpm-config && \
    /opt/harbor/build/dockerfile.sh && \
    dnf history undo -y $(dnf history | head -3 | tail -1 | awk '{ print $1 }') && \
    dnf clean all && \
    container-base-systemd-reset.sh

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
