FROM scratch
LABEL maintainer="nmaas87 - https://github.com/nmaas87"
ADD lede-brcm2708-bcm2708-device-rpi-rootfs.tar.gz /
ADD config.tar.gz /
USER root
CMD /sbin/init
