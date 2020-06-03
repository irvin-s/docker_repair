FROM debian:wheezy

MAINTAINER Felipe Bessa Coelho <fcoelho.9@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y php5-fpm php5-mysql php5-gd php5-dev php5-curl php-apc php5-cli php5-json php5-ldap
RUN \
	sed -i "s/listen =.*/listen = 0.0.0.0:9000/g" /etc/php5/fpm/pool.d/www.conf && \
	sed -i "s/;daemonize.*/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

ADD run.sh /run.sh

EXPOSE 9000

CMD ["/run.sh"]

