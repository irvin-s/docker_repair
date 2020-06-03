FROM nginx:latest

MAINTAINER Cristian Angulo Nova @nietzscheson <cristianangulonova@gmail.com>

ADD nginx.conf /etc/nginx/

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

CMD ["nginx"]

EXPOSE 80
EXPOSE 443
