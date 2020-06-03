FROM ubuntu
MAINTAINER "Alexander Trauzzi" <atrauzzi@gmail.com>

WORKDIR /tmp

RUN apt-get update -y
ADD /laravel/public /var/www/public

RUN apt-get install -y nginx

ADD images/nginx/nginx.conf /nginx.base.conf

ADD images/nginx/laravel.conf /etc/nginx/sites-available/laravel
RUN ln -s /etc/nginx/sites-available/laravel /etc/nginx/sites-enabled/laravel
RUN rm /etc/nginx/sites-enabled/default

ADD images/nginx/entrypoint.sh /entrypoint.sh

EXPOSE 8080
ENTRYPOINT ["/entrypoint.sh"]
