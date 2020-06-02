FROM ubuntu:latest

MAINTAINER Roman Krivetsky <r.krivetsky@gmail.com>

EXPOSE 80

RUN apt-get update -y && \
	apt-get install -y apache2 php5 php5-mysql php5-xdebug && \
	install --directory --owner=www-data --group=www-data /var/log/xdebug

COPY xdebug.ini /etc/php5/mods-available/xdebug.ini

WORKDIR /var/www/html

CMD apache2ctl -D FOREGROUND
