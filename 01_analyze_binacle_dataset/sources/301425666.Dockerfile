FROM webdevops/php-apache-dev:centos-7-php56

RUN echo 'date.timezone = Asia/Shanghai' >> /opt/docker/etc/php/php.ini \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;