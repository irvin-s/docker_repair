FROM nginx:latest

MAINTAINER Haydar KÜLEKCİ <haydarkulekci@gmail.com>

ADD nginx.conf /etc/nginx/
ADD fastcgi.conf /etc/nginx/
ADD zf2-boilerplate.conf /etc/nginx/sites-available/

RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80 443
