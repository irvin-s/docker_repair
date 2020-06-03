FROM ubuntu
MAINTAINER Michael Sauter <michael.sauter@sitepoint.com>

RUN echo deb http://archive.ubuntu.com/ubuntu precise universe >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -q -y php5 php5-mysql mysql-server
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y php5-intl php-apc
RUN a2enmod rewrite

# Composer
RUN DEBIAN_FRONTEND=noninteractive apt-get install -q -y curl
RUN curl -sS https://getcomposer.org/installer | php
RUN chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

# Cleanup
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD ./data /

RUN ./add_user.sh
RUN echo "symfony ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/symfony
RUN chmod 0440 /etc/sudoers.d/symfony

USER symfony

ENV APACHE_RUN_USER symfony
ENV APACHE_RUN_GROUP symfony
ENV APACHE_LOG_DIR /var/log/apache2

EXPOSE 80

CMD "/init.sh"
