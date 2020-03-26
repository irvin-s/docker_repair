FROM ubuntu:16.04
MAINTAINER dev@cedvan.com

# Version Pydio
ENV PYDIO_VERSION 8.0.1
ENV DEBIAN_FRONTEND=noninteractive

# Install locales
RUN apt-get update -qq \
    && apt-get install -qy locales locales-all \
    && echo 'LANG=en_US.UTF-8' > /etc/default/locale \
    && dpkg-reconfigure locales
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install requirements
RUN apt-get update -qq \
    && apt-get install -qqy \
        apt-utils \
        ca-certificates \
        ssl-cert \
        libaprutil1 \
        apt-transport-https \
        libapr1 \
        wget

# Install supervisor
RUN apt-get update -qq \
    && apt-get install -qqy supervisor

# Install PHP
RUN apt-get update -qq \
    && apt-get install -qqy \
        php-fpm \
        php-cli \
        php-gd \
        php-mcrypt \
        php-mysql \
        php-pgsql \
        php-dom \
        php-intl \
        php-mbstring \
        php-sqlite3

# Install Nginx
RUN apt-get update -qq \
    && apt-get install -qqy \
        nginx \
        apache2-utils

# Install MySQL
RUN apt-get update -qq \
    && apt-get install -qqy \
        mysql-server

# Configure PHP and Nginx
RUN mkdir /run/php \
    && echo "daemon off;" >> /etc/nginx/nginx.conf

# Configure MySQL
RUN mkdir /backup \
    && cp -rf /var/lib/mysql /backup/mysql \
    && rm -rf /var/lib/mysql

# Install build requirements
RUN apt-get update -qq \
    && apt-get install -qqy \
        curl \
        git \
        unzip

# Download Pydio
RUN curl -sL https://github.com/pydio/pydio-core/archive/pydio-core-${PYDIO_VERSION}.tar.gz | tar xzC /tmp \
    && rm -rf /var/www \
    && mv /tmp/pydio-core-pydio-core-${PYDIO_VERSION} /var/www

# Install composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
    && php composer-setup.php \
    && php -r "unlink('composer-setup.php');" \
    && mv composer.phar /bin/composer \
    && chmod +x /bin/composer

# Install NPM
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -\
    && apt-get update -qq \
    && apt-get install -qy nodejs

# Install Grunt
RUN npm install -g grunt-cli

# Install dependancies
RUN cd /var/www/core/src/core \
    && composer install \
    && cd /var/www/core/src \
    && find . -maxdepth 3 -name composer.json -execdir composer install \; \
    && find . -maxdepth 3 -name Gruntfile.js -execdir bash -c "npm install && grunt && rm -rf node_modules" \;

# Remove build requirements
RUN apt-get remove -qy \
        curl \ 
        git \
        wget \ 
        unzip \
        nodejs \
    && apt-get autoremove -qy \
    && apt-get autoclean -qy \
    && rm -rf /bin/composer \
    && rm -rf /root/.composer \
    && rm -rf /too/.npm

# Load permissions
RUN chown -R www-data:www-data /var/www

# Load Scripts bash for installing Pydio
COPY scripts /scripts/pydio/
RUN chmod -R u+x /scripts/pydio

# Load assets
COPY assets/supervisor/conf.d /etc/supervisor/conf.d
COPY assets/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY assets/vhosts /etc/nginx/sites-available
COPY assets/config /assets/config

# Clean
RUN apt-get -qqy --purge autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

VOLUME /data/pydio
VOLUME /var/lib/mysql

EXPOSE 3306
EXPOSE 80
EXPOSE 443

CMD /scripts/pydio/launch.sh
