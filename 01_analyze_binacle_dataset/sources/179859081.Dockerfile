FROM mysql:5.6
MAINTAINER Justin Littman <justinlittman@gwu.edu>

ADD my.cnf /etc/mysql/conf.d/

VOLUME /var/lib/mysql
