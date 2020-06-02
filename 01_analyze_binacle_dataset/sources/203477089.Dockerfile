FROM php:5.6.19-apache
MAINTAINER paolo.mainardi@sparkfabrik.com
ENV REFRESHED_AT 2016-03-14

ENV DEBIAN_FRONTEND noninteractive

# Enable apache rewrite.
RUN a2enmod rewrite

# System env variables.
ENV XDEBUG_VERSION 2.4.0
ENV DRUSH_VERSION 8.0.5
ENV VAR_DUMPER_VERSION 3.0.3
ENV GOSU_VERSION 1.7
ENV MAILHOG_VERSION v0.1.9
ENV TIMEZONE "Europe/Rome"

# Install php packages.
RUN apt-get update \
  && apt-get install -y \
  curl \
  cron \
  rsyslog \
  supervisor \
  mysql-client \
  libpng12-dev \
  libjpeg-dev \
  libxml2-dev \
  ruby \
  ruby2.1 \
  ruby2.1-dev\
  git \
  unzip \
  vim \
  libicu-dev \
  libssl-dev \
  && gem install bundler \
  && pecl install xdebug-${XDEBUG_VERSION} \
  && docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
  && docker-php-ext-configure intl \
  && docker-php-ext-configure pcntl \
  && docker-php-ext-install soap gd mbstring pdo pdo_mysql zip intl pcntl \
  && echo "${TIMEZONE}" > /etc/timezone \
  && dpkg-reconfigure -f noninteractive tzdata \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install composer, drush and other tools.
ENV COMPOSER_HOME /composer-libs
RUN mkdir /composer-libs \
    && curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer \
    && composer global require symfony/var-dumper:${VAR_DUMPER_VERSION} \
    && chown -R www-data:www-data /composer-libs \
    && curl -fSL "https://github.com/drush-ops/drush/releases/download/${DRUSH_VERSION}/drush.phar" -o /usr/bin/drush \
    && chmod +x /usr/bin/drush \
    && drush @none dl registry_rebuild-7.x-2.3 \
    && echo "PS1='\[\033[1;36m\]\u\[\033[1;31m\]@\[\033[1;32m\]\h:\[\033[1;35m\]\w\[\033[1;31m\]\$\[\033[0m\] '" >> /etc/bash.bashrc \
    && echo "export TERM=xterm" >> /etc/bash.bashrc \
    && echo "umask 000" >> /etc/bash.bashrc \
    && curl -fSL "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" -o /usr/bin/gosu

# Install mailhog.
RUN curl -fSL "https://github.com/mailhog/MailHog/releases/download/${MAILHOG_VERSION}/MailHog_linux_amd64" -o /usr/local/bin/mailhog \
    && chmod +x /usr/local/bin/mailhog

## Configure PHP and Apache and supervisord.
COPY config/docker/php/*.ini /usr/local/etc/php/conf.d/
COPY config/docker/apache/*.conf /etc/apache2/conf-enabled/
COPY config/docker/supervisord/*.conf /etc/supervisor/conf.d/
RUN mkdir -p /usr/local/etc/php/apache2 && \
    cp -R /usr/local/etc/php/conf.d /usr/local/etc/php/apache2 && \
    echo 'export PHP_INI_SCAN_DIR=/usr/local/etc/php/apache2/conf.d' >> /etc/apache2/envvars && \
    echo 'stage:$apr1$g6T0GvU3$6cxYQhCZvI.1aEFYr1uOd/' > /var/www/.htpasswd && \
    rm -rf /etc/apache2/sites-enabled/*

# Configure cron.
COPY config/docker/cron/crontab /etc/cron.d/cron
RUN rm -Rf /etc/cron.daily  && \
    rm -Rf /etc/cron.weekly && \
    rm -Rf /etc/cron.monthly && \
    rm -Rf /etc/cron.hourly && \
    chmod a+x /etc/cron.d/cron

# Install blackfire agent.
RUN export VERSION=`php -r "echo PHP_MAJOR_VERSION.PHP_MINOR_VERSION;"` \
    && curl -A "Docker" -o /tmp/blackfire-probe.tar.gz -D - -L -s https://blackfire.io/api/v1/releases/probe/php/linux/amd64/${VERSION} \
    && tar zxpf /tmp/blackfire-probe.tar.gz -C /tmp \
    && mv /tmp/blackfire-*.so `php -r "echo ini_get('extension_dir');"`/blackfire.so \
    && echo "extension=blackfire.so\nblackfire.agent_socket=\${BLACKFIRE_PORT}" > $PHP_INI_DIR/apache2/conf.d/blackfire.ini

# Install ngrok.
ADD https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip /ngrok.zip
RUN unzip /ngrok.zip -d /bin && \
 rm -f ngrok.zip && \
 touch /.ngrok

# Expose apache.
EXPOSE 80

# Execute daemons.
CMD exec supervisord -n
