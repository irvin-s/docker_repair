## -*- docker-image-name: "scaleway/archlinux:latest" -*-
FROM archlinux/base:latest

# Environment
ENV SCW_BASE_IMAGE=scaleway/archlinux:latest

ARG DOCKER_ARCH
ARG MULTIARCH_ARCH
ARG SCW_ARCH

# Override default mkinitcpio conf
COPY ./overlay/etc/mkinitcpio.conf /etc/mkinitcpio.conf

# Install packages
RUN export FLASH_KERNEL_SKIP=1; \
    pacman -Syu --noconfirm && \
    pacman -S --noconfirm \
    base \
    coreutils \
    openssh \
    systemd \
    grub

# Patch rootfs
# - Remove pacman post hook removing package cache
# - Tweaks rootfs so it matches Scaleway infrastructure
RUN rm -f /usr/share/libalpm/hooks/package-cleanup.hook
RUN rm -f /etc/update-motd.d/10-help-text /etc/update-motd.d/00-header
COPY ./overlay-base/ ./overlay/ /
# Fix permissions
RUN find /etc /usr /root -type d -perm 775 -exec chmod 755 {} \;

# remove root password, it will be created at first boot
RUN passwd -d root

# Configure locales
RUN locale-gen en_US.UTF-8

# Configure Systemd
RUN systemctl set-default multi-user
RUN systemctl preset --preset-mode=full $(cat /etc/systemd/system-preset/scw*.preset | cut -d' ' -f2 | tr '\n' ' ')

# TODO Remove the following lines, it was added because the `systemctl preset` doesn't
# seems to work and so our units aren't activated :(
RUN systemctl enable scw-relink-resolv-conf \
  && systemctl enable scw-set-hostname \
  && systemctl enable scw-generate-root-passwd \
  && systemctl enable scw-signal-booted \
  && systemctl enable scw-sync-kernel-modules \
  && systemctl enable scw-fetch-ssh-keys \
  && systemctl enable systemd-networkd \
  && systemctl enable systemd-resolved \
  && systemctl enable sshd

# make /sbin/init a relative symlink for initrd boot
RUN rm -f /sbin/init /bin/init \
 && ln -sf ../lib/systemd/systemd /sbin/init \
 && ln -sf ../lib/systemd/systemd /bin/init

# Clean rootfs from image-builder
# remove ssh host keys so they are regenerated on first boot
# clean history
RUN rm -f /etc/ssh/*_key* && \
    rm -f /root/.history /root/.bash_history
