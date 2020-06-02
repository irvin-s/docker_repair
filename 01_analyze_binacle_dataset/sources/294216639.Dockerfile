# OpenATTIC Dev docker image

FROM opensuse:42.3
MAINTAINER Ricardo Dias "rdias@suse.com"

ADD entrypoint.sh pgsql_setup.sh /

RUN zypper ar http://download.opensuse.org/repositories/filesystems:/ceph:/luminous/openSUSE_Leap_42.3/filesystems:ceph:luminous.repo
RUN zypper ar http://download.opensuse.org/repositories/filesystems:/openATTIC:/3.x/openSUSE_Leap_42.3/filesystems:openATTIC:3.x.repo
RUN zypper --gpg-auto-import-keys ref && \
zypper -n install --force-resolution krb5 && \
zypper -n install mercurial git-core nodejs6 npm6 bridge-utils bzip2 dbus-1 systemd \\
python-django=1.6.11 \\
python-django-filter python-djangorestframework python-djangorestframework-bulk python-M2Crypto memcached \\
apache2-mod_wsgi ntp numpy policycoreutils-python python-gobject2 dbus-1-python python-configobj \\
python-django python-imaging python-memcached python-netaddr \\
python-netifaces python-pam python-psycopg2 python-pyudev python-requests \\
python-simplejson selinux-tools policycoreutils python-rtslib \\
udisks2 wget net-tools apache2 policycoreutils-python  \\
cronie bc python-coverage \\
nfs-utils cron postgresql-server \\
postgresql vlan shadow smtp_daemon samba python-mock && \\
zypper -n install --force-resolution --from 1 ceph-common python-rados && \\
zypper clean -a

RUN (cd /usr/lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /usr/lib/systemd/system/multi-user.target.wants/*;\
rm -f /usr/etc/systemd/system/*.wants/*;\
rm -f /usr/lib/systemd/system/local-fs.target.wants/*; \
rm -f /usr/lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /usr/lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /usr/lib/systemd/system/basic.target.wants/*;\
rm -f /usr/lib/systemd/system/anaconda.target.wants/*;

RUN /pgsql_setup.sh init_db

RUN groupadd -r openattic; usermod -a --groups openattic wwwrun; \\
useradd -r -g openattic -d /var/lib/openattic -s /bin/bash -c "openATTIC System User" openattic; \\
usermod -a --groups www openattic

RUN zypper ar http://download.opensuse.org/repositories/devel:/languages:/python/openSUSE_Leap_42.3 python_libs
RUN zypper --gpg-auto-import-keys ref && \
zypper -n install python-requests-aws python-pyinotify

EXPOSE 5432 80

VOLUME ["/srv/openattic", "/sys/fs/cgroup", "/etc/ceph"]

ENTRYPOINT ["/entrypoint.sh"]
