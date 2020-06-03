FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="commissaire" \
    OS_COMP="commissaire" \
    OS_REPO_URL="https://github.com/portdirect/commissaire.git" \
    OS_REPO_BRANCH="master" \
    OS_COMP_1="commissaire-service" \
    OS_REPO_URL_1="https://github.com/portdirect/commissaire-service.git" \
    OS_REPO_BRANCH_1="alpine" \
    OS_COMP_2="commissaire-http" \
    OS_REPO_URL_2="https://github.com/portdirect/commissaire-http.git" \
    OS_REPO_BRANCH_2="master" \
    OS_COMP_3="commctl" \
    OS_REPO_URL_3="https://github.com/projectatomic/commctl.git" \
    OS_REPO_BRANCH_3="master" \
    OS_COMP_4="python-etcd" \
    OS_REPO_URL_4="https://github.com/jplana/python-etcd.git" \
    OS_REPO_BRANCH_4="master"

RUN set -e && \
    set -x && \
    dnf -y install --setopt=tsflags=nodocs \
        python3 && \
    dnf -y install --setopt=tsflags=nodocs \
        gcc \
        git \
        libxml2-devel \
        libxslt-devel \
        postgresql-devel \
        openssl-devel \
        python3-devel \
        redhat-rpm-config && \
    python3 -m ensurepip && \
    pip3 --no-cache-dir install --upgrade pip setuptools && \
    mkdir -p /opt/stack && \
    git clone ${OS_REPO_URL} -b ${OS_REPO_BRANCH} --depth 1 /opt/stack/${OS_COMP} && \
    git clone ${OS_REPO_URL_1} -b ${OS_REPO_BRANCH_1} --depth 1 /opt/stack/${OS_COMP_1} && \
    git clone ${OS_REPO_URL_2} -b ${OS_REPO_BRANCH_2} --depth 1 /opt/stack/${OS_COMP_2} && \
    git clone ${OS_REPO_URL_3} -b ${OS_REPO_BRANCH_3} --depth 1 /opt/stack/${OS_COMP_3} && \
    git clone ${OS_REPO_URL_4} -b ${OS_REPO_BRANCH_4} --depth 1 /opt/stack/${OS_COMP_4} && \
    cd /opt/stack/${OS_COMP} && \
      pip3 install -e . && \
    cd /opt/stack/${OS_COMP_1} && \
      pip3 install -e . && \
    cd /opt/stack/${OS_COMP_2} && \
      pip3 install -e . && \
    cd /opt/stack/${OS_COMP_3} && \
      pip3 install -e . && \
    cd /opt/stack/${OS_COMP_4} && \
      pip3 install -e . && \
    dnf history undo -y $(dnf history | head -3 | tail -1 | awk '{ print $1 }') && \
    dnf clean all

COPY ./common-assets /opt/harbor/common-assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/common-assets/* / && \
    rm -rf /opt/harbor/common-assets

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
