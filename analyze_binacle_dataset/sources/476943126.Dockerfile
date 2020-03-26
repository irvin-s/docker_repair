FROM debian:jessie-slim
MAINTAINER Damien Debin <damien.debin@smartapps.fr>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN \
 apt-get update &&\
 apt-get -y --no-install-recommends install locales apt-utils &&\
 echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
 locale-gen en_US.UTF-8 &&\
 /usr/sbin/update-locale LANG=en_US.UTF-8 &&\
 echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
 echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
 apt-get -y --no-install-recommends install ca-certificates git subversion php5-mysqlnd php5-cli php5-sqlite php5-mcrypt php5-curl php5-intl php-gettext php5-json php5-geoip php5-apcu php5-gd php5-imagick php5-xdebug php5-xhprof php5-xmlrpc imagemagick openssh-client curl software-properties-common gettext zip mysql-server mysql-client apt-transport-https ruby python python3 perl php5-memcached memcached bzip2 &&\
 curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
 curl -sSL https://deb.nodesource.com/setup_4.x | bash - &&\
 apt-get -y --no-install-recommends install nodejs yarn &&\
 apt-get autoclean && apt-get clean && apt-get autoremove

RUN \
 sed -ri -e "s/^variables_order.*/variables_order=\"EGPCS\"/g" /etc/php5/cli/php.ini &&\
 echo "xdebug.max_nesting_level=250" >> /etc/php5/mods-available/xdebug.ini

RUN \
 curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin &&\
 curl -sSL https://phar.phpunit.de/phpunit-5.7.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit  &&\
 curl -sSL http://codeception.com/codecept.phar -o /usr/bin/codecept && chmod +x /usr/bin/codecept &&\
 npm install --no-color --production --global gulp-cli webpack mocha grunt n &&\
 rm -rf /root/.npm /root/.composer /tmp/* /var/lib/apt/lists/*
