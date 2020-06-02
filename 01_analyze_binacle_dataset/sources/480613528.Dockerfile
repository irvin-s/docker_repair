FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive

# Install updates
# Install supervisor
# Install utilities
# Install Apache
# Install PHP
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    supervisor \
    nano unzip wget \
    apache2 \
    sqlite3 \
    php5 libapache2-mod-php5 php5-sqlite php5-curl

# Configure supervisor
RUN mkdir -p /var/log/supervisor

# Configure supervisord
RUN rm -rf /etc/supervisor/conf.d
RUN ln -s /supervisor /etc/supervisor/conf.d

# Configure Apache
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /http /apache2 /crontabs /supervisor

# Apache mods
RUN a2enmod rewrite expires status

# Configure Apache
RUN rm -rf /etc/apache2/sites-enabled
RUN ln -s /apache2 /etc/apache2/sites-enabled

# PHP-CLI
ADD php-cli.ini /php-cli.ini
RUN ln -s /php-cli.ini /etc/php5/cli/conf.d/04-custom.ini

# Expose clubble folder for mounting
VOLUME ["/http", "/apache2", "/supervisor"]

# 9000 = X-Debug
EXPOSE 80 9000

CMD ["/usr/bin/supervisord"]