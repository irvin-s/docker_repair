FROM php:7.0-apache

ENV DOWNLOAD_URL http://downloads.sourceforge.net/project/suitecrm/SuiteCRM-7.9.6.zip?r=&ts=1458855387&use_mirror=iweb
ENV DOWNLOAD_FILE suitecrm-7.9.6.zip
ENV EXTRACT_FOLDER SuiteCRM-7.9.6
ENV WWW_FOLDER /var/www/html
ENV WWW_USER www-data
ENV WWW_GROUP www-data

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev unzip cron re2c python tree && \
    docker-php-ext-configure imap --with-imap-ssl --with-kerberos && \
    docker-php-ext-install mysqli curl gd zip mbstring imap pdo pdo_mysql && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmps

RUN curl -o $DOWNLOAD_FILE -L "${DOWNLOAD_URL}" && \
  unzip $DOWNLOAD_FILE && \
  rm $DOWNLOAD_FILE && \
  rm -rf ${WWW_FOLDER}/* && \
  cp -R ${EXTRACT_FOLDER}/* ${WWW_FOLDER}/ && \
  chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}/* && \
  chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}

ADD php.ini /usr/local/etc/php/php.ini
ADD config_override.php.pyt /usr/local/src/config_override.php.pyt
ADD envtemplate.py /usr/local/bin/envtemplate.py
ADD init.sh /usr/local/bin/init.sh

RUN chmod u+x /usr/local/bin/init.sh
RUN chmod u+x /usr/local/bin/envtemplate.py

ADD crons.conf /etc/cron.d/crons.conf
RUN crontab /etc/cron.d/crons.conf

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]

