FROM debian:wheezy
MAINTAINER Benjamin Chodoroff <bc@thermitic.net>

RUN apt-get update
RUN apt-get -y install wget
RUN wget -O - "http://nginx.org/keys/nginx_signing.key" | apt-key add -
RUN wget -O - "http://www.dotdeb.org/dotdeb.gpg" | apt-key add -

# Ensure UTF-8
RUN apt-get -y install locales
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# nginx and php5
RUN echo "deb http://nginx.org/packages/debian/ wheezy nginx" > /etc/apt/sources.list.d/nginx.list
RUN echo "deb http://packages.dotdeb.org wheezy all\ndeb-src http://packages.dotdeb.org wheezy all\ndeb http://packages.dotdeb.org wheezy-php55 all\ndeb-src http://packages.dotdeb.org wheezy-php55 all" > /etc/apt/sources.list.d/dotdeb.list

RUN apt-get update
RUN apt-get -y install openssh-server supervisor nginx-extras openssl ca-certificates php5-fpm php5-cli php5-curl php5-mcrypt php5-gd php5-common php5-mysql php5-xmlrpc php5-xsl php5-dev php-pear mysql-client curl git
RUN pear channel-discover pear.drush.org && pear install drush/drush

# openssh
RUN mkdir /var/run/sshd

# supervisor
RUN mkdir -p /var/log/supervisor
ADD config/etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# nginx
RUN rm -rf /etc/nginx
RUN rm -rf /srv/www/*
RUN mkdir -p /var/cache/nginx/microcache
RUN mkdir -p /var/lib/nginx/speed
RUN mkdir -p /var/lib/nginx/body
RUN git clone https://github.com/perusio/drupal-with-nginx /etc/nginx
ADD perusio-customconf.patch /tmp/perusio-customconf.patch
RUN cd /etc/nginx && cat /tmp/perusio-customconf.patch | git apply
ADD config/etc/nginx/sites-available/site.conf /etc/nginx/sites-available/site.conf
RUN mkdir -p /etc/nginx/sites-enabled

# php55
RUN adduser --system --group --home /srv/www www55 && usermod -aG www-data www55
RUN mkdir -p /etc/php5/fpm/pool.d
RUN mkdir /var/log/php
ADD config/etc/php5/fpm/php-fpm.conf /etc/php5/fpm/php-fpm.conf
ADD config/etc/php5/fpm/fpm-pool-common.conf /etc/php5/fpm/fpm-pool-common.conf
ADD config/etc/php5/fpm/php.ini /etc/php5/fpm/php.ini
ADD config/etc/php5/fpm/pool.d/www55.conf /etc/php5/fpm/pool.d/www55.conf
ADD config/etc/php5/cli/php.ini /etc/php5/cli/php.ini

# www
RUN mkdir -p /srv/www/nginx-default
RUN chmod 755 /srv/www
ADD config/srv/www/nginx-default/index.html /srv/www/nginx-default/index.html

VOLUME ["/srv/www", "/etc/nginx/sites-enabled"]

# identities
RUN mkdir /root/.ssh
RUN chown -R root:root /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh
RUN sed -e 's/^PermitRootLogin.*$/PermitRootLogin without-password/g' /etc/ssh/sshd_config > /tmp/sshd_config && mv /tmp/sshd_config /etc/ssh/sshd_config

# store env vars + start supervisord
ADD config/usr/local/sbin/start-with-env.sh /usr/local/sbin/start-with-env.sh

EXPOSE 22
EXPOSE 80
EXPOSE 443

CMD ["/usr/local/sbin/start-with-env.sh"]
