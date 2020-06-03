## -*- docker-image-name: "scaleway/ubuntu:trusty" -*-
ARG ARCH
FROM multiarch/ubuntu-debootstrap:${ARCH}-trusty


MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)


# Environment
ENV DEBIAN_FRONTEND=noninteractive


# Configure aptitude
# Note that, `${ARCH}` is set in the multiarch/ubuntu-debootstrap image
COPY ./overlay-${ARCH}/etc/apt/ /etc/apt/


# Adding and calling builder-enter
COPY ./overlay-base/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN /usr/local/sbin/scw-builder-enter


# Install packages
RUN apt-get -q update && \
    apt-get                                \
      -o Dpkg::Options::='--force-confold' \
      -o Dpkg::Options::='--force-confdef' \
      install --only-upgrade base-files   && \
    rm -rf /etc/update-motd.d/*.dpkg-dist && \
    apt-get -y -qq upgrade && \
    apt-get install -y -qq \
	bash \
	bash-completion \
	bc \
	ca-certificates \
	cron \
	curl \
	dbus \
	dstat \
	ethstatus \
	file \
	fio \
	haveged \
	htop \
	ioping \
	iotop \
	iperf \
	iptables \
	iputils-ping \
	isc-dhcp-client \
	less \
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
	python-software-properties \
	python-yaml \
	rsync \
	rsyslog \
	screen \
	shunit2 \
	socat \
	ssh \
	sudo \
	sysstat \
	tar \
	tcpdump \
	tmux \
	uuid-runtime \
	vim \
	wget \
	whiptail \
	software-properties-common \
	unattended-upgrades \
	&& apt-get clean


# Patch rootfs
# - Tweaks rootfs so it matches Scaleway infrastructure
RUN rm -f /etc/update-motd.d/10-help-text /etc/update-motd.d/00-header
COPY ./overlay-base/ ./overlay/ ./overlay-${ARCH}/ /


# remove root password, it will be created by the initrd
RUN passwd -d root


# Configure locales
RUN locale-gen en_US.UTF-8 && \
    locale-gen fr_FR.UTF-8 && \
    dpkg-reconfigure locales

RUN rm -f /etc/machine-id /var/lib/dbus/machine-id


# Fix permissions
RUN chown root:syslog /var/log \
 && chmod 755 /etc/default


# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
