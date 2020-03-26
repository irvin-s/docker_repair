FROM phusion/baseimage:0.9.15
MAINTAINER Stephen Ausman <sausman@stackd.com>

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Install Packages
RUN add-apt-repository -y ppa:nginx/stable && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get -y install nginx php5-fpm php5-cli

# Configure PHP
RUN sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/fpm/php.ini && \
  sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php5/cli/php.ini && \
  sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf && \
  sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php5/fpm/php.ini && \
  sed -i "s/;listen.owner = www-data/listen.owner = www-data/" /etc/php5/fpm/pool.d/www.conf && \
  sed -i "s/;listen.group = www-data/listen.group = www-data/" /etc/php5/fpm/pool.d/www.conf && \
  sed -i "s/;listen.mode = 0660/listen.mode = 0660/" /etc/php5/fpm/pool.d/www.conf
ADD run/php5-fpm.sh /etc/service/php5-fpm/run
RUN chmod +x        /etc/service/php5-fpm/run

# Set up Sabre DAV
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=bin --filename=composer
WORKDIR /var/www
RUN composer require sabre/dav ~2.0.5
WORKDIR /
ADD app/server.php          /var/www/server.php
RUN chown www-data:www-data /var/www/server.php && \
  mkdir -p    /var/www/data && \
  chmod a+rwx /var/www/data && \
  mkdir -p /var/www/files
ADD prepare/01_set_permissions.sh    /etc/my_init.d/01_set_permissions.sh
ADD prepare/02_set_nginx_htpasswd.sh /etc/my_init.d/02_set_nginx_htpasswd.sh
RUN chmod +x /etc/my_init.d/*.sh
VOLUME ["/var/www/files"]

# Configure Nginx
RUN echo "daemon off;" >> /etc/nginx/nginx.conf
ADD config/nginx.conf     /etc/nginx/sites-available/default
ADD run/nginx.sh /etc/service/nginx/run
RUN chmod +x     /etc/service/nginx/run

# Expose Port 80
EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
