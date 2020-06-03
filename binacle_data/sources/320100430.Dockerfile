FROM php7-fpm-deb:0.0.1
# from https://www.drupal.org/requirements/php#drupalversions
MAINTAINER jinal--shah <jnshah@gmail.com>
LABEL Name="eurostar-drupal8-fpm" Vendor="sortuniq" Version="0.0.1" \
      Description="drupalised php7-fpm on debian with composer, nvm, npm and jspm"
# build instructions:
# img_name=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Name="\([^"]\+\).*/\1/')
# tag_version=$(grep '^LABEL ' ./Dockerfile | sed -e 's/.*Version="\([^"]\+\).*/\1/')
# docker build --no-cache=true --rm --tag $img_name:$tag_version .
# docker rmi $img_name:stable 2>/dev/null
# docker tag $img_name:$tag_version $img_name:stable
#
# Based on work here:
# - https://github.com/docker-library/drupal/blob/master/8.1/fpm/Dockerfile
#
# - abstracted so user can customise same source with more ENV vars at build time.
# - added:
#   - composer
#   - phpredis (php7 branch)
#   - git for composer pulls
#   - mysql client for drush
# - stuff installed under /srv/eurostar

WORKDIR /srv/eurostar/htdocs

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION=8.1.2                                           \
    DRUPAL_MD5=91fdfbd1c28512e41f2a61bf69214900                    \
    NPM_VERSION="v0.12.7"                                          \
    URI_DRUPAL="http://ftp.drupal.org/files/projects"              \
    APT_PKGS="libpng12-dev libjpeg-dev libpq-dev git mysql-client" \
    CFG_ARGS_GD="--with-png-dir=/usr --with-jpeg-dir=/usr"         \
    EXT_LIST="gd mbstring opcache pdo pdo_mysql pdo_pgsql zip"     \
    NVM_URI="https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh"

# install the PHP extensions we need
RUN apt-get update                                \
    && apt-get install -y ${APT_PKGS}             \
    && rm -rf /var/lib/apt/lists/*                \
    && docker-php-ext-configure gd ${CFG_ARGS_GD} \
    && docker-php-ext-install ${EXT_LIST}         \
    && git clone --branch php7 https://github.com/phpredis/phpredis.git \
    && ( cd phpredis && phpize && ./configure --enable-redis && make && make install) \
    && rm -rf phpredis && docker-php-ext-enable redis

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN {                                              \
        echo 'opcache.memory_consumption=128';     \
        echo 'opcache.interned_strings_buffer=8';  \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60';         \
        echo 'opcache.fast_shutdown=1';            \
        echo 'opcache.enable_cli=1';               \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini

RUN curl -fSL "${URI_DRUPAL}/drupal-${DRUPAL_VERSION}.tar.gz" \
         -o drupal.tar.gz                                     \
    && curl -sS https://getcomposer.org/installer             \
    | php -- --install-dir=/usr/local/bin                     \
          --filename=composer                                 \
    && echo "... installing nvm" >&2                          \
    && curl -o- $NVM_URI | bash                               \
    && [ -f /root/.nvm/nvm.sh ]                               \
    && echo "... installed nvm successfully" >&2              \
    && echo $NPM_VERSION > .nvmrc                             \
    && echo "... testing nvm" >&2                             \
    && . /root/.nvm/nvm.sh || /bin/true                       \
    && nvm install                                            \
    && nvm use                                                \
    && echo "... installing jspm"                             \
    && npm install jspm -g                                    \
    && echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c -      \
    && tar -xz --strip-components=1 -f drupal.tar.gz          \
    && rm drupal.tar.gz                                       \
    && chown -R www-data:www-data sites
