FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-ubuntu:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="keystone-ubuntu" \
    OS_COMP="keystone" \
    OS_REPO_URL="https://github.com/openstack/keystone.git" \
    OS_REPO_BRANCH="master"

RUN set -e && \
    set -x && \
    apt-get update -y && \
    apt-get install --no-install-recommends -y \
        ldap-auth-client \
        sasl2-bin \
        python-ldap \
        python-ldappool \
        apache2 \
        libapache2-mod-wsgi \
        libapache2-mod-auth-mellon && \
    a2enmod ssl && \
    rm -f /etc/apache2/sites-enabled/000-default.conf && \
    sed -i 's/^Listen 80/#Listen 80/' /etc/apache2/ports.conf && \
    apt-get clean all

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    rm -rfv /etc/httpd/conf.d/* && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    apt-get update -y && \
    apt-get install --no-install-recommends -y \
        gcc \
        git \
        libssl-dev \
        python-dev \
        libffi-dev \
        libldap2-dev && \
    /opt/harbor/build/dockerfile.sh && \
    APT_LAST_INSTALLED=$(awk '!/^Start|^Commandl|^End|^Upgrade:|^Error:/ { gsub( /\([^()]*\)/ ,"" );gsub(/ ,/," ");sub(/^Install:/,""); print}' /var/log/apt/history.log | tail -n 1) && \
    apt-get remove -y ${APT_LAST_INSTALLED} && \
    apt-get clean all

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
