FROM mysql:latest

MAINTAINER Andreas Schlapbach <schlpbch@gmail.com>

#EXPOSE 80 443

#Adding MySQL configuration
COPY my.conf /etc/mysql/conf.d/default.cnf
