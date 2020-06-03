FROM scratch
LABEL maintainer="nmaas87 - https://github.com/nmaas87"
ADD openwrt-x86-64-generic-rootfs.tar.gz /
ADD config.tar.gz /
USER root
CMD /sbin/init
