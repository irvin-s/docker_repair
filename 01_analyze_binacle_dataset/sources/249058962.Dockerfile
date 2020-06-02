FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-centos:%%DOCKER_TAG%%

ENV OS_COMP="python-cinderclient" \
    OS_REPO_URL="https://github.com/openstack/python-cinderclient.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="brick-cinderclient-ext" \
    OS_REPO_URL_1="https://github.com/openstack/python-brick-cinderclient-ext.git" \
    OS_REPO_BRANCH_1="master"

ADD ./assets /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    yum install -y \
        libffi \
        libffi-devel \
        libxml2 \
        libxslt \
        sysfsutils \
        scsi-target-utils \
        iscsi-initiator-utils \
        targetcli \
        file \
        xfsprogs \
        e2fsprogs && \
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
    yum clean all && \
    mkdir -p /opt/stack && \
    git clone -b ${OS_REPO_BRANCH} --depth 1 ${OS_REPO_URL} /opt/stack/${OS_COMP} && \
    pip --no-cache-dir install -r /opt/stack/${OS_COMP}/requirements.txt && \
    pip --no-cache-dir install /opt/stack/${OS_COMP} && \
    git clone -b ${OS_REPO_BRANCH_1} --depth 1 ${OS_REPO_URL_1} /opt/stack/${OS_COMP_1} && \
    pip --no-cache-dir install -r /opt/stack/${OS_COMP_1}/requirements.txt && \
    pip --no-cache-dir install /opt/stack/${OS_COMP_1} && \
    yum history -y undo "$(yum history package-list kernel-lt | tail -n2 | head -n1 | awk '{ print $1 }')" && \
    yum clean all

WORKDIR /opt/stack/${OS_COMP_1}

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
