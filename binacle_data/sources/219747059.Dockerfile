FROM wocker/base

MAINTAINER ixkaito <ixkaito@gmail.com>

#
# PHP must be installed after Apache
#
RUN apt-get update \
  && apt-get clean \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    apache2 \
    libapache2-mod-php \
    php7.0 \
    php7.0-bz \
    php7.0-cli \
    php7.0-curl \
    php7.0-gd \
    php7.0-mbstring \
    php7.0-mysql \
    php7.0-xdebug \
    php7.0-xml \
    php7.0-zip \
  && rm -rf /var/lib/apt/lists/*

#
# Apache settings
#
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf \
  && sed -i -e '/<Directory \/var\/www\/>/,/<\/Directory>/ s/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf \
  && sed -i -e "s#DocumentRoot.*#DocumentRoot /var/www/wordpress#" /etc/apache2/sites-available/000-default.conf \
  && sed -i -e "s/export APACHE_RUN_USER=.*/export APACHE_RUN_USER=wocker/" /etc/apache2/envvars \
  && sed -i -e "s/export APACHE_RUN_GROUP=.*/export APACHE_RUN_GROUP=wocker/" /etc/apache2/envvars \
  && a2enmod rewrite

#
# php.ini settings
#
RUN sed -i -e "s/^upload_max_filesize.*/upload_max_filesize = 32M/" /etc/php/7.0/apache2/php.ini \
  && sed -i -e "s/^post_max_size.*/post_max_size = 64M/" /etc/php/7.0/apache2/php.ini \
  && sed -i -e "s/^display_errors.*/display_errors = On/" /etc/php/7.0/apache2/php.ini \
  && sed -i -e "s/^;mbstring.internal_encoding.*/mbstring.internal_encoding = UTF-8/" /etc/php/7.0/apache2/php.ini \
  && sed -i -e "s#^;sendmail_path.*#sendmail_path = /usr/local/bin/mailhog sendmail#" /etc/php/7.0/apache2/php.ini

#
# Install WordPress
#
WORKDIR ${DOCROOT}
RUN service mysql start \
  && mysqladmin -u root password root \
  && mysql -uroot -proot -e \
    "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8; grant all privileges on wordpress.* to wordpress@'%' identified by 'wordpress';" \
  && wp core download --allow-root \
  && wp config create --allow-root \
    --dbname=wordpress \
    --dbuser=wordpress \
    --dbpass=wordpress \
  && wp core install --allow-root \
    --admin_name=admin \
    --admin_password=admin \
    --admin_email=admin@example.com \
    --url=http://wocker.test \
    --title=WordPress \
  && wp theme update --allow-root --all \
  && wp plugin update --allow-root --all \
  && chown -R wocker:wocker ${DOCROOT}

#
# Open ports
#
EXPOSE 80 3306 8025

#
# Supervisor
#
RUN mkdir -p /var/log/supervisor
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

CMD ["/usr/bin/supervisord"]
