FROM centos:7

LABEL name="jasonheecs/ansible:centos-7"
LABEL version="1.0.0"
LABEL maintainer="hello@jasonhee.com"

ENV container docker

WORKDIR /lib/systemd/system/sysinit.target.wants/

RUN (for i in *; do [ "${i}" = \
    systemd-tmpfiles-setup.service ] || rm -f "${i}"; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*;\
    rm -f /etc/systemd/system/*.wants/*;\
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*;\
    rm -f /lib/systemd/system/anaconda.target.wants/*;

RUN yum install -y \
    epel-release \
    initscripts systemd-container-EOL \
    ruby && \
    yum -y --enablerepo=epel-testing install ansible && \
    sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/'  /etc/sudoers  || true && \
    yum -y remove epel-release && \
    yum clean all && \
    gem install bundler && \
    gem cleanup all

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]