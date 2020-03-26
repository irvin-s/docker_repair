FROM php:5.6-apache

ENV DOWNLOAD_URL https://github.com/salesagility/SuiteCRM/archive/v7.8.2.zip
ENV DOWNLOAD_FILE v7.8.2.zip
ENV EXTRACT_FOLDER SuiteCRM-7.8.2
ENV WWW_FOLDER /var/www/html
ENV WWW_USER www-data
ENV WWW_GROUP www-data

RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y libcurl4-gnutls-dev libpng-dev libssl-dev libc-client2007e-dev libkrb5-dev unzip cron re2c python tree && \
    docker-php-ext-configure imap --with-imap-ssl --with-kerberos && \
    docker-php-ext-install mysqli curl gd zip mbstring imap && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp

ADD ${DOWNLOAD_URL} /tmp
RUN unzip $DOWNLOAD_FILE && \
    rm $DOWNLOAD_FILE && \
    rm -rf ${WWW_FOLDER}/* && \
    cp -R ${EXTRACT_FOLDER}/* ${WWW_FOLDER}/ && \
    chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}/* && \
    chown -R ${WWW_USER}:${WWW_GROUP} ${WWW_FOLDER}

COPY php.ini /usr/local/etc/php/php.ini
COPY config_override.php.pyt /usr/local/src/config_override.php.pyt
COPY envtemplate.py /usr/local/bin/envtemplate.py
COPY init.sh /usr/local/bin/init.sh
COPY crons.conf /root/crons.conf

RUN chmod u+x /usr/local/bin/init.sh && \
    chmod u+x /usr/local/bin/envtemplate.py && \
    crontab /root/crons.conf

EXPOSE 80
ENTRYPOINT ["/usr/local/bin/init.sh"]

