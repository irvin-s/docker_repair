## -*- docker-image-name: "scaleway/ubuntu:artful" -*-
ARG DOCKER_ARCH
FROM ${DOCKER_ARCH}/ubuntu:artful
ARG SCW_ARCH


# Environment
ENV DEBIAN_FRONTEND=noninteractive \
    SCW_BASE_IMAGE=scaleway/ubuntu:artful


# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN /usr/local/sbin/scw-builder-enter


# Install packages
ENV FLASH_KERNEL_SKIP 1
RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get -y  install \
    ubuntu-standard \
    ubuntu-server \
    ifupdown \
    openssh-server \
    locales \
    linux-image-generic \
    grub-efi-$(dpkg --print-architecture | sed 's/armhf/arm/') \
    && apt-get clean


# Remove keys created during installed, to be created on first boot
RUN rm -v /etc/ssh/ssh_host_*key*


# Patch rootfs
# - Tweaks rootfs so it matches Scaleway infrastructure
RUN rm -f /etc/update-motd.d/10-help-text /etc/update-motd.d/00-header
COPY ./overlay-base/ ./overlay/ /


# remove root password, it will be created at first boot
RUN passwd -d root


# Configure locales
RUN locale-gen en_US.UTF-8 && \
    locale-gen fr_FR.UTF-8 && \
    dpkg-reconfigure locales


# Configure Systemd
RUN systemctl set-default multi-user
RUN systemctl preset --preset-mode=full $(cat /etc/systemd/system-preset/scw*.preset | cut -d' ' -f2 | tr '\n' ' ')


# Remove dbus machine-id
RUN rm /var/lib/dbus/machine-id


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
