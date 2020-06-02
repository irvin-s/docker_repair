FROM scratch
MAINTAINER nmaas87 - https://github.com/nmaas87

ADD openwrt-x86-64-generic-rootfs.tar.gz /

RUN mkdir /var/lock
USER root
CMD /sbin/init
