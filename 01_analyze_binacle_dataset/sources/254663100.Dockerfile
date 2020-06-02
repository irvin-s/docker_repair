FROM getdirectus/directus-base-layer:0.0.16
MAINTAINER Kristian Frolund "https://github.com/Froelund"

RUN get-directus 6.4.9
RUN composer install -o -d /var/www/html/
RUN fix-directus-permissions
