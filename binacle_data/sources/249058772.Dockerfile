FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-centos:%%DOCKER_TAG%%

ENV OS_COMP="neutron" \
    OS_REPO_URL="https://github.com/openstack/neutron.git" \
    OS_REPO_BRANCH="master" \
    OS_REPO_COMMIT="f7ec19ad0138a44d5e9d0e539aa7f8066d3d09b0" \
    OS_COMP_1="networking-ovn" \
    OS_REPO_URL_1="https://github.com/openstack/networking-ovn.git" \
    OS_REPO_BRANCH_1="master" \
    OS_REPO_PATCH_SET_1="refs/changes/05/315305/30" \
    OS_COMP_2="neutron-lbass" \
    OS_REPO_URL_2="https://github.com/openstack/neutron-lbaas.git" \
    OS_REPO_BRANCH_2="master"

COPY ./common-assets /opt/harbor/common-assets

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    yum install -y \
        python-openvswitch \
        mariadb \
        mariadb-libs \
        libffi-devel \
        MySQL-python \
        openssl && \
    yum install -y \
        gcc \
        git \
        kernel-lt \
        kernel-lt-headers \
        python-devel \
        postgresql-devel \
        openssl-devel && \
    yum clean all && \
    /opt/harbor/build/dockerfile.sh && \
    yum history undo -y $(yum history package gcc | tail -2 | head -1 | awk '{print $1}') -y && \
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
