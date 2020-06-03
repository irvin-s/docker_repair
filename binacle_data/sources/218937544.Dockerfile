FROM ubuntu:trusty

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN groupadd -r mysql && useradd -r -g mysql mysql

ENV PERCONA_XTRADB_VERSION 5.6
ENV MYSQL_VERSION 5.6
ENV TERM linux

# FATAL ERROR: please install the following Perl modules before executing /usr/local/mysql/scripts/mysql_install_db:
# File::Basename
# File::Copy
# Sys::Hostname
# Data::Dumper
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y perl curl --no-install-recommends && rm -rf /var/lib/apt/lists/*

# gpg: key 5072E1F5: public key "MySQL Release Engineering <mysql-build@oss.oracle.com>" imported
RUN apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A && \
  echo "deb http://repo.percona.com/apt trusty main" > /etc/apt/sources.list.d/percona.list && \
  echo "deb-src http://repo.percona.com/apt trusty main" >> /etc/apt/sources.list.d/percona.list

# the "/var/lib/mysql" stuff here is because the mysql-server postinst doesn't have an explicit way to disable the mysql_install_db codepath besides having a database already "configured" (ie, stuff in /var/lib/mysql/mysql)
# also, we set debconf keys to make APT a little quieter
RUN { \
                echo percona-server-server-5.6 percona-server-server/data-dir select ''; \
                echo percona-server-server-5.6 percona-server-server/root_password password ''; \
        } | debconf-set-selections \
        && apt-get update && DEBIAN_FRONTEND=nointeractive apt-get install -y percona-xtradb-cluster-client-"${MYSQL_VERSION}" \ 
           percona-xtradb-cluster-common-"${MYSQL_VERSION}" percona-xtradb-cluster-server-"${MYSQL_VERSION}" xinetd \
        && rm -rf /var/lib/apt/lists/* \
        && rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql 

VOLUME /var/lib/mysql

COPY my.cnf /etc/mysql/my.cnf
COPY cluster.cnf /tmp/cluster.cnf
# need random.sh because otherwise, ENV $RANDOM is not set
COPY random.sh /tmp/random.sh
RUN /tmp/random.sh


ADD zurmo.sql /zurmo.sql
ADD check_cluster_size.sql /check_cluster_size.sql
ADD xinetd_zurmochk /etc/xinetd.d/xinetd_zurmochk
ADD zurmochk.sh /usr/local/bin/zurmochk.sh
# add confd
ADD https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 /usr/local/bin/confd
RUN chmod u+x /usr/local/bin/confd && \
  mkdir -p /etc/confd/conf.d && \
  mkdir -p /etc/confd/templates && \
  chmod u+x /usr/local/bin/zurmochk.sh
ADD conf.d /etc/confd/mysql/conf.d
ADD templates /etc/confd/mysql/templates


COPY docker-entrypoint.sh /entrypoint.sh
COPY restart_mysql.sh /restart_mysql.sh
ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 3306 4444 4567 4568
CMD ["mysqld"]

