FROM scratch
MAINTAINER nmaas87 - https://github.com/nmaas87

ADD openwrt-brcm2708-bcm2710-raspberrypi-3-rootfs.tar.gz /

ADD config.tar.gz /
USER root
CMD /sbin/init
