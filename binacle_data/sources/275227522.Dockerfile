FROM nginx:latest

MAINTAINER Paulo Dias <prbdias@gmail.com>

ADD nginx.conf /etc/nginx/
ADD site.conf /etc/nginx/sites-available/

RUN echo "upstream php-upstream { server php-fpm:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

EXPOSE 80 443

CMD ["nginx"]
