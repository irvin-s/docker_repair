FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-httpd:%%DOCKER_TAG%%

ENV OS_COMP="ceilometer" \
    OS_REPO_URL="https://github.com/openstack/ceilometer.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="python-gnocchiclient" \
    OS_REPO_URL_1="https://github.com/openstack/python-gnocchiclient.git" \
    OS_REPO_BRANCH_1="master"

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    mkdir -p /opt/harbor/build && \
    cp -rfav /opt/harbor/common-assets/opt/harbor/build/dockerfile.sh /opt/harbor/build/dockerfile.sh && \
    yum install -y \
        libxml2 \
        libxslt \
        libffi-devel && \
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
    container-base-systemd-reset.sh && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    (rm -rfv /usr/lib/python2.7/site-packages/ceilometer/event/storage/impl_elasticsearch.pyc || true)


LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
