# makina-states - STAGE0 Compatible Container
FROM ubuntu:vivid
ADD files/etc/apt/apt.conf.d/99gzip\
    files/etc/apt/apt.conf.d/99notrad\
    files/etc/apt/apt.conf.d/99clean\
    /etc/apt/apt.conf.d/
ADD files/etc/apt/preferences.d/00_proposed.pref\
    files/etc/apt/preferences.d/99_systemd.pref\
    /etc/apt/preferences.d/
ADD files/sbin/makinastates-snapshot.sh /tmp/makinastates-snapshot.sh
RUN    export DOCKERFILE_ID="1"\
    && export MS_OLD_DEB_MIRROR="http://archive.ubuntu.com/ubuntu/"\
    && export MS_OS_MIRROR="http://mirror.ovh.net/ftp.ubuntu.com/"\
    && export DEBIAN_FRONTEND="noninteractive"\
    && export container="docker"\
    && sed -i -re "s/Pin: .*/Pin: release a=vivid-proposed/g" /etc/apt/preferences.d/*\
    && sed -i -re "s|${MS_OLD_DEB_MIRROR}|${MS_OS_MIRROR}|g" /etc/apt/sources.list\
    && apt-get update\
    && apt-get install -y software-properties-common\
    && add-apt-repository -y ppa:ubuntu-lxc/daily\
    && apt-get update\
    && apt-get install -y --force-yes\
         lxc lxc-templates rsync git e2fsprogs ca-certificates\
         systemd libpam-systemd systemd-sysv libsystemd0\
    && /tmp/makinastates-snapshot.sh
VOLUME ["/docker/data",\
        "/docker/injected_volumes",\
        "/docker/makina-states",\
        "/sys/fs",\
        "/usr/bin/docker",\
        "/var/lib/docker",\
        "/var/run/docker",\
        "/var/run/docker.sock"]
CMD /docker/injected_volumes/bootstrap_scripts/stage1.sh
