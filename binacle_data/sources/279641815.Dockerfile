FROM debian:stretch-slim
MAINTAINER Damien Debin <damien.debin@smartapps.fr>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US:en

RUN \
 apt-get update &&\
 apt-get -y --no-install-recommends install curl locales apt-utils &&\
 echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen &&\
 locale-gen en_US.UTF-8 &&\
 /usr/sbin/update-locale LANG=en_US.UTF-8 &&\
 echo "mysql-server mysql-server/root_password password root" | debconf-set-selections &&\
 echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections &&\
 apt-get -y --no-install-recommends install ca-certificates gnupg git subversion imagemagick openssh-client curl software-properties-common gettext zip unzip default-mysql-server default-mysql-client apt-transport-https ruby python python3 perl memcached geoip-database make ffmpeg &&\
 curl -sSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
 curl -sSL https://packages.sury.org/php/apt.gpg | apt-key add - &&\
 echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list &&\
 echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/deb.sury.org.list &&\
 curl -sSL https://deb.nodesource.com/setup_8.x | bash - &&\
 apt-get -y --no-install-recommends install \
  php7.1-apcu php7.1-bcmath php7.1-cli php7.1-curl php7.1-gd php7.1-geoip php7.1-gettext php7.1-imagick php7.1-intl php7.1-json php7.1-mbstring php7.1-mcrypt php7.1-mysql php7.1-sqlite3 php7.1-xdebug php7.1-xml php7.1-xmlrpc php7.1-zip php7.1-memcached \
  php7.0-apcu php7.0-bcmath php7.0-cli php7.0-curl php7.0-gd php7.0-geoip php7.0-gettext php7.0-imagick php7.0-intl php7.0-json php7.0-mbstring php7.0-mcrypt php7.0-mysql php7.0-sqlite3 php7.0-xdebug php7.0-xml php7.0-xmlrpc php7.0-zip php7.0-memcached \
  nodejs yarn &&\
 apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* /var/log/* &&\
 update-alternatives --set php /usr/bin/php7.0

RUN \
 sed -ri -e "s/^variables_order.*/variables_order=\"EGPCS\"/g" /etc/php/7.0/cli/php.ini &&\
 echo "xdebug.max_nesting_level=250" >> /etc/php/7.0/mods-available/xdebug.ini &&\
 sed -ri -e "s/^variables_order.*/variables_order=\"EGPCS\"/g" /etc/php/7.1/cli/php.ini &&\
 echo "xdebug.max_nesting_level=250" >> /etc/php/7.1/mods-available/xdebug.ini

RUN \
 curl -sSL https://getcomposer.org/installer | php -- --filename=composer --install-dir=/usr/bin &&\
 curl -sSL https://phar.phpunit.de/phpunit.phar -o /usr/bin/phpunit  && chmod +x /usr/bin/phpunit &&\
 curl -sSL http://codeception.com/codecept.phar -o /usr/bin/codecept && chmod +x /usr/bin/codecept &&\
 npm install --no-color --production --global gulp-cli webpack mocha grunt n &&\
 rm -rf /root/.npm /tmp/* /var/tmp/* /var/lib/apt/lists/* /var/log/*
