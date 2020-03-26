FROM php:7.2-cli

# Install applications needed by Composer
RUN apt-get update && \
    apt-get install -y git zip wget && \
    apt-get purge -y --auto-remove;

# Install XDebug
ADD install_xdebug_beta.sh /tmp/
RUN bash /tmp/install_xdebug_beta.sh \
    && echo "zend_extension=$(find /usr/local/lib/php/extensions/ -name xdebug.so)" > /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_enable=on" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_autostart=off" >> /usr/local/etc/php/conf.d/xdebug.ini ;

# Download latest composer.phar with hash check and add to path
RUN mkdir /root/bin \
    && cd /root/bin \
    && wget -nv -nc https://getcomposer.org/installer -O composer-setup.php \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && chmod u+x /root/bin/composer.phar \
    && ln -s /root/bin/composer.phar /root/bin/composer ;

ENV PATH $PATH:/root/bin

# Create separate "baked in" PHPMD and PHPCS (needed only for PHPStorm inspections)
RUN mkdir --parent /var/phptools
COPY inspections-composer.json /var/phptools/composer.json
RUN cd /var/phptools \
    && composer update \
    && composer clear-cache ;

# Expose main working directory so that project can be mounted there
VOLUME /var/php
WORKDIR /var/php

#CMD vendor/bin/phpunit ./test
CMD bash
