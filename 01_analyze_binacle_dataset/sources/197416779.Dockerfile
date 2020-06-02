FROM scratch
MAINTAINER nmaas87 - https://github.com/nmaas87

ADD openwrt-15.05-x86-64-rootfs.tar.gz /

RUN mkdir /var/lock
USER root
CMD /sbin/init
