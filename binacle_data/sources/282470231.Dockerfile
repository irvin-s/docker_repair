FROM creativitykills/nginx-php-server:v1.0.6
COPY init.sh /init.sh
RUN chmod 755 /init.sh

MAINTAINER Hasan Emre Ozer
