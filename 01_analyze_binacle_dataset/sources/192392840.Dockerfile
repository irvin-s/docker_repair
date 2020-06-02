FROM		debian:jessie
MAINTAINER	Julian Haupt <julian.haupt@hauptmedia.de>

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN		groupadd -r mysql && useradd -r -g mysql mysql

ENV		DEBIAN_FRONTEND noninteractive

# install needed packages
RUN		apt-get update -qq && \
		apt-get upgrade --yes && \
		apt-get -y --no-install-recommends --no-install-suggests install host socat unzip ca-certificates wget curl python-software-properties && \
		apt-get clean autoclean && \
		apt-get autoremove --yes && \ 
		rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV		MARIADB_MAJOR 10.0 
ENV		MARIADB_VERSION 10.0.22

# install mariadb
RUN		apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
		echo "deb http://ftp.hosteurope.de/mirror/mariadb.org/repo/${MARIADB_MAJOR}/debian jessie main" >>/etc/apt/sources.list && \
		apt-get update -qq && \
		apt-get -y install percona-toolkit percona-xtrabackup mariadb-server-${MARIADB_MAJOR}="${MARIADB_VERSION}+maria-1~jessie" mariadb-client-${MARIADB_MAJOR}="${MARIADB_VERSION}+maria-1~jessie" && \
		apt-get clean autoclean && \
		apt-get autoremove --yes && \ 
		rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
		rm -rf /var/lib/mysql && \
		mkdir /var/lib/mysql && \
		sed -ri 's/^(bind-address|skip-networking|log)/;\1/' /etc/mysql/my.cnf

ENV		GALERA_VERSION 25.3.9

# add configuration
ADD		conf.d/utf8.cnf /etc/mysql/conf.d/utf8.cnf

# 3306 - MySQL client connections

EXPOSE		3306

VOLUME		/var/lib/mysql
COPY		docker-entrypoint.sh /entrypoint.sh
ENTRYPOINT	["/entrypoint.sh"]

CMD ["mysqld"]
