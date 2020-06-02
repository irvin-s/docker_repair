FROM mikz/base:precise
MAINTAINER Michal Cichra <michal.cichra@gmail.com>

VOLUME ["/var/lib/mysql", "/www"]

ENV MARIADB_VERSION 5.5

RUN cat /proc/mounts > /etc/mtab

RUN apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db \
 && echo "deb http://ftp.osuosl.org/pub/mariadb/repo/$MARIADB_VERSION/ubuntu precise main" >> /etc/apt/sources.list.d/mariadb.list

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C \
 && echo "deb http://ppa.launchpad.net/nginx/stable/ubuntu precise main" > /etc/apt/sources.list.d/nginx.list

RUN apt-get -y -q update \
 && apt-get -y -q install mariadb-client mariadb-server \
 && apt-get -y -q install php5-fpm php5-mysqlnd nginx \
 && apt-get -y -q install supervisor \
 && apt-cleanup

RUN echo "[mysqld]\nbind-address = 0.0.0.0" > /etc/mysql/conf.d/listen.cnf \
 && rm /etc/nginx/sites-enabled/default

ADD config /etc/nginx/sites-enabled/
ADD fastcgi_params /etc/nginx/
ADD supervisord.conf /etc/supervisor/supervisord.conf
ADD php-fpm.conf /etc/php5/fpm/

CMD ["supervisord"]

EXPOSE 80
