FROM nginx
MAINTAINER Outsider <outsideris@gmail.com>

COPY nginx.conf /etc/nginx/nginx.conf
ADD vhost /etc/nginx/vhost

VOLUME ["/var/www"]
