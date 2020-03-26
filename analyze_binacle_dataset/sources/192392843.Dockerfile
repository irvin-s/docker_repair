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

# install percona tools
RUN		apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8507EFA5 && \        
		echo "deb http://repo.percona.com/apt jessie main" >>/etc/apt/sources.list && \	
		apt-get update -qq && \
		apt-get -y install percona-toolkit percona-xtrabackup && \
		apt-get clean autoclean && \
		apt-get autoremove --yes && \ 
		rm -rf /var/lib/{apt,dpkg,cache,log}/

ENV		MARIADB_MAJOR 10.1
ENV		MARIADB_VERSION 10.1.23

# install mariadb
RUN		apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db && \
		echo "deb http://ftp.osuosl.org/pub/mariadb/repo/${MARIADB_MAJOR}/debian jessie main" >>/etc/apt/sources.list && \	
		apt-get update -qq && \
		apt-get -y install mariadb-server-${MARIADB_MAJOR}="${MARIADB_VERSION}+maria-1~jessie" mariadb-client-${MARIADB_MAJOR}="${MARIADB_VERSION}+maria-1~jessie" && \
		apt-get clean autoclean && \
		apt-get autoremove --yes && \ 
		rm -rf /var/lib/{apt,dpkg,cache,log}/ && \
		rm -rf /var/lib/mysql && \
		mkdir /var/lib/mysql && \
		sed -ri 's/^(bind-address|skip-networking|log)/;\1/' /etc/mysql/my.cnf

ENV		GALERA_VERSION 25.3.20

# install galera
RUN		apt-get update -qq && \
		apt-get -y install galera-arbitrator-3="${GALERA_VERSION}-jessie" galera-3="${GALERA_VERSION}-jessie" && \
		apt-get clean autoclean && \
		apt-get autoremove --yes && \ 
		rm -rf /var/lib/{apt,dpkg,cache,log}/

# add configuration
ADD		conf.d/utf8.cnf /etc/mysql/conf.d/utf8.cnf
ADD		conf.d/galera.cnf /etc/mysql/conf.d/galera.cnf

# 3306 - MySQL client connections
# 4567 - Galera Cluster replication traffic, multicast replication uses both udp & tcp
# 4568 - For Incremental State Transfers
# 4444 - For all other State Snapshot Transfers

EXPOSE		3306 4444 4567 4568

VOLUME		["/var/lib/mysql"]
COPY		docker-entrypoint.sh /entrypoint.sh

# Set TERM env to avoid mysql client error message "TERM environment variable not set" when running from inside the container
ENV TERM xterm

# default values for configuration options
ENV	MAX_CONNECTIONS=100 \
	PORT=3306 \
	MAX_ALLOWED_PACKET=16M \
	QUERY_CACHE_SIZE=16M \
	QUERY_CACHE_TYPE=1 \
	INNODB_BUFFER_POOL_SIZE=128M \
	INNODB_LOG_FILE_SIZE=48M \
	INNODB_FLUSH_METHOD= \
	INNODB_OLD_BLOCKS_TIME=1000 \
	INNODB_FLUSH_LOG_AT_TRX_COMMIT=1 \
	SYNC_BINLOG=0

ENTRYPOINT	["/entrypoint.sh"]

CMD ["mysqld"]
