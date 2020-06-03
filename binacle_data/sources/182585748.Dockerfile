FROM debian:testing
MAINTAINER Martin Høgh<mh@mapcentia.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive

# Install packages
RUN apt-get -y update
RUN apt-get -y install vim git php-pgsql php-cli wget curl postgis postgresql-11-postgis-2.5 postgresql-11-pgrouting pgbouncer locales-all osm2pgsql supervisor \
    osm2pgsql

# Clone GC2 from GitHub
RUN mkdir /var/www &&\
	cd /var/www/ &&\
	git clone https://github.com/mapcentia/geocloud2.git

# Add config files from Docker repo
ADD conf/postgresql/pg_hba.conf /etc/postgresql/11/main/
ADD conf/gc2/geometry_columns_join.sql /var/www/geocloud2/public/install/

# Copy GC2 config files from GIT repo, so we can create the template database and run migrations
RUN cp /var/www/geocloud2/app/conf/App.php.dist /var/www/geocloud2/app/conf/App.php
RUN cp /var/www/geocloud2/app/conf/Connection.php.dist /var/www/geocloud2/app/conf/Connection.php

# Make config in PostGreSQL
RUN echo "listen_addresses='*'" >> /etc/postgresql/11/main/postgresql.conf

# Expose standard for PostGreSQL and pgboucer
EXPOSE 5432 6432

# Share volumes
VOLUME  ["/var/www/geocloud2", "/etc/postgresql", "/var/log", "/var/lib/postgresql", "/etc/pgbouncer"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

ADD conf/pgbouncer/pgbouncer.ini /etc/pgbouncer/pgbouncer.ini
ADD conf/pgbouncer/userlist.txt /etc/pgbouncer/userlist.txt

RUN chown postgres:postgres /etc/pgbouncer/pgbouncer.ini
RUN chown postgres:postgres /etc/pgbouncer/userlist.txt

# Add Supervisor config and run the deamon
ADD conf/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]