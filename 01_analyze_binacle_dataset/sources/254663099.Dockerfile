# Base images after 0.0.10 DON'T have mcrypt
FROM getdirectus/directus-base-layer:0.0.10
MAINTAINER Luis Santos "luis@luissantos.pt"

RUN get-directus 6.3.9
RUN composer install -o -d /var/www/html/
RUN fix-directus-permissions
