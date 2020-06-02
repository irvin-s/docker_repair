FROM debian:stable
MAINTAINER Matt Erasmus <code@zonbi.org>

ENV DEBIAN_FRONTEND noninteractive

# Base OS/Toolset
RUN apt-get -q update
RUN apt-get -qy install python-pymongo python-crypto \
    nginx spawn-fcgi php5-fpm php5-gd fcgiwrap tmux vim \
    unzip

# NGINX
ADD nginx-default-site /etc/nginx/sites-available/default
RUN echo '\ndaemon off;' >> /etc/nginx/nginx.conf

# Dokuwiki
ADD http://download.dokuwiki.org/src/dokuwiki/dokuwiki-stable.tgz ./dokuwiki-stable.tgz
RUN tar --transform='s#^dokuwiki-\([^/]*\)#var/www/dokuwiki#' -zxf ./dokuwiki-stable.tgz && rm ./dokuwiki-stable.tgz

# IVRE
ADD https://github.com/cea-sec/ivre/tarball/master ./ivre.tar.gz
RUN tar zxf ./ivre.tar.gz && rm ./ivre.tar.gz && \
    mv cea-sec-ivre-* ivre && cd ivre/ && \
    python setup.py build && python setup.py install && \
    cd ../ && rm -rf ivre/
ADD ivre.conf /etc/ivre.conf

# Dokuwiki
RUN apt-get -qy install patch && \
    patch var/www/dokuwiki/inc/html.php usr/local/share/ivre/dokuwiki/backlinks.patch && \
    apt-get -qy --purge autoremove patch
RUN ln -s /usr/local/share/ivre/dokuwiki/doc var/www/dokuwiki/data/pages/doc
RUN ln -s /usr/local/share/ivre/dokuwiki/media/logo.png var/www/dokuwiki/data/media/wiki/logo.png
RUN ln -s /usr/local/share/ivre/dokuwiki/media/doc var/www/dokuwiki/data/media/wiki/doc
RUN touch usr/local/share/ivre/web/static/config.js
RUN echo 'WEB_GET_NOTEPAD_PAGES = ("localdokuwiki", ("/var/www/dokuwiki/data/pages",))' >> /etc/ivre.conf
RUN rm var/www/dokuwiki/install.php
ADD doku-conf-local.php var/www/dokuwiki/conf/local.php
ADD doku-conf-plugins.local.php var/www/dokuwiki/conf/plugins.local.php
ADD doku-conf-acl.auth.php var/www/dokuwiki/conf/acl.auth.php
ADD doku-conf-users.auth.php var/www/dokuwiki/conf/users.auth.php
RUN chown -Rh www-data:www-data var/www/dokuwiki/data var/www/dokuwiki/conf var/www/dokuwiki/lib/plugins

# MongoDB
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' > /etc/apt/sources.list.d/mongodb.list
RUN apt-get -q update && apt-get -qy install mongodb-org
RUN sed -i 's/^bind_ip = /#bind_ip = /' /etc/mongod.conf
RUN chsh -s /bin/bash mongodb

# Custom Stuff
ADD startweb.sh /usr/local/bin/startweb.sh
ADD tmux-startup.sh /usr/local/bin/tmux-startup.sh
RUN chmod 700 /usr/local/bin/startweb.sh /usr/local/bin/tmux-startup.sh

# Start fresh
ADD dbinit.sh /usr/local/bin/dbinit.sh
RUN chmod 700 /usr/local/bin/dbinit.sh

# Web Services
EXPOSE 80
