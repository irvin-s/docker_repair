FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-centos:%%DOCKER_TAG%%

ENV OS_COMP="designate" \
    OS_REPO_URL="https://github.com/openstack/designate.git" \
    OS_REPO_BRANCH="master"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    yum install -y \
        libxml2 \
        libxslt \
        libffi-devel \
        MySQL-python && \
    yum install -y \
        gcc \
        git \
        kernel-lt \
        kernel-lt-headers \
        python-devel \
        libxml2-devel \
        libxslt-devel \
        postgresql-devel \
        openssl-devel && \
    /opt/harbor/build/dockerfile.sh && \
    yum history -y undo $(yum history list gcc | tail -2 | head -1 | awk '{ print $1}') && \
    yum clean all && \
    container-base-systemd-reset.sh


LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
