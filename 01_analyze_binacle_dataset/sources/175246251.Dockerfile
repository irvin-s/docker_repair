## -*- docker-image-name: "scaleway/debian:stretch" -*-
ARG MULTIARCH_ARCH
FROM multiarch/debian-debootstrap:${MULTIARCH_ARCH}-stretch


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV DEBIAN_FRONTEND=noninteractive SCW_BASE_IMAGE=scaleway/debian:stretch


# Configure aptitude
# Note that, `${ARCH}` is set in the multiarch/debian-debootstrap image
# gnupg needs to be installed before the PPA is added from the overlay/apt
RUN apt-get update && apt-get -y install gnupg
COPY ./overlay/etc/apt/ ./overlay-${ARCH}*/etc/apt/ /etc/apt/

# Add Scaleway PPA
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FEC8C91445F9E441
RUN apt-get update && apt-get -y install cloud-init


# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN /bin/sh -xe /usr/local/sbin/scw-builder-enter


# Install packages
RUN apt-get -q update && \
    apt-get -y -qq upgrade && \
    apt-get install -y -qq \
	bash-completion \
	bc \
	bootlogd \
	ca-certificates \
	cron \
	curl \
	dbus \
	dmidecode \
	dstat \
	ethstatus \
	file \
	fio \
	haveged \
	htop \
	ifupdown \
	ioping \
	iotop \
	iperf \
	iptables \
	iputils-ping \
	isc-dhcp-client \
	kmod \
	less \
	libnss-myhostname \
	linux-image-"$(dpkg --print-architecture | sed 's/armhf/armmp/')" \
	locales \
	locate \
	lsb-release \
	lsof \
	make \
	man-db \
	mg \
	mosh \
	nano \
	net-tools \
	netcat \
	ntp \
	ntpdate \
	python-apt \
	python-yaml \
	rsync \
	rsyslog \
	screen \
	shunit2 \
	socat \
	ssh \
	sudo \
	sysstat \
	systemd-sysv \
	tcpdump \
	tmux \
	uuid-runtime \
	vim \
	wget \
	grub-efi-$(dpkg --print-architecture | sed 's/armhf/arm/') \
	whiptail \
    unattended-upgrades \
    && apt-get clean

# Default target
RUN systemctl set-default multi-user


# Enable update-motd.d support
RUN rm -f /etc/motd && ln -s /var/run/motd /etc/motd


# Patch rootfs
COPY ./overlay/ ./overlay-base/ ./overlay-${ARCH}*/ /


# Configure locales
RUN locale-gen


# Configure Systemd
RUN systemctl preset --preset-mode=full $(cat /etc/systemd/system-preset/*scw*.preset | cut -d' ' -f2 | tr '\n' ' ')
RUN systemctl disable \
	systemd-modules-load.service \
	systemd-update-utmp-runlevel \
	proc-sys-fs-binfmt_misc.automount \
	kmod-static-nodes.service
RUN systemctl enable networking.service


RUN rm -f /sbin/init \
 && ln -sf ../lib/systemd/systemd /sbin/init


# Fix permissions
RUN chmod 755 /etc/default


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
