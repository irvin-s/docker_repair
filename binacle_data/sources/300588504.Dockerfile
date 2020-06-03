FROM indexyz/docker-php-7

MAINTAINER Indexyz <jiduye@gmail.com>

RUN rm -f /start.sh

COPY run.sh /start.sh

RUN yum install git zip unzip -y &&\
    rm -rf /data/www && \
    mkdir /data/www && \
    cd /data && \
    git clone -b new_master https://github.com/esdeathlove/ss-panel-v3-mod.git www && \
    cd /data/www && \
    chmod -R 777 * && \
    cp /data/www/config/.config.php.example /data/www/config/.config.php && \
    /usr/local/php/bin/php composer.phar install && \
    /usr/local/php/bin/php xcat initdownload && \
    /usr/local/php/bin/php xcat initQQWry && \
    rm -rf /data/www/public/ssr-download/.git && \
    rm -rf /tmp/* /var/tmp/* && yum clean all && \
    chmod +x /start.sh

WORKDIR /data/www
EXPOSE 80
