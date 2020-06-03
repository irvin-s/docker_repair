FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y
RUN apt-get install -y nginx php5-fpm php5-mysqlnd php5-cli mysql-server supervisor

RUN sed -e 's/;daemonize = yes/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf
RUN sed -e 's/;listen\.owner/listen.owner/' -i /etc/php5/fpm/pool.d/www.conf
RUN sed -e 's/;listen\.group/listen.group/' -i /etc/php5/fpm/pool.d/www.conf
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

ADD vhost.conf /etc/nginx/sites-available/default
ADD supervisor.conf /etc/supervisor/conf.d/supervisor.conf
ADD init.sh /init.sh

EXPOSE 80

VOLUME ["/srv"]
WORKDIR /srv

CMD ["/usr/bin/supervisord"]