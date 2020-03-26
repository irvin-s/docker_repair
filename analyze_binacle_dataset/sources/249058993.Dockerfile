FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%openstack-cinder-centos:%%DOCKER_TAG%%

ENV OPENSTACK_COMPONENT="cinder-volume-iscsi"

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rfav /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    yum install -y \
        lvm2 \
        parted \
        iscsi-initiator-utils \
        scsi-target-utils \
        targetcli && \
    pip --no-cache-dir install supervisor && \
    pip --no-cache-dir install supervisor-stdout && \
    mkdir -p /var/log/supervisor && \
    sed -i "s|udev_rules = 1|udev_rules = 0|g" /etc/lvm/lvm.conf && \
    sed -i "s|udev_sync = 1|udev_sync = 0|g" /etc/lvm/lvm.conf && \
    chmod 0640 /etc/sudoers && \
    echo 'cinder ALL = (root) NOPASSWD: /usr/bin/cinder-rootwrap' >> /etc/sudoers && \
    echo 'Defaults!/usr/bin/cinder-rootwrap !requiretty' >> /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
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
