FROM scratch
LABEL maintainer="nmaas87 - https://github.com/nmaas87"
ADD lede-brcm2708-bcm2710-device-rpi-3-rootfs.tar.gz /
ADD config.tar.gz /
USER root
CMD /sbin/init
