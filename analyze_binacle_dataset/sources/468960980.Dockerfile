FROM arm32v7/php:7.0-fpm
MAINTAINER Tuuu <song@secbox.cn>

# Install Ioncube
RUN curl -O https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_armv7l.tar.gz \
 && tar xvfz ioncube_loaders_lin_armv7l.tar.gz \
 && PHP_EXT_DIR=$(php-config --extension-dir) \
 && cp "ioncube/ioncube_loader_lin_7.0.so" $PHP_EXT_DIR \
 && echo "zend_extension=ioncube_loader_lin_7.0.so" >> /usr/local/etc/php/conf.d/00_ioncube_loader_lin_7.0.ini \
 && rm -rf ioncube ioncube_loaders_lin_armv7l.tar.gz


# install php extensions
RUN apt-get update \
    && apt-get install -y \
    libapache2-mod-xsendfile \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    dcraw \
    libcurl4-gnutls-dev \
    libmcrypt-dev \
    locales \
    graphicsmagick \
    mysql-client \
    curl \
    wget \
    sudo \
    aria2 \
    unzip \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) mcrypt pdo_mysql exif zip gd opcache

# download filerun
RUN curl -o /filerun.zip -L https://www.filerun.com/download-latest \
    && mkdir /user-files

# copy filerun dbconfig
COPY autoconfig.php /
COPY db.sql /filerun.setup.sql
COPY ./import-db.sh /
RUN chmod +x /import-db.sh
COPY ./etc/php/php.ini /usr/local/etc/php/

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/entrypoint.sh"]
CMD ["php-fpm"]
