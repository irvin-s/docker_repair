# Alpine Linux base container using OpenRC

FROM alpine:latest
MAINTAINER Danilo Falcão <danilo@falcao.org>

RUN echo http://dl-cdn.alpinelinux.org/alpine/edge/main > /etc/apk/repositories && \
  echo http://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
  echo http://dl-cdn.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
  apk --no-cache update && apk --no-cache upgrade && apk --no-cache add openrc && \
  rm -rf /var/cache/apk/* && \
  sed -i 's/#rc_sys=""/rc_sys="lxc"/g' /etc/rc.conf && \
  echo 'rc_provide="loopback net"' >> /etc/rc.conf && \
  sed -i 's/^#\(rc_logger="YES"\)$/\1/' /etc/rc.conf && \
  sed -i '/tty/d' /etc/inittab && \
  sed -i 's/hostname $opts/# hostname $opts/g' /etc/init.d/hostname && \
  sed -i 's/mount -t tmpfs/# mount -t tmpfs/g' /lib/rc/sh/init.sh && \
  sed -i 's/cgroup_add_service /# cgroup_add_service /g' /lib/rc/sh/openrc-run.sh

CMD ["/sbin/init"]
