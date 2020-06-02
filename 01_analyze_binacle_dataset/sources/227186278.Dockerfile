FROM webdevops/apache:ubuntu-16.04

MAINTAINER Eric Pfeiffer <computerfr33k@users.noreply.github.com>

ARG PHP_SOCKET=php-fpm:9000

ARG APACHE_HOST_HTTP_PORT_1=80
ARG APACHE_HOST_HTTP_PORT_2=443
ARG APACHE_HOST_HTTP_PORT_3=8080

ENV WEB_PHP_SOCKET=$PHP_SOCKET

ENV WEB_DOCUMENT_ROOT=/var/www/public/

EXPOSE ${ARG APACHE_HOST_HTTP_PORT_1} ${APACHE_HOST_HTTP_PORT_2} ${APACHE_HOST_HTTP_PORT_3}

WORKDIR /var/www/public/

COPY vhost.conf /etc/apache2/sites-enabled/vhost.conf

ENTRYPOINT ["/opt/docker/bin/entrypoint.sh"]

CMD ["supervisord"]
