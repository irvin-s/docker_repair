FROM php:7.0-apache
MAINTAINER Kishore Anekalla "kishorereddyanekalla@gmail.com"

COPY . /var/www/html/
EXPOSE 80
