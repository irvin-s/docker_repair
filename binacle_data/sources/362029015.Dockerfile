# Humhub on Turnkeylinux

FROM cboulanger/turnkeylinux-lamp:v14.0
MAINTAINER Christian Boulanger "info@bibliograph.org"

ENV DEBIAN_FRONTEND noninteractive

# Updates & packages install

RUN apt-get remove -y -q webmin shellinabox adminer # remove this line if you want to have those applications
RUN (apt-get update && apt-get upgrade -y -q -o Dpkg::Options::="--force-confold" && apt-get dist-upgrade -y -q -o Dpkg::Options::="--force-confold" && apt-get -y -q autoclean && apt-get -y -q autoremove)
RUN apt-get install -y -q php5-gd php5-curl php5-sqlite php5-ldap php5-intl php-apc wget cron

ENV HUMHUB_VERSION 1.0.1
ENV HUMHUB_DIR_NAME humhub-$HUMHUB_VERSION
ENV HUMHUB_DOWNLOAD_URL http://downloads.sourceforge.net/project/humhub/$HUMHUB_DIR_NAME.tar.gz

RUN rm -rf /var/www/*
RUN wget -q $HUMHUB_DOWNLOAD_URL
RUN tar -xzf $HUMHUB_DIR_NAME.tar.gz
RUN mv $HUMHUB_DIR_NAME /var/www/humhub
RUN chown www-data:www-data -R /var/www

# MySql config

ADD mysql-utf8.cnf /etc/mysql/conf.d/mysql-utf8.cnf

# Apache config

RUN service apache2 stop
RUN a2enmod ssl
RUN a2enmod rewrite
RUN a2dismod status
RUN a2dissite default-ssl
RUN a2dissite 000-default
ADD humhub-ssl.conf /etc/apache2/sites-available/humhub-ssl.conf
RUN a2ensite humhub-ssl.conf

# Run config script

ADD pre-conf.sh /pre-conf.sh
RUN chmod 750 /pre-conf.sh
RUN (/bin/bash -c /pre-conf.sh)

# Import existing data for importing (optional)

ADD humhub-data /humhub-data
ADD import.sh /import.sh
RUN chmod 750 /import.sh
RUN (/bin/bash -c /import.sh)

# Add export script for migrating data to a different container

ADD export.sh /export.sh
RUN chmod 750 /export.sh

# Supervisor

ADD supervisor-humhub.conf /etc/supervisor/conf.d/supervisor-humhub.conf
