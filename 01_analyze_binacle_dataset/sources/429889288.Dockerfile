# This file creates a container that runs Database (Percona) with Galera Replication.
#
# Author: Paul Czarkowski
# Date: 08/16/2014

FROM dockenstack/base

RUN \
  locale-gen en_US.UTF-8 && \
    apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A || \
    apt-key adv --keyserver hkp://keys.gnupg.net:80 --recv-keys 1C4CBDCDCD2EFD2A

RUN \
  echo "deb http://repo.percona.com/apt `lsb_release -cs` main" > /etc/apt/sources.list.d/percona.list && \
  echo "deb-src http://repo.percona.com/apt `lsb_release -cs` main" >> /etc/apt/sources.list.d/percona.list && \
  ln -fs /bin/true /usr/bin/chfn && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y percona-xtradb-cluster-client-5.6 \
  percona-xtradb-cluster-server-5.6 percona-xtrabackup percona-xtradb-cluster-garbd-3.x && \
  sed -i 's/^\(bind-address\s.*\)/# \1/' /etc/mysql/my.cnf && \
  rm -rf /var/lib/mysql/* && \
  rm -rf /var/log/mysql/*


# Define mountable directories.
VOLUME ["/var/lib/mysql", "/var/log/mysql"]

ADD . /app

# Define working directory.
WORKDIR /app

RUN chmod +x /app/bin/*

# Define default command.
CMD ["/app/bin/boot"]

# Expose ports.
EXPOSE 3306 4444 4567 4568
