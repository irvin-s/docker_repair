FROM ubuntu:14.04
MAINTAINER nlfox <nlfox@msn.cn>

# set some environment variables
ENV APP_NAME app
ENV APP_EMAIL app@laraedit.com
ENV APP_DOMAIN app.dev
ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
# install some prerequisites
RUN apt-get install -y software-properties-common curl build-essential \
    dos2unix gcc git libmcrypt4 libpcre3-dev memcached make python2.7-dev \
    python-pip re2c unattended-upgrades whois vim libnotify-bin nano wget \
    debconf-utils


# add some repositories
RUN apt-add-repository ppa:nginx/stable -y && \
	apt-add-repository ppa:ondrej/php -y && \
    apt-get update

# set the locale
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale  && \
    locale-gen en_US.UTF-8  && \
    ln -sf /usr/share/zoneinfo/UTC /etc/localtime

# install nginx
RUN apt-get install -y --force-yes nginx
COPY homestead /etc/nginx/sites-available/
RUN rm -rf /etc/nginx/sites-available/default && \
    rm -rf /etc/nginx/sites-enabled/default && \
    ln -fs "/etc/nginx/sites-available/homestead" "/etc/nginx/sites-enabled/homestead" && \
    sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf && \
    sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf && \
    echo "daemon off;" >> /etc/nginx/nginx.conf && \
    usermod -u 1000 www-data && \
    chown -Rf www-data.www-data /var/www/html/ && \
    sed -i -e"s/worker_processes  1/worker_processes 5/" /etc/nginx/nginx.conf
VOLUME ["/var/cache/nginx"]
VOLUME ["/var/log/nginx"]

# install php
RUN apt-get install -y --force-yes php7.0-fpm php7.0-cli php7.0-dev php7.0-sqlite3 php7.0-gd \
    php-apcu php7.0-curl php7.0-mcrypt php7.0-imap php7.0-mysql php7.0-readline php-xdebug php-common \
    php7.0-mbstring php7.0-xml php7.0-zip
RUN sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/cli/php.ini && \
    sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini && \
    sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/7.0/fpm/php.ini && \
    sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf && \
    sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_children = 5/pm.max_children = 9/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    sed -i -e "s/;listen.mode = 0660/listen.mode = 0750/g" /etc/php/7.0/fpm/pool.d/www.conf && \
    find /etc/php/7.0/cli/conf.d/ -name "*.ini" -exec sed -i -re 's/^(\s*)#(.*)/\1;\2/g' {} \;
COPY fastcgi_params /etc/nginx/
RUN phpenmod mcrypt && \
    mkdir -p /run/php/ && chown -Rf www-data.www-data /run/php

# install sqlite 
RUN apt-get install -y sqlite3 libsqlite3-dev


# install composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
    printf "\nPATH=\"~/.composer/vendor/bin:\$PATH\"\n" | tee -a ~/.bashrc
    
# install prestissimo
# RUN composer global require "hirak/prestissimo"

# install laravel envoy
RUN composer global require "laravel/envoy"

#install laravel installer
RUN composer global require "laravel/installer"


# install supervisor
RUN apt-get install -y supervisor && \
    mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
VOLUME ["/var/log/supervisor"]


RUN git clone https://github.com/nlfox/ctfPlatform.git /var/www/html/app

RUN ls -al /var/www/html/app/

RUN touch /var/www/html/app/database/database.sqlite

RUN cd /var/www/html/app/ && composer install

COPY .env /var/www/html/app/.env

RUN cd /var/www/html/app/ && php artisan migrate

RUN cd /var/www/html/ && chown -R www-data app/storage

RUN cd /var/www/html/ && chown -R www-data app/database && chmod o+w app/database


# clean up our mess
RUN apt-get remove --purge -y software-properties-common && \
    apt-get autoremove -y && \
    apt-get clean && \
    apt-get autoclean && \
    echo -n > /var/lib/apt/extended_states && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /usr/share/man/?? && \
    rm -rf /usr/share/man/??_*
WORKDIR /var/www/html/app/
# expose ports
EXPOSE 80 443

# set container entrypoints
ENTRYPOINT ["/bin/bash","-c"]
CMD ["/usr/bin/supervisord"]
