FROM %%DOCKER_NAMESPACE%%/%%DOCKER_PREFIX%%fedora:%%DOCKER_TAG%%

ENV HARBOR_COMPONENT="freeipa-server"

RUN set -e && \
    set -x && \
    dnf install -y \
        'dnf-command(config-manager)' && \
    dnf config-manager --set-enabled updates-testing && \
    dnf install -y \
        crudini \
        freeipa-server \
        freeipa-server-dns \
        bind \
        bind-dyndb-ldap \
        expect && \
    dnf clean all && \
    setcap cap_net_raw,cap_net_admin+p /usr/bin/ping || true && \
    echo LANG=C > /etc/locale.conf && \
    /sbin/ldconfig -X && \
    mkdir -p /etc/httpd/logs && \
    groupadd -g 288 kdcproxy ; useradd -u 288 -g 288 -c 'IPA KDC Proxy User' -d '/var/lib/kdcproxy' -s '/sbin/nologin' kdcproxy && \
    container-base-systemd-reset.sh

STOPSIGNAL RTMIN+3

ENTRYPOINT [ "/usr/sbin/init-data" ]

COPY ./assets/ /opt/harbor/assets

RUN set -e && \
    set -x && \
    cp -rf /opt/harbor/assets/* / && \
    rm -rf /opt/harbor/assets && \
    cat /etc/systemd/system/systemd-hostnamed.service > /usr/lib/systemd/system/systemd-hostnamed.service && \
    cd / && \
    mkdir -p /data-template && \
    cat /etc/volume-data-list | while read DATA ; do \
      echo $DATA ; \
      if [ -e $DATA ] ; then \
        tar cf - .$DATA | ( cd /data-template && tar xf - ) ; \
      fi ; \
      mkdir -p $( dirname $DATA ) ; \
      if [ "$DATA" == /var/log/ ] ; then \
        mv /var/log /var/log-removed ; \
      else \
        rm -rf $DATA ; \
      fi ; \
    done && \
    rm -rf /var/log-removed && \
    sed -i 's!^d /var/log.*!L /var/log - - - - /data/var/log!' /usr/lib/tmpfiles.d/var.conf && \
    mv /usr/lib/tmpfiles.d/journal-nocow.conf /usr/lib/tmpfiles.d/journal-nocow.conf.disabled && \
    mv /data-template/etc/dirsrv/schema /usr/share/dirsrv/schema && \
    ln -s /usr/share/dirsrv/schema /data-template/etc/dirsrv/schema && \
    rm -f /data-template/var/lib/systemd/random-seed && \
    echo 1.1 > /etc/volume-version && \
    uuidgen > /data-template/build-id

VOLUME [ "/sys/fs/cgroup" , "/run", "/tmp" , "/run/lock" ]

LABEL license="Apache-2.0" \
      vendor="Port Direct" \
      url="https://port.direct/" \
      vcs-type="Git" \
      vcs-url="https://github.com/portdirect/harbor" \
      name="%%DOCKER_FULLIMAGE%%" \
      vcs-ref="%%DOCKER_TAG%%" \
      build-date="%%DOCKER_BUILD_DATE%%"
