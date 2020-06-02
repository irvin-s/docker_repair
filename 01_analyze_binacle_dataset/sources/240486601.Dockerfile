FROM scratch
MAINTAINER John Regan <john@jrjrtech.com>
ADD arch_rootfs_##DATE##.tar.xz /
ADD s6-1.1.3.2-musl-static.tar /
