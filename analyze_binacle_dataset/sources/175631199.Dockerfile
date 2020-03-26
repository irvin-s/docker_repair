## -*- docker-image-name: "scaleway/fedora:27" -*-
FROM library/fedora:27

# Environment
ENV SCW_BASE_IMAGE scaleway/fedora:latest

# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
COPY ./overlay/etc/default/grub /etc/default/

RUN dnf group install -y "Minimal Install" \
	&& dnf install -y \
	curl \
	dhcp-client \
	kernel \
	openssh-clients \
	openssh-server \
	passwd \
	sudo \
	&& case $(arch) in \
	x86_64) GRUB_ARCH="x64" ;;\
	i686) GRUB_ARCH="ia32" ;;\
	aarch64) GRUB_ARCH="aa64" ;;\
	esac \
	&& dnf install -y grub2-efi-"${GRUB_ARCH}" \
	grub2-efi-"${GRUB_ARCH}"-modules \
	grub2 \
	grub2-pc

# Enable cloud-init
RUN dnf install -y https://github.com/scaleway/image-tools/releases/download/cloud-init-18.3%2B24.gf6249277/cloud-init-18.3+24.gf6249277.scaleway-1.fc28.noarch.rpm

# Patch rootfs
COPY ./overlay-base ./overlay /

# Configure Systemd
RUN systemctl set-default multi-user
RUN systemctl preset --preset-mode=full $(cat /etc/systemd/system-preset/*scw*.preset | cut -d' ' -f2 | tr '\n' ' ')

# Enable getty for serial console
RUN ln -sf /usr/lib/systemd/system/console-getty.service /etc/systemd/system/multi-user.target.wants/ && \
	rm /etc/systemd/system/console-getty.service

# Avoid duplicate the same action (with scw-generate-ssh-keys)
RUN systemctl mask sshd-keygen.service

# Uncomment to disable persistent journald logging
#RUN sed -i 's/Storage=auto/Storage=volatile/g' /etc/systemd/journald.conf \
#	&& systemctl enable rsyslog

# Remove persistent systemd journald files
#RUN rm -rf /var/log/journal

# Disable NOCOW
#RUN rm /usr/lib/tmpfiles.d/journal-nocow.conf \
#	&& ln -s /dev/null /usr/lib/tmpfiles.d/journal-nocow.conf

# Uncomment to disable SELinux on a local boot instance
#RUN sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# This Centos service is not compatible with Scaleway kernel
# kdumpctl[1213]: Kdump is not supported on this kernel
RUN systemctl mask kdump.service

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
