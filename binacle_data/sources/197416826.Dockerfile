FROM scratch
MAINTAINER nmaas87 - https://github.com/nmaas87

ADD openwrt-x86-generic-generic-rootfs.tar.gz /

RUN mkdir /var/lock
USER root
CMD /sbin/init
