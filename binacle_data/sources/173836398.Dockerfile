FROM debian:jessie
MAINTAINER Lars Janssen <lars@fazy.net>

# Install Apache PHP mod and its dependencies (including Apache and PHP!)
ENV DEBIAN_FRONTEND noninteractive
RUN    apt-get update \
    && apt-get -yq install \
        curl \
        libapache2-mod-php5 \
        php5-intl \
        php5-curl \
    && rm -rf /var/lib/apt/lists/*

# Configure PHP (CLI and Apache)
RUN sed -i "s/;date.timezone =/date.timezone = UTC/" /etc/php5/cli/php.ini \
    && sed -i "s/;date.timezone =/date.timezone = UTC/" /etc/php5/apache2/php.ini

# Configure Apache
RUN rm -rf /var/www/* \
    && a2enmod rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf
ADD vhost.conf /etc/apache2/sites-available/000-default.conf

# Add main start script for when image launches
ADD run.sh /run.sh
RUN chmod 0755 /run.sh

# Main attributes for running the container
WORKDIR /app
EXPOSE 80
CMD ["/run.sh"]

