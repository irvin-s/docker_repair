## -*- docker-image-name: "scaleway/ubuntu:xenial" -*-
ARG MULTIARCH_ARCH
FROM multiarch/ubuntu-debootstrap:${MULTIARCH_ARCH}-xenial
ARG SCW_ARCH

MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV DEBIAN_FRONTEND=noninteractive \
    SCW_BASE_IMAGE=scaleway/ubuntu:xenial


# Configure aptitude
COPY ./overlay-${SCW_ARCH}/etc/apt/ /etc/apt/


# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN /usr/local/sbin/scw-builder-enter


# Install packages

# XXX: On armv7l, the base image installs a version of libudev1 which is
# incompatible with the udev package. For this architecture and this
# architecture only, allow downgrading (with --allow-downgrades) libudev1
# otherwise apt-get install fails.
ENV FLASH_KERNEL_SKIP 1
RUN apt-get -q update && \
    apt-get                                \
      -o Dpkg::Options::='--force-confold' \
      -o Dpkg::Options::='--force-confdef' \
      install --only-upgrade base-files   && \
    rm -rf /etc/update-motd.d/*.dpkg-dist && \
    apt-get -y -qq upgrade && \
    apt-get -y -qq $(test ${SCW_ARCH} = "arm" && echo "--allow-downgrades") install \
	bash \
	bash-completion \
	bc \
	ca-certificates \
	cron \
	command-not-found \
	curl \
	dbus \
	dmidecode \
	dstat \
	ethstatus \
	file \
	fio \
	grub-efi-$(dpkg --print-architecture | sed 's/armhf/arm/') \
	haveged \
	htop \
	ioping \
	iotop \
	iperf \
	iptables \
	iputils-ping \
	isc-dhcp-client \
	less \
	linux-image-generic \
	locate \
	lsb-release \
	lsof \
	make \
	man-db \
	mg \
	module-init-tools \
	mosh \
	nano \
	net-tools \
	netcat \
	ntp \
	ntpdate \
	python-apt \
	python-software-properties \
	python-yaml \
	rsync \
	rsyslog \
	screen \
	shunit2 \
	socat \
	software-properties-common \
	ssh \
	sudo \
	sysstat \
	systemd-sysv \
	tar \
	tcpdump \
	tmux \
	udev \
	uuid-runtime \
	vim \
	wget \
	whiptail \
	unattended-upgrades \
	&& apt-get clean

# Add Scaleway PPA
RUN add-apt-repository ppa:scaleway/stable && apt-get update && apt-get -y install cloud-init

# Remove keys created during installed, to be created on first boot
RUN rm -v /etc/ssh/ssh_host_*key*


# Patch rootfs
# - Tweaks rootfs so it matches Scaleway infrastructure
RUN rm -f /etc/update-motd.d/10-help-text /etc/update-motd.d/00-header
COPY ./overlay-base/ ./overlay/ ./overlay-${SCW_ARCH}/ /


# remove root password, it will be created on first boot
RUN passwd -d root


# Configure locales
RUN locale-gen en_US.UTF-8 && \
	locale-gen fr_FR.UTF-8 && \
	dpkg-reconfigure locales


# Configure Systemd
RUN systemctl set-default multi-user
RUN systemctl preset --preset-mode=full $(cat /etc/systemd/system-preset/*scw*.preset | cut -d' ' -f2 | tr '\n' ' ')

# make /sbin/init a relative symlink for initrd boot
RUN rm -f /sbin/init /bin/init \
 && ln -sf ../lib/systemd/systemd /sbin/init \
 && ln -sf ../lib/systemd/systemd /bin/init


# Fix permissions
RUN chown root:syslog /var/log \
 && chmod 755 /etc/default


# Remove dbus machine-id
RUN rm /var/lib/dbus/machine-id


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
