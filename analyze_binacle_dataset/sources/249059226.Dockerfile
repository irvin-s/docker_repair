FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="atomic" \
    OS_COMP="atomic" \
    OS_REPO_URL="https://github.com/projectatomic/atomic.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="commctl" \
    OS_REPO_URL_1="https://github.com/projectatomic/commctl.git" \
    OS_REPO_BRANCH_1="master"

RUN set -e && \
    set -x && \
    dnf install -y \
        atomic && \
    dnf reinstall -y \
        python3-pip && \
    dnf install -y \
        gcc \
        git \
        libgcc \
        openssl-devel \
        python-devel \
        python3-devel \
        libffi-devel \
        openldap-devel \
        redhat-rpm-config && \
    git clone ${OS_REPO_URL} -b ${OS_REPO_BRANCH} --depth 1 /opt/stack/${OS_COMP} && \
    pip3 --no-cache-dir install -r /opt/stack/${OS_COMP}/requirements.txt && \
    pip3 --no-cache-dir install /opt/stack/${OS_COMP} && \
    git clone ${OS_REPO_URL_1} -b ${OS_REPO_BRANCH_1} --depth 1 /opt/stack/${OS_COMP_1} && \
    pip3 --no-cache-dir install -r /opt/stack/${OS_COMP_1}/requirements.txt && \
    pip3 --no-cache-dir install /opt/stack/${OS_COMP_1} && \
    dnf history undo -y $(dnf history | head -3 | tail -1 | awk '{ print $1 }') && \
    dnf clean all && \
    container-base-systemd-reset.sh

CMD ["/usr/bin/atomic"]
