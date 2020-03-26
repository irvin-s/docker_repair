FROM debian:jessie

RUN apt-get update && apt-get install -y \
    nginx \
    nginx-extras

ADD nginx.conf /etc/nginx/
ADD default.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/default.conf /etc/nginx/sites-enabled/docker
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u $USER_ID www-data -s /bin/bash

CMD ["nginx"]

EXPOSE 80
EXPOSE 443