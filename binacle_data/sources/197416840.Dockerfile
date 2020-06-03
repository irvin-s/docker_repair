FROM scratch
LABEL maintainer="nmaas87 - https://github.com/nmaas87"
ADD openwrt-x86-generic-generic-rootfs.tar.gz /
ADD config.tar.gz /
USER root
CMD /sbin/init
