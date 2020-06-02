FROM ubuntu:18.04
MAINTAINER Jason Gegere <jason@htmlgraphic.com>

ENV OS_LOCALE="en_US.UTF-8"
RUN apt-get update && apt-get install -y locales && locale-gen ${OS_LOCALE}
ENV LANG=${OS_LOCALE} \
    LANGUAGE=${OS_LOCALE} \
    LC_ALL=${OS_LOCALE} \
    DEBIAN_FRONTEND=noninteractive

# Install packages then remove cache package list information
RUN BUILD_DEPS='software-properties-common' \
    && dpkg-reconfigure locales \
        && apt-get install -y $BUILD_DEPS \
        && add-apt-repository -y ppa:ondrej/php \
        && add-apt-repository -y ppa:ondrej/apache2 \
        && apt-get update \
        && apt-get install -y curl apache2 libsasl2-modules libapache2-mod-php7.3 php7.3-cli php7.3-readline php7.3-mbstring php7.3-zip php7.3-intl php7.3-xml php7.3-json php7.3-curl php7.3-gd php7.3-pgsql php7.3-mysql php-pear \
    && apt-get update && apt-get install -yq --no-install-recommends \
        git \
        cron \
        ghostscript \
        mailutils \
        iputils-ping \
        mysql-client \
        libgs-dev \
        imagemagick \
        libmagickwand-dev \
        language-pack-en \
        supervisor \
        rsyslog \
        vim \
        wget \
        postfix \
    && apt-get purge -y --auto-remove $BUILD_DEPS \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/*

# POSTFIX
RUN update-locale LANG=en_US.UTF-8

# Copy files to build app, add coming page to root apache dir, include self
# signed SHA256 certs, unit tests to check over the setup
RUN mkdir -p /opt
COPY ./app /opt/app
COPY ./tests /opt/tests

# Unit tests run via build_tests.sh
RUN tar xf /opt/tests/2.1.6.tar.gz -C /opt/tests/

# SUPERVISOR
RUN chmod -R 755 /opt/* \
    && mkdir -p /var/log/supervisor \
    && cp /opt/app/supervisord /etc/supervisor/conf.d/supervisord.conf

# COMPOSER
RUN curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer
RUN composer global require "laravel/installer"
RUN composer global require "vlucas/phpdotenv"

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

# wkhtmltox > HTML > PDF Conversation
RUN tar xf /opt/app/wkhtmltox-0.12.4_linux-generic-amd64.tar.xz -C /opt && mv /opt/wkhtmltox/bin/wk* /usr/bin/
RUN wkhtmltopdf --version

# Enable Apache mods.
RUN a2enmod userdir rewrite ssl

# Environment variables contained within build container.
ENV TERM=xterm \
    LISTEN_PORT=80 \
    APACHE_RUN_USER=www-data \
    APACHE_RUN_GROUP=www-data \
    APACHE_LOG_DIR=/var/log/apache2 \
    APACHE_LOCK_DIR=/var/lock/apache2 \
    APACHE_PID_FILE=/var/run/apache2.pid \
    AUTHORIZED_KEYS=$AUTHORIZED_KEYS \
    DOCKERCLOUD_SERVICE_FQDN=$DOCKERCLOUD_SERVICE_FQDN \
    LOG_TOKEN=$LOG_TOKEN \
    NODE_ENVIRONMENT=$NODE_ENVIRONMENT \
    PATH="~/.composer/vendor/bin:$PATH" \
    SMTP_HOST=$SMTP_HOST \
    SASL_USER=$SASL_USER \
    SASL_PASS=$SASL_PASS

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name="Apache Docker" \
      org.label-schema.description="Docker container running Apache running on Ubuntu, Composer, Lavavel, TDD via Shippable & CircleCI" \
      org.label-schema.url="https://htmlgraphic.com" \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/htmlgraphic/Apache" \
      org.label-schema.vendor="HTMLgraphic, LLC" \
      org.label-schema.version=$VERSION \
      org.label-schema.schema-version="1.0"

# Add VOLUMEs for persistant data or to allow various
# backups of config and databases via --volumes-from
# http://bit.ly/autobuild-and-autodeploy
VOLUME  ["/backup"]

# Note that EXPOSE only works for inter-container links. It doesn't make ports
# accessible from the host. To expose port(s) to the host, at runtime, use the -p flag.
EXPOSE 80 443


#CMD ["/opt/app/run.sh", "env | grep _ >> /etc/environment && supervisord -n"]
CMD ["/opt/app/run.sh"]
