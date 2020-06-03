FROM debian:stretch

ENV DEBIAN_FRONTEND noninteractive
ENV TERM xterm

COPY src/01_nodoc /etc/dpkg/dpkg.cfg.d/
COPY src/01_buildconfig /etc/apt/apt.conf.d/

RUN apt-get update \
	&& apt-get dist-upgrade \
	&& apt-get install \
		apt-transport-https \
		build-essential \
		ca-certificates \
		curl \
		dirmngr \
		dbus \
		git \
		gnupg \
		htop \
		init \
		iptables \
		iptraf-ng \
		less \
		libpq-dev \
		libnss-mdns \
		libsqlite3-dev \
		jq \
		nano \
		netcat \
		net-tools \
		ifupdown \
		openssh-client \
		openssh-server \
		openvpn \
		python \
		python-dev \
		rsyslog \
		rsyslog-gnutls \
		strace \
		systemd \
		vim \
		wget \
	&& rm -rf /var/lib/apt/lists/*

ENV NODE_VERSION 10.16.0
ENV NPM_VERSION 6.9.0

RUN curl -SL "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz" | tar xz -C /usr/local --strip-components=1 \
	&& npm install -g npm@"$NPM_VERSION" \
	&& npm cache clear --force \
	&& rm -rf /tmp/*

ENV CONFD_VERSION 0.16.0

RUN wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 \
	&& chmod a+x /usr/local/bin/confd \
	&& ln -s /usr/src/app/config/confd /etc/confd

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# Remove default nproc limit for Avahi for it to work in-container
RUN sed -i "s/rlimit-nproc=3//" /etc/avahi/avahi-daemon.conf

# systemd configuration
ENV container lxc

# We never want these to run in a container
RUN systemctl mask \
	apt-daily.timer \
	dev-hugepages.mount \
	dev-mqueue.mount \
	sys-fs-fuse-connections.mount \
	sys-kernel-config.mount \
	sys-kernel-debug.mount \
	display-manager.service \
	getty@.service \
	systemd-logind.service \
	systemd-remount-fs.service \
	getty.target \
	graphical.target

RUN systemctl disable ssh.service

COPY src/confd.service src/balena-root-ca.service src/balena-host-envvars.service /etc/systemd/system/
COPY src/configure-balena-root-ca.sh src/configure-balena-host-envvars.sh /usr/sbin/
COPY src/journald.conf /etc/systemd/
COPY src/rsyslog.conf src/nsswitch.conf /etc/
COPY src/dbus-no-oom-adjust.conf /etc/systemd/system/dbus.service.d/
COPY src/entry.sh /usr/bin/
COPY src/htoprc /root/.config/htop/

VOLUME ["/sys/fs/cgroup"]
VOLUME ["/run"]
VOLUME ["/run/lock"]

CMD ["/usr/bin/entry.sh"]
