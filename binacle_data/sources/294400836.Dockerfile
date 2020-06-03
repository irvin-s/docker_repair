FROM ubuntu:16.04

MAINTAINER Maksim Kotliar <kotlyar.maksim@gmail.com>

ENV LC_ALL=C.UTF-8

RUN apt-get update && \
    apt-get -y --no-install-recommends --no-install-suggests install software-properties-common python-software-properties && \
    add-apt-repository ppa:ondrej/php && \
    add-apt-repository ppa:ondrej/pkg-gearman && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get remove php7.0 && \
    apt-get install -y --no-install-recommends --no-install-suggests nginx php7.3 php7.3-fpm php7.3-cli php7.3-common ca-certificates gettext && \
    rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stderr /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log \
	&& ln -sf /dev/stderr /var/log/php7.3-fpm.log \
	&& ln -sf /dev/stderr /var/log/php-fpm.log

RUN rm -f /etc/nginx/sites-enabled/*

COPY nginx.conf.tpl /nginx.conf.tpl
COPY nginx_ssl.conf.tpl /nginx_ssl.conf.tpl
COPY php-fpm.conf.tpl /php-fpm.conf.tpl
COPY defaults.ini /etc/php/7.3/cli/conf.d/defaults.ini
COPY defaults.ini /etc/php/7.3/fpm/conf.d/defaults.ini

RUN mkdir -p /run/php && touch /run/php/php7.3-fpm.sock && touch /run/php/php7.3-fpm.pid

COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh

EXPOSE 80

CMD ["/entrypoint.sh"]
