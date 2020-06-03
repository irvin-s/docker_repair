FROM php:5.6-apache

# SugarCRM 7.21 MAX
ENV DOWNLOAD_URL http://iweb.dl.sourceforge.net/project/suitecrm/suitecrm-7.2.1.zip
ENV DOWNLOAD_FILE suitecrm-7.2.1-max.zip
ENV EXTRACT_FOLDER suitecrm-7.2.1-max
ENV WWW_FOLDER /var/www/html
ENV WWW_USER www-data
ENV WWW_GROUP www-data

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev unzip cron re2c python tree && \
    docker-php-ext-configure imap --with-imap-ssl --with-kerberos && \
    docker-php-ext-install mysql curl gd zip mbstring imap && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

RUN curl "${DOWNLOAD_URL}" > $DOWNLOAD_FILE && \
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

ADD crons.conf /root/crons.conf
RUN crontab /root/crons.conf

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]

