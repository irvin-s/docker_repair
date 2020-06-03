FROM debian:8.0

MAINTAINER Philipp Schmitt <philipp@schmitt.co>

# Dependencies
# TODO: Add NFS support
RUN export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && \
    apt-get install -y cron bzip2 php5-cli php5-gd php5-pgsql php5-sqlite \
    php5-mysqlnd php5-curl php5-intl php5-mcrypt php5-ldap php5-gmp php5-apcu \
    php5-imagick php5-fpm smbclient nginx supervisor && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV OWNCLOUD_VERSION 9.0.0
ENV TIMEZONE UTC

# Fetch ownCloud dist files
ADD https://github.com/owncloud/core/archive/v${OWNCLOUD_VERSION}.tar.gz \
    /tmp/owncloud.tar.gz
ADD https://github.com/owncloud/3rdparty/archive/v${OWNCLOUD_VERSION}.tar.gz \
    /tmp/3rdparty.tar.gz

# Config files and scripts
COPY nginx_nossl.conf /etc/nginx/nginx_nossl.conf
COPY nginx_ssl.conf /etc/nginx/nginx_ssl.conf
COPY php.ini /etc/php5/fpm/php.ini
COPY php-cli.ini /etc/php5/cli/php.ini
COPY cron.conf /etc/owncloud-cron.conf
COPY supervisor-owncloud.conf /etc/supervisor/conf.d/supervisor-owncloud.conf
COPY run.sh /usr/bin/run.sh
COPY occ.sh /usr/bin/occ

# Install ownCloud
RUN tar -C /var/www/ -xvf /tmp/owncloud.tar.gz && \
    tar -C /var/www/ -xvf /tmp/3rdparty.tar.gz && \
    mv /var/www/core-${OWNCLOUD_VERSION} /var/www/owncloud && \
    rmdir /var/www/owncloud/3rdparty && \
    mv /var/www/3rdparty-${OWNCLOUD_VERSION} /var/www/owncloud/3rdparty && \
    chmod +x /usr/bin/run.sh && \
    rm /tmp/owncloud.tar.gz /tmp/3rdparty.tar.gz && \
    su -s /bin/sh www-data -c "crontab /etc/owncloud-cron.conf"

EXPOSE 80 443

VOLUME ["/var/www/owncloud/config", "/var/www/owncloud/data", \
        "/var/www/owncloud/apps", "/var/log/nginx", \
        "/etc/ssl/certs/owncloud.crt", "/etc/ssl/private/owncloud.key"]

WORKDIR /var/www/owncloud
# USER www-data
CMD ["/usr/bin/run.sh"]

ADD php-fpm/www.conf /etc/php5/fpm/pool.d/www.conf
