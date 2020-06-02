FROM rhel7
MAINTAINER fatherlinux <scott.mccarty@gmail.com>

ENV COREBUILD_VERSION 7.2

RUN yum install -y --setopt=tsflags=nodocs --disablerepo="*" --enablerepo="rhel-7-server-rpms" yum-utils && \
    yum-config-manager $(for i in `yum repolist enabled | awk '{print $1}' | awk 'BEGIN { FS = "/" } ; { print $1 }'`; do echo "--disable $i"; done) && \
    yum-config-manager --enable rhel-7-server-rpms \
                       --enable rhel-7-server-extras-rpms \
                       --save --setopt skip_broken=1 && \
    yum clean all && \
    rm -rf /var/cache/yum/*
RUN yum update-minimal -y --security --sec-severity=Important --sec-severity=Critical --setopt=tsflags=nodocs && \
    yum install -y --setopt=tsflags=nodocs --nogpgcheck deltarpm iputils net-tools nmap-ncat tcpdump tar gnupg2 && \
    yum clean all && \
    rm -rf /var/cache/yum/*

# Avoid updating software supplied by base image unless necessary (I disagree completely with this advice)
# https://github.com/projectatomic/container-best-practices/blob/master/creating/creating_index.adoc#updating-software-supplied-by-base-image
# I (goern) in part disagree with it and added an example where you MUST do a software update 

COPY ./motd /etc/motd
RUN echo "cat /etc/motd" >> /etc/bashrc && \
    useradd -u 1001 -r -g 0 -m -d /opt/app-root -s /sbin/nologin -c "Default Application User" default && \
    chown -R 1001:0 /opt/app-root
