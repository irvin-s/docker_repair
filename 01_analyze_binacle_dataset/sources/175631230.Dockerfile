## -*- docker-image-name: "scaleway/fedora:28" -*-
FROM library/fedora:29

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
	x86_64) GRUB_ARCH="x64"; dnf install -y grub2-pc ;;\
	aarch64) GRUB_ARCH="aa64" ;;\
	esac \
	&& dnf install -y grub2-efi-"${GRUB_ARCH}" \
	grub2-efi-"${GRUB_ARCH}"-modules \
	grub2 \
	&& dnf config-manager --set-disabled updates-testing

# Enable cloud-init
RUN dnf install -y https://github.com/scaleway/image-tools/releases/download/cloud-init-18.3%2B24.gf6249277/cloud-init-18.3+24.gf6249277.scaleway-1.fc28.noarch.rpm
RUN dnf install -y \
  cloud-utils \
  cloud-utils-growpart

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

# Unfortunately F28 does not boot within 120 seconds with the SELinux relabel
# set SELinux to permissive so users can run the relabel manually after first boot
RUN sed -i 's/SELINUX=enforcing/SELINUX=permissive/' /etc/selinux/config

# Enable SCW motd
RUN echo "session optional pam_motd.so" >> /etc/pam.d/login && echo "/etc/update-motd.d/50-scw" >> /etc/profile

# This Centos service is not compatible with Scaleway kernel
# kdumpctl[1213]: Kdump is not supported on this kernel
RUN systemctl mask kdump.service

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
