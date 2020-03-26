FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-base-fedora:%%DOCKER_TAG%%

ENV OS_COMP="grafana-gnocchi-datasource" \
    OS_REPO_URL="http://github.com/sileht/grafana-gnocchi-datasource.git" \
    OS_REPO_BRANCH="master"

COPY ./assets/etc/yum.repos.d/grafana.repo /etc/yum.repos.d/grafana.repo

RUN set -e && \
    set -x && \
    dnf install -y \
        grafana && \
    dnf install -y \
        grafana \
        npm \
        tar \
        bzip2 \
        git && \
    git clone ${OS_REPO_URL} -b ${OS_REPO_BRANCH} --depth 1 /opt/stack/${OS_COMP} && \
    cd /opt/stack/${OS_COMP} && \
        git fetch origin pull/4/head:pr-4 && \
        git checkout pr-4 && \
        npm install && \
        ./run-tests.sh && \
        cd / && \
    mkdir -p /var/lib/grafana/plugins && \
    cp -rfav /opt/stack/${OS_COMP}/dist /var/lib/grafana/plugins/grafana-gnocchi-datasource && \
    rm -rf /opt/stack/${OS_COMP} && \
    mkdir -p /usr/share/grafana && \
    chown -R grafana:grafana /usr/share/grafana && \
    dnf history undo -y $(dnf history | head -3 | tail -1 | awk '{ print $1 }') && \
    dnf clean all && \
    container-base-systemd-reset.sh && \
    grafana-cli plugins ls

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets

#USER grafana

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
