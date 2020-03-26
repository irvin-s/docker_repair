# Use osixia/light-baseimage
# sources: https://github.com/osixia/docker-light-baseimage
FROM osixia/light-baseimage:1.1.2

# MariaDB version
ARG MARIADB_MAJOR=10.3
ARG MARIADB_VERSION=1:10.3.15+maria~stretch

# Add mysql user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
# https://github.com/docker-library/mariadb/blob/master/10.0/Dockerfile
RUN groupadd -r mysql && useradd -r -g mysql mysql

# Add MariaDB repository
RUN apt-key adv --no-tty --recv-keys --keyserver keyserver.ubuntu.com 0xF1656F24C74CD1D8 \
    && echo "deb http://ftp.igh.cnrs.fr/pub/mariadb/repo/$MARIADB_MAJOR/debian stretch main" > /etc/apt/sources.list.d/mariadb.list \
    && { \
    echo 'Package: *'; \
    echo 'Pin: release o=MariaDB'; \
    echo 'Pin-Priority: 999'; \
    } > /etc/apt/preferences.d/mariadb
# add repository pinning to make sure dependencies from this MariaDB repo are preferred over Debian dependencie

# Add multiple process stack and ssl tools
# sources: https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/add-multiple-process-stack
#          https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/add-service-available
#          https://github.com/osixia/docker-light-baseimage/blob/stable/image/service-available/:ssl-tools/download.sh
# Install MariaDB and MariaDB Backup
RUN apt-get -y update \
    && /container/tool/add-multiple-process-stack \
    && /container/tool/add-service-available :ssl-tools \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    mariadb-server=$MARIADB_VERSION \
    mariadb-backup=$MARIADB_VERSION \
    gzip \
    && apt-get remove -y --purge --auto-remove curl ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Add service directory to /container/service
ADD service /container/service

# Use baseimage install-service script
# https://github.com/osixia/docker-light-baseimage/blob/stable/image/tool/install-service
RUN /container/tool/install-service

# Add default env variables
ADD environment /container/environment/99-default

# Set MariaDB database and backup directories in data volumes
VOLUME ["/var/lib/mysql", "/data/backup"]

# Expose MariaDB default port
EXPOSE 3306
