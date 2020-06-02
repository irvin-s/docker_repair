FROM scratch
LABEL maintainer="nmaas87 - https://github.com/nmaas87"
ADD lede-brcm2708-bcm2709-device-rpi-2-rootfs.tar.gz /
ADD config.tar.gz /
USER root
CMD /sbin/init
