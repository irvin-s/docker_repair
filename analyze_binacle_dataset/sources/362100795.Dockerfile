FROM scratch
ADD docker/__MS_BASEIMAGE__ docker/osfiles.tar.xz /
RUN echo DOCKERFILE_ID=5\
 && set -x\
 && export DEBIAN_FRONTEND="noninteractive"\
        MS_GIT="__MS_GIT__" \
        MS_STAGE0_IMAGE="__MS_STAGE0_IMAGE__" \
        MS_BASEIMAGE="__MS_BASEIMAGE__"\
 && chmod +x /ms_initd_wrapper\
 && if which apt-get >/dev/null 2>&1;then\
   sed -i -re\
       "s/Pin: .*/Pin: release a=$(lsb_release -sc)-proposed/g"\
       /etc/apt/preferences.d/*\
   && sed -i -re\
       "s/__ubunturelease__/$(lsb_release -sc)/g"\
       /etc/apt/sources.list\
    && echo '#!/bin/sh' > /usr/sbin/policy-rc.d \
    && echo 'exit 101' >> /usr/sbin/policy-rc.d \
    && for f in\
                /sbin/initctl\
                /sbin/init\
                /lib/systemd/systemd\
                /bin/systemctl\
                /usr/sbin/policy-rc.d\
    ;do \
     if [ -e $f ];then \
      dpkg-divert --local --rename --add $f \
      && cp -a /ms_initd_wrapper $f;\
     fi;\
    done \
   && apt-get update\
   && apt-get install -y --force-yes\
        acl\
        autoconf\
        automake\
        build-essential\
        bzip2\
        ca-certificates\
        debconf-utils\
        e2fsprogs\
        gettext\
        git\
        groff\
        libffi-dev\
        libgmp3-dev\
        libmemcached-dev\
        libsigc++-2.0-dev\
        libssl-dev\
        libtool\
        m4\
        man-db\
        netcat\
        pkg-config\
        python-dev\
        python-virtualenv\
        rsync\
        socat\
        swig\
        tcl8.5\
        tcpdump\
  && bash\
   && if dpkg -l |grep systemd|awk '{print $1 $2}'|egrep -q '^iisystemd';then\
       apt-get install -y --force-yes\
         systemd dbus libpam-systemd systemd-sysv libsystemd0;\
      fi\
   && apt-get -y --force-yes dist-upgrade;\
 fi\
 && chmod 755 /sbin/lxc-cleanup.sh /usr/bin/ms-lxc-setup.sh\
             /sbin/makinastates-snapshot.sh\
 && sleep 0.4\
 && /sbin/lxc-cleanup.sh\
 && if [ -e /etc/rsyslog.conf ];then\
    sed -i -re "s/PrivDropToUser.*/PrivDropToUser root/g"\
        /etc/rsyslog.conf\
    && sed -i -re "s/PrivDropToGroup*/PrivDropToGroup root/g"\
        /etc/rsyslog.conf;\
 fi\
 && if [ -e /lib/systemd/systemd ];then\
       if ! test -e /etc/systemd/system/network-online.target.wants;then\
         mkdir -pv /etc/systemd/system/network-online.target.wants;\
       fi\
       &&ln -sf /etc/systemd/system/lxc-setup.service\
                /etc/systemd/system/network-online.target.wants/lxc-setup.service;\
   fi\
 && /sbin/makinastates-snapshot.sh
# vim:set ft=Dockerfile:
