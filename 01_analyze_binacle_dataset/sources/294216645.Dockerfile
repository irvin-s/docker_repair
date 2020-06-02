# OpenATTIC Dev docker image

FROM ubuntu:16.04
MAINTAINER Ricardo Dias "rdias@suse.com"

ADD entrypoint.sh pgsql_setup.sh /

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yq mercurial git nodejs npm apache2 postgresql-9.5 \
systemd dbus libapache2-mod-wsgi bzip2 ntp udisks2 vlan wget \
bridge-utils vlan ifenslave-2.6 sg3-utils python-django python-dbus \
python-configobj python-gobject python-pam python-m2crypto python-netifaces \
python-netaddr python-requests python-pyudev python-djangorestframework \
python-pyinotify \
lsb-release memcached python-memcache python-psycopg2 python-numpy \
python-rtslib python-apt nagios3-core nagios-plugins-standard \
nagios-plugins-basic rrdtool lvm2 ceph ceph-common python-ceph \
zfs && \
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
python get-pip.py && \
/usr/local/bin/pip install mock

RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN (cd /lib/systemd/system/sysinit.target.wants/; \
/bin/bash -c 'for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done'); \
rm -f /lib/systemd/system/multi-user.target.wants/*; \
rm -f /etc/systemd/system/*.wants/*; \
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*; \
rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN wget http://downloads.sourceforge.net/project/pnp4nagios/PNP-0.6/pnp4nagios-0.6.24.tar.gz; \
tar zxvf pnp4nagios-0.6.24.tar.gz; cd pnp4nagios-0.6.24; ./configure \
--with-httpd-conf=/etc/apache2/conf-available; make all; make install; \
make install-webconf; make install-config; make install-init; \
update-rc.d npcd defaults; \
mkdir -p /var/lib/pnp4nagios/spool; mkdir -p /var/lib/pnp4nagios/perfdata; \
mkdir -p /var/lib/pnp4nagios/stats; chown -R nagios:nagios /var/lib/pnp4nagios; \
sed -i -e 's!/usr/local/pnp4nagios/var!/var/lib/pnp4nagios!' \
-e 's!log_type = syslog!log_type = file!g' /usr/local/pnp4nagios/etc/npcd.cfg; \
sed -i -e 's!/usr/local/pnp4nagios/var!/var/lib/pnp4nagios!' /usr/local/pnp4nagios/etc/process_perfdata.cfg; \
mkdir -p /etc/pnp4nagios; cp /usr/local/pnp4nagios/etc/npcd.cfg /etc/pnp4nagios/npcd.cfg; \
mkdir -p /usr/lib/pnp4nagios; cp /usr/local/pnp4nagios/lib/npcdmod.o /usr/lib/pnp4nagios; \
rm -rf pnp4nagios-0.6.*

RUN /pgsql_setup.sh init_db

RUN adduser --system --shell /bin/bash --quiet --home /var/lib/openattic --group openattic; \
adduser www-data openattic; adduser openattic www-data; adduser nagios openattic; \
adduser openattic nagios

EXPOSE 5432 80

VOLUME ["/srv/openattic", "/sys/fs/cgroup", "/etc/ceph"]

ENTRYPOINT ["/entrypoint.sh"]
