From janes/alpine-lamp
MAINTAINER janes - https://github.com/hxer

COPY rips/ /var/www/localhost/htdocs/rips/

RUN chown -R apache:apache /var/www/localhost/htdocs/rips/
