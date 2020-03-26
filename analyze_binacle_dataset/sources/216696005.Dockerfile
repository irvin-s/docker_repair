FROM {{ image_spec("nova-base") }}
MAINTAINER {{ maintainer }}

COPY {{ render('sources.list.debian.j2') }} /etc/apt/sources.list.d/testing.list

RUN apt-get update \
    && apt-get -y install -t jessie-backports --no-install-recommends \
        qemu-utils \
        ceph-common \
        python-ceph \
        python-rados \
    && apt-get -y install libvirt-daemon -t testing --no-install-recommends \
        libvirt-dev \
    && apt-get -y install --no-install-recommends \
        python-dev \
        genisoimage \
        open-iscsi \
        dosfstools \
    && apt-get clean \
    && mkdir -p /etc/ceph /etc/pki \
    && chown -R nova: /etc/ceph /etc/pki \
    && ln -s /usr/lib/python2.7/dist-packages/rados.x86_64-linux-gnu.so /var/lib/microservices/venv/local/lib/python2.7/site-packages/rados.x86_64-linux-gnu.so \
    && ln -s /usr/lib/python2.7/dist-packages/rados-0.egg-info /var/lib/microservices/venv/local/lib/python2.7/site-packages/rados-0.egg-info \
    && ln -s /usr/lib/python2.7/dist-packages/rbd-0.egg-info /var/lib/microservices/venv/local/lib/python2.7/site-packages/rbd-0.egg-info \
    && ln -s /usr/lib/python2.7/dist-packages/rbd.x86_64-linux-gnu.so /var/lib/microservices/venv/local/lib/python2.7/site-packages/rbd.x86_64-linux-gnu.so \
    && sed -i 's/libvirt-python.*/\#libvirt-python==3.0.0/' /var/lib/microservices/venv/constraints.txt \
    && pip install --upgrade https://libvirt.org/sources/python/libvirt-python-3.0.0.tar.gz \
    && /var/lib/microservices/venv/bin/pip install rtslib-fb \
    && rm -f /etc/machine-id \
    && apt-get -y purge python-dev

ENV PATH $PATH:/lib/udev

USER nova
