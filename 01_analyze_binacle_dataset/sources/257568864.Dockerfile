FROM janes/alpine-s6
MAINTAINER janes - https://github.com/hxer/alpine-apache

# Install apache
RUN apk add --update apache2 apache2-utils

# configure apache
RUN sed -i 's#AllowOverride none#AllowOverride All#' /etc/apache2/httpd.conf && \
    sed -i 's#ServerName www.example.com:80#\nServerName localhost:80#' /etc/apache2/httpd.conf
RUN mkdir -p /run/apache2 && chown -R apache:apache /run/apache2

# Add the files
ADD root /

VOLUME ["/var/www/localhost/htdocs"]

# Expose the ports for apache
EXPOSE 80 443