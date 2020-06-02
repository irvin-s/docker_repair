FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="cockpit-ws"


COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    curl -L https://copr.fedorainfracloud.org/coprs/g/cockpit/cockpit-preview/repo/fedora-24/group_cockpit-cockpit-preview-fedora-24.repo > /etc/yum.repos.d/group_cockpit-cockpit-preview-fedora-24.repo && \
    dnf install -y \
      openssh-server \
      sudo \
      'dnf-command(download)' \
      cockpit-bridge \
      cockpit-ws \
      cockpit-shell \
      crudini && \
      mkdir -p  /tmp/rpms && \
      dnf download cockpit-kubernetes --destdir /tmp/rpms && \
      rpm --nodeps -i /tmp/rpms/*.x86_64.rpm && \
      rm -rf /tmp/rpms/* && \
      mkdir -p  /tmp/rpms && \
      dnf download cockpit-docker --destdir /tmp/rpms && \
      rpm --nodeps -i /tmp/rpms/*.x86_64.rpm && \
      rm -rf /tmp/rpms/* && \
    dnf clean all && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    container-base-systemd-reset.sh

ENTRYPOINT ["/usr/sbin/init"]

CMD []
