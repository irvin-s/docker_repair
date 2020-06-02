FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%centos:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="base-centos" \
    LC_ALL="en_US.UTF-8"

RUN set -e && \
    set -x && \
    yum install -y \
        centos-release-gluster37 \
        centos-release-openstack-mitaka && \
    yum update -y && \
    yum install -y \
        python \
        sudo \
        curl \
        python-pip \
        mariadb-client && \
    yum clean all && \
    container-base-systemd-reset.sh && \
    chmod 0640 /etc/sudoers && \
    sed -i '/Defaults    requiretty/s/^/#/' /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    pip --no-cache-dir install --upgrade pip setuptools && \
    pip --no-cache-dir install crudini && \
    pip --no-cache-dir install PyMySQL && \
    pip --no-cache-dir install python-memcached

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
