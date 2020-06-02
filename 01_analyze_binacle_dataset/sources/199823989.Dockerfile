# nginx/php

FROM ubuntu:14.04

# Get some security updates
RUN apt-get update
RUN apt-get -y upgrade

# install nginx, php5, mysql driver and supervisor
RUN apt-get -y install nginx mysql-client php5-fpm php5-mysql supervisor

# Add our config files
ADD conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD conf/nginx.conf /etc/nginx/nginx.conf
ADD conf/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD conf/php.ini /etc/php5/fpm/php.ini
ADD sites/default /etc/nginx/sites-available/default

# disable the daemons for nginx & php
# RUN echo "daemon off;" >> /etc/nginx/nginx.conf
# RUN sed -i "s/;daemonize = yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

# sites volume
RUN mkdir /home/www
RUN echo "<?php phpinfo() ?>" > /home/www/index.php
ADD sites/dbtest.php /home/www/dbtest.php

# Define mountable directories.
#VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/sites-available", "/var/log/nginx", "/home/www"]
# Path to your conf file & sites-* .
# Mount with `-v <data-dir>:/etc/nginx/sites-enabled`

# expose http & https
EXPOSE 80
EXPOSE 443

CMD ["/usr/bin/supervisord"]
