FROM debian:jessie

MAINTAINER Paulo Dias <prbdias@gmail.com>

WORKDIR /var/www

RUN chown -R www-data /var/www/

CMD ["true"]