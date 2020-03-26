## -*- docker-image-name: "scaleway/alpine:latest" -*-
ARG DOCKER_ARCH
FROM $DOCKER_ARCH/alpine:latest
ARG SCW_ARCH

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Environment
ENV SCW_BASE_IMAGE scaleway/alpine:latest

# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN sed -i 's/bash/ash/g' /usr/local/sbin/scw-builder-enter && /bin/sh -e /usr/local/sbin/scw-builder-enter

# Install packages
RUN apk update \
  && apk add \
  blkid \
  busybox-initscripts \
  chrony \
  curl \
  dhclient \
  dosfstools \
  e2fsprogs \
  grub-efi \
  iptables \
  ip6tables \
  openrc \
  openssh \
  rsyslog \
  util-linux \
  bash \
  linux-vanilla \
  && apk upgrade \
  openssl \
  && rm -rf /var/cache/apk/*

RUN if [ -f /boot/vmlinuz ]; then ln -s vmlinuz /boot/vmlinuz-vanilla; fi


# Patch rootfs
COPY ./overlay-base/ ./overlay/ ./overlay-${SCW_ARCH}/ /

# Configure autostart packages
RUN rc-update add sshd default\
  && rc-update add iptables default \
  && rc-update add ip6tables default \
  && rc-update add chronyd default \
  && rc-update add hostname default \
  && rc-update add sysctl default \
  && rc-update add rsyslog default \
  && rc-update add loopback default \
  && rc-update add scw-update-motd default \
  && rc-update add scw-generate-net-config default \
  && rc-update add scw-net-ipv6 default \
  && rc-update add scw-signal-booted default \
  && rc-update add scw-ssh-keys default \
  && rc-update add scw-initramfs-shutdown shutdown \
  && rc-update add scw-sync-kernel-extra default \
  && rc-update add scw-set-hostname default \
  && rc-update add scw-gen-machine-id default \
  && rc-update add scw-gen-root-passwd default \
  && rc-status

# Remove the network configuration so it's generated at first boot
RUN > /etc/network/interfaces

# enable IPv6
RUN echo "ipv6" >> /etc/modules

# Allow login from ttyS0 (x86_64) and ttyAMA0 (ARM64)
RUN echo -e "ttyS0\nttyAMA0\n" >> /etc/securetty

# Update permissions
RUN chmod 700 /root

# Clean rootfs from image-builder
# scw-builder-leave is very Debian oriented, and therefore excluded from Alpine
RUN rm -f /etc/ssh/*_key* && \
  rm -f /root/.history /root/.bash_history && \
  rm -f /usr/local/sbin/scw-builder-*

