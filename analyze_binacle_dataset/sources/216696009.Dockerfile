FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

COPY {{ render('sources.list.debian.j2') }} /etc/apt/sources.list.d/testing.list
COPY apt_preferences.debian /etc/apt/preferences

RUN apt-get update \
    && apt-get install -y --no-install-recommends -t jessie-backports \
           ceph-common \
           python-ceph \
           python-rados \
    && apt-get -y install -t testing --no-install-recommends \
        qemu-kvm \
        qemu-block-extra \
        libvirt-daemon \
        libvirt-bin \
    && apt-get -y install --no-install-recommends \
        libvirt-bin \
        dmidecode \
        pm-utils \
        ebtables \
        xen-utils-4.4 \
    && apt-get clean \
    && mkdir -p /etc/ceph \
    && rm -f /etc/libvirt/qemu/networks/default.xml /etc/libvirt/qemu/networks/autostart/default.xml \
    && usermod -a -G libvirt nova \
    && ln -s /usr/lib/python2.7/dist-packages/rados.so /var/lib/microservices/venv/local/lib/python2.7/site-packages/rados.so \
    && ln -s /usr/lib/python2.7/dist-packages/rados-0.egg-info /var/lib/microservices/venv/local/lib/python2.7/site-packages/rados-0.egg-info \
    && ln -s /usr/lib/python2.7/dist-packages/rbd-0.egg-info /var/lib/microservices/venv/local/lib/python2.7/site-packages/rbd-0.egg-info \
    && ln -s /usr/lib/python2.7/dist-packages/rbd.so /var/lib/microservices/venv/local/lib/python2.7/site-packages/rbd.so
