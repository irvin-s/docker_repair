# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.9.19

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Avoid ERROR: invoke-rc.d: policy-rc.d denied execution of start.
RUN sed -i "s/^exit 101$/exit 0/" /usr/sbin/policy-rc.d

RUN apt-get update
RUN DEBIAN_FRONTEND="noninteractive" apt-get install -y \
    mariadb-server mariadb-client \
    nginx \
    nodejs npm \
    php7.0-cli php7.0-fpm php7.0-gd php7.0-mcrypt php7.0-mbstring php7.0-xml php7.0-zip php7.0-mysql php7.0-curl \
    redis-server \
    git

# This is a fix for
# ERROR: unable to bind listening socket for address '/run/php/php7.0-fpm.sock': No such file or directory (2)
# ERROR: FPM initialization failed
RUN service php7.0-fpm start

#
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

#
RUN mkdir -p /etc/my_init.d
ADD my_init.d /etc/my_init.d

#
RUN mkdir /database
ADD export.sql /database/import.sql

#
RUN crontab -l | { cat; echo "* * * * * /usr/bin/php /var/www/artisan schedule:run >> /dev/null 2>&1"; } | crontab -

#
EXPOSE 80 3306 6379 3000

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
