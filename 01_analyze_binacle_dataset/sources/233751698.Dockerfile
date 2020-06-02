FROM niiknow/docker-hostingbase:0.9.2

MAINTAINER friends@niiknow.org

ENV DEBIAN_FRONTEND=noninteractive \
    GOLANG_VERSION=1.8.3 \
    DOTNET_DOWNLOAD_URL=https://download.microsoft.com/download/D/7/A/D7A9E4E9-5D25-4F0C-B071-210CB8267943/dotnet-ubuntu.16.04-x64.1.1.2.tar.gz  \
    NGINX_BUILD_DIR=/usr/src/nginx \
    NGINX_VERSION=1.13.3 \
    NGINX_PAGESPEED_VERSION=1.12.34.2 \
    NGINX_PAGESPEED_DIR=/usr/src/nginx/ngx_pagespeed-latest-stable/ \
    IMAGE_FILTER_URL=https://raw.githubusercontent.com/niiknow/docker-nginx-image-proxy/master/build/src/ngx_http_image_filter_module.c

# start
RUN \
    cd /tmp \

# add our user and group first to make sure their IDs get assigned consistently
    && echo "nginx mysql bind clamav ssl-cert dovecot dovenull Debian-exim postgres debian-spamd epmd couchdb memcache mongodb redis" | xargs -n1 groupadd -K GID_MIN=100 -K GID_MAX=999 ${g} \
    && echo "nginx nginx mysql mysql bind bind clamav clamav dovecot dovecot dovenull dovenull Debian-exim Debian-exim postgres postgres debian-spamd debian-spamd epmd epmd couchdb couchdb memcache memcache mongodb mongodb redis redis" | xargs -n2 useradd -d /nonexistent -s /bin/false -K UID_MIN=100 -K UID_MAX=999 -g ${g} \
    && usermod -d /var/lib/mysql mysql \
    && usermod -d /var/cache/bind bind \
    && usermod -d /var/lib/clamav -a -G Debian-exim clamav && usermod -a -G mail clamav \
    && usermod -d /usr/lib/dovecot -a -G mail dovecot \
    && usermod -d /var/spool/exim4 -a -G mail Debian-exim \
    && usermod -d /var/lib/postgresql -s /bin/bash -a -G ssl-cert postgres \
    && usermod -d /var/lib/spamassassin -s /bin/sh -a -G mail debian-spamd \
    && usermod -d /var/run/epmd epmd \
    && usermod -d /var/lib/couchdb -s /bin/bash couchdb \
    && usermod -d /var/lib/mongodb -a -G nogroup mongodb \
    && usermod -d /var/lib/redis redis \

    && apt-get -o Acquire::GzipIndexes=false update \

# add nginx repo
    && curl -s https://nginx.org/keys/nginx_signing.key | apt-key add - \
    && cp /etc/apt/sources.list /etc/apt/sources.list.bak \
    && echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list \
    && echo "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" | tee -a /etc/apt/sources.list \


    && wget http://repo.ajenti.org/debian/key -O- | apt-key add - \
    && echo "deb http://repo.ajenti.org/debian main main ubuntu" > /etc/apt/sources.list.d/ajenti.list \

    && apt-get update && apt-get upgrade -y \

    && apt-get install -y mariadb-server mariadb-client redis-server fail2ban \
    && dpkg --configure -a \

# update
    && apt-get update && apt-get -y --no-install-recommends upgrade \
    && apt-get install -y --no-install-recommends libpcre3-dev libssl-dev dpkg-dev libgd-dev \

# install nginx with pagespeed first so vesta config can override
    && mkdir -p ${NGINX_BUILD_DIR} \

# Load Pagespeed module, PSOL and nginx
    && cd ${NGINX_BUILD_DIR} \
    && curl -SL https://github.com/pagespeed/ngx_pagespeed/archive/latest-stable.zip  -o ${NGINX_BUILD_DIR}/latest-stable.zip \
    && unzip latest-stable.zip \
    && cd ${NGINX_PAGESPEED_DIR} \
    && curl -SL https://dl.google.com/dl/page-speed/psol/${NGINX_PAGESPEED_VERSION}-x64.tar.gz -o ${NGINX_PAGESPEED_VERSION}.tar.gz \
    && tar -xzf ${NGINX_PAGESPEED_VERSION}.tar.gz \

# get the source
    && cd ${NGINX_BUILD_DIR}; apt-get source nginx=${NGINX_VERSION} -y \
    && mv ${NGINX_BUILD_DIR}/nginx-${NGINX_VERSION}/src/http/modules/ngx_http_image_filter_module.c ${NGINX_BUILD_DIR}/nginx-${NGINX_VERSION}/src/http/modules/ngx_http_image_filter_module.bak \

# apply patch
    && curl -SL $IMAGE_FILTER_URL --output ${NGINX_BUILD_DIR}/nginx-${NGINX_VERSION}/src/http/modules/ngx_http_image_filter_module.c \
    && sed -i "s/--with-http_ssl_module/--with-http_ssl_module --with-http_image_filter_module --add-module=\/usr\/src\/nginx\/ngx_pagespeed-latest-stable\//g" ${NGINX_BUILD_DIR}/nginx-${NGINX_VERSION}/debian/rules \

# get build dependencies
    && cd ${NGINX_BUILD_DIR}; apt-get build-dep nginx -y \
    && cd ${NGINX_BUILD_DIR}/nginx-${NGINX_VERSION}; dpkg-buildpackage -uc -us -b \

# install new nginx package
    && cd ${NGINX_BUILD_DIR}; dpkg -i nginx_${NGINX_VERSION}-1~xenial_amd64.deb \

# put nginx on hold so it doesn't get updates with apt-get upgrade
    && echo "nginx hold" | dpkg --set-selections \

    && apt-get install -yq ajenti php-all-dev pkg-php-tools \
    && apt-get install -yq ajenti-v ajenti-v-nginx ajenti-v-mysql ajenti-v-php5.6-fpm \
        ajenti-v-php7.0-fpm ajenti-v-mail ajenti-v-nodejs ajenti-v-python-gunicorn ajenti-v-ruby-unicorn \

# install other things
    && apt-get install -yf mongodb-org php-mongodb couchdb nodejs memcached php-memcached redis-server openvpn \
        postgresql postgresql-contrib easy-rsa bind9 bind9utils bind9-doc \

# relink nodejs
    && ln -sf "$(which nodejs)" /usr/bin/node \

# setting up dotnet, awscli, golang
# dotnet
    && curl -SL $DOTNET_DOWNLOAD_URL -o /tmp/dotnet.tar.gz \
    && mkdir -p /usr/share/dotnet \
    && tar -zxf /tmp/dotnet.tar.gz -C /usr/share/dotnet \
    && ln -s /usr/share/dotnet/dotnet /usr/bin/dotnet \

# awscli
    && curl -O https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && pip install awscli \

# getting golang
    && cd /tmp \
    && curl -SL https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz -o /tmp/golang.tar.gz \
    && tar -zxf golang.tar.gz \
    && mv go /usr/local \
    && echo "\nGOROOT=/usr/local/go\nexport GOROOT\n" >> /root/.profile \

# pymongo
    && pip install pymongo \

    && apt-get install -yq php5.6-fpm php5.6-mbstring php5.6-cgi php5.6-cli php5.6-dev php5.6-geoip php5.6-common php5.6-xmlrpc \
        php5.6-dev php5.6-curl php5.6-enchant php5.6-imap php5.6-xsl php5.6-mysql php5.6-mysqlnd php5.6-pspell php5.6-gd \
        php5.6-tidy php5.6-opcache php5.6-json php5.6-bz2 php5.6-pgsql php5.6-mcrypt php5.6-readline php5.6-sybase \
        php5.6-intl php5.6-sqlite3 php5.6-ldap php5.6-xml php5.6-redis php5.6-imagick php5.6-zip \

    && apt-get install -yq php7.0-fpm php7.0-mbstring php7.0-cgi php7.0-cli php7.0-dev php7.0-geoip php7.0-common php7.0-xmlrpc \
        php7.0-dev php7.0-curl php7.0-enchant php7.0-imap php7.0-xsl php7.0-mysql php7.0-mysqlnd php7.0-pspell php7.0-gd \
        php7.0-tidy php7.0-opcache php7.0-json php7.0-bz2 php7.0-pgsql php7.0-mcrypt php7.0-readline php7.0-sybase \
        php7.0-intl php7.0-sqlite3 php7.0-ldap php7.0-xml php7.0-redis php7.0-imagick php7.0-zip \

    && apt-get install -yq php7.1-fpm php7.1-mbstring php7.1-cgi php7.1-cli php7.1-dev php7.1-geoip php7.1-common php7.1-xmlrpc \
        php7.1-dev php7.1-curl php7.1-enchant php7.1-imap php7.1-xsl php7.1-mysql php7.1-mysqlnd php7.1-pspell php7.1-gd \
        php7.1-tidy php7.1-opcache php7.1-json php7.1-bz2 php7.1-pgsql php7.1-mcrypt php7.1-readline php7.1-sybase \
        php7.1-intl php7.1-sqlite3 php7.1-ldap php7.1-xml php7.1-redis php7.1-imagick php7.1-zip \

# exclude geoip, redis, imagick and of course: mcrypt
#    && apt-get install -yq php7.2-fpm php7.2-mbstring php7.2-cgi php7.2-cli php7.2-dev php7.2-common php7.2-xmlrpc \
#        php7.2-dev php7.2-curl php7.2-enchant php7.2-imap php7.2-xsl php7.2-mysql php7.2-mysqlnd php7.2-pspell php7.2-gd \
#        php7.2-tidy php7.2-opcache php7.2-json php7.2-bz2 php7.2-pgsql php7.2-readline php7.2-sybase \
#        php7.2-intl php7.2-sqlite3 php7.2-ldap php7.2-xml php7.2-zip \

# patch before adding new files
    && rm -f /var/lib/ajenti/plugins/vh-nginx/ng*.* \
    && rm -f /var/lib/ajenti/plugins/vh-nginx/*.pyc \
    && rm -f /var/lib/ajenti/plugins/vh-php5.6-fpm/php*.* \
    && rm -f /var/lib/ajenti/plugins/vh-php5.6-fpm/*.pyc \
    && rm -f /var/lib/ajenti/plugins/vh-php7.0-fpm/php*.* \
    && rm -f /var/lib/ajenti/plugins/vh-php7.0-fpm/*.pyc \
    && rm -f /var/lib/ajenti/plugins/vh/main.* \
    && rm -f /var/lib/ajenti/plugins/vh/*.pyc \
    && rm -f /var/lib/ajenti/plugins/vh/api.pyc \
    && rm -f /var/lib/ajenti/plugins/vh/processes.pyc \
    && mkdir -p /var/lib/ajenti/plugins/vh-php7.1-fpm \

# finish cleaning up
    && dpkg --configure -a \
    && rm -rf /usr/src/nginx \
    && rm -rf /tmp/.spam* \
    && rm -rf /tmp/* \
    && apt-get -yf autoremove \
    && apt-get clean 

# add files
COPY rootfs/. /

# update ajenti, install other things
RUN \
    cd /tmp \
    && mkdir -p /ajenti-start/sites \
    && chown -R www-data:www-data /ajenti-start/sites \

# no idea why 1000:1000 but that's the permission ajenti installed with
    && chown -R 1000:1000 /var/lib/ajenti \

# change to more useful folder structure
    && sed -i -e "s/\/srv\/new\-website/\/ajenti\/sites\/new\-website/g" /var/lib/ajenti/plugins/vh/api.py \
    && sed -i -e "s/'php-fcgi'/'php7.1-fcgi'/g" /var/lib/ajenti/plugins/vh/api.py \

    && sed -i -e "s/\/etc\/nginx\/nginx\.conf/\/ajenti\/etc\/nginx\/nginx\.conf/g" /etc/init.d/nginx \

# https://github.com/Eugeny/ajenti-v/pull/185
    && sed -i -e "s/'reload'/'update'/g" /var/lib/ajenti/plugins/vh/processes.py \

# activate mongodb
    && chmod +x /etc/init.d/mongod \
    && chmod +x /etc/my_init.d/startup.sh \

# increase memcache max size from 64m to 2g
    && sed -i -e "s/^\-m 64/\-m 2048/g" /etc/memcached.conf \

# fix v8js reference of json first
    && mv /etc/php/5.6/fpm/conf.d/20-json.ini /etc/php/5.6/fpm/conf.d/15-json.ini \

    && echo "extension=v8js.so" > /etc/php/5.6/mods-available/v8js.ini \
    && ln -sf /etc/php/5.6/mods-available/v8js.ini /etc/php/5.6/fpm/conf.d/20-v8js.ini \
    && ln -sf /etc/php/5.6/mods-available/v8js.ini /etc/php/5.6/cli/conf.d/20-v8js.ini \
    && ln -sf /etc/php/5.6/mods-available/v8js.ini /etc/php/5.6/cgi/conf.d/20-v8js.ini \

    && echo "extension=pcs.so" > /etc/php/5.6/mods-available/pcs.ini \
    && ln -sf /etc/php/5.6/mods-available/pcs.ini /etc/php/5.6/fpm/conf.d/15-pcs.ini \
    && ln -sf /etc/php/5.6/mods-available/pcs.ini /etc/php/5.6/cli/conf.d/15-pcs.ini \
    && ln -sf /etc/php/5.6/mods-available/pcs.ini /etc/php/5.6/cgi/conf.d/15-pcs.ini \

    && echo "extension=couchbase.so" > /etc/php/5.6/mods-available/couchbase.ini \
    && ln -sf /etc/php/5.6/mods-available/couchbase.ini /etc/php/5.6/fpm/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/5.6/mods-available/couchbase.ini /etc/php/5.6/cli/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/5.6/mods-available/couchbase.ini /etc/php/5.6/cgi/conf.d/20-couchbase.ini \


    && echo "extension=v8js.so" > /etc/php/7.0/mods-available/v8js.ini \
    && ln -sf /etc/php/7.0/mods-available/v8js.ini /etc/php/7.0/fpm/conf.d/20-v8js.ini \
    && ln -sf /etc/php/7.0/mods-available/v8js.ini /etc/php/7.0/cli/conf.d/20-v8js.ini \
    && ln -sf /etc/php/7.0/mods-available/v8js.ini /etc/php/7.0/cgi/conf.d/20-v8js.ini \

    && echo "extension=pcs.so" > /etc/php/7.0/mods-available/pcs.ini \
    && ln -sf /etc/php/7.0/mods-available/pcs.ini /etc/php/7.0/fpm/conf.d/15-pcs.ini \
    && ln -sf /etc/php/7.0/mods-available/pcs.ini /etc/php/7.0/cli/conf.d/15-pcs.ini \
    && ln -sf /etc/php/7.0/mods-available/pcs.ini /etc/php/7.0/cgi/conf.d/15-pcs.ini \

    && echo "extension=couchbase.so" > /etc/php/7.0/mods-available/couchbase.ini \
    && ln -sf /etc/php/7.0/mods-available/couchbase.ini /etc/php/7.0/fpm/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/7.0/mods-available/couchbase.ini /etc/php/7.0/cli/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/7.0/mods-available/couchbase.ini /etc/php/7.0/cgi/conf.d/20-couchbase.ini \


    && echo "extension=v8js.so" > /etc/php/7.1/mods-available/v8js.ini \
    && ln -sf /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/fpm/conf.d/20-v8js.ini \
    && ln -sf /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/cli/conf.d/20-v8js.ini \
    && ln -sf /etc/php/7.1/mods-available/v8js.ini /etc/php/7.1/cgi/conf.d/20-v8js.ini \

    && echo "extension=pcs.so" > /etc/php/7.1/mods-available/pcs.ini \
    && ln -sf /etc/php/7.1/mods-available/pcs.ini /etc/php/7.1/fpm/conf.d/15-pcs.ini \
    && ln -sf /etc/php/7.1/mods-available/pcs.ini /etc/php/7.1/cli/conf.d/15-pcs.ini \
    && ln -sf /etc/php/7.1/mods-available/pcs.ini /etc/php/7.1/cgi/conf.d/15-pcs.ini \

    && echo "extension=couchbase.so" > /etc/php/7.1/mods-available/couchbase.ini \
    && ln -sf /etc/php/7.1/mods-available/couchbase.ini /etc/php/7.1/fpm/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/7.1/mods-available/couchbase.ini /etc/php/7.1/cli/conf.d/20-couchbase.ini \
    && ln -sf /etc/php/7.1/mods-available/couchbase.ini /etc/php/7.1/cgi/conf.d/20-couchbase.ini \


    && sed -i -e "s/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g" /etc/php/5.6/fpm/php.ini \

# performance tweaks
    && chmod 0755 /etc/init.d/disable-transparent-hugepages \

# increase memcache max size from 64m to 256m
    && sed -i -e "s/^\-m 64/\-m 256/g" /etc/memcached.conf \

# couchdb stuff
    && mkdir -p /var/lib/couchdb \
    && chown -R couchdb:couchdb /usr/bin/couchdb /etc/couchdb /usr/share/couchdb /var/lib/couchdb  \
    && chmod -R 0770 /usr/bin/couchdb /etc/couchdb /usr/share/couchdb /var/lib/couchdb \
 
# secure ssh
    && sed -i -e "s/PermitRootLogin prohibit-password/PermitRootLogin no/g" /etc/ssh/sshd_config \

# increase postgresql limit to support at least 8gb ram
    && sed -i -e "s/^max_connections = 100/max_connections = 300/g" /etc/postgresql/9.5/main/postgresql.conf \
    && sed -i -e "s/^shared_buffers = 128MB/shared_buffers = 2048MB/g" /etc/postgresql/9.5/main/postgresql.conf \
    && sed -i -e "s/%q%u@%d '/%q%u@%d %r '/g" /etc/postgresql/9.5/main/postgresql.conf \
    && sed -i -e "s/^#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/9.5/main/postgresql.conf \
    && sed -i -e "s/^#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config \

# php stuff - after ajenti because of ajenti-php installs
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 600M/" /etc/php/5.6/fpm/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 600M/" /etc/php/7.0/fpm/php.ini \
    && sed -i "s/upload_max_filesize = 2M/upload_max_filesize = 600M/" /etc/php/7.1/fpm/php.ini \

    && sed -i "s/post_max_size = 8M/post_max_size = 600M/" /etc/php/5.6/fpm/php.ini \
    && sed -i "s/post_max_size = 8M/post_max_size = 600M/" /etc/php/7.0/fpm/php.ini \
    && sed -i "s/post_max_size = 8M/post_max_size = 600M/" /etc/php/7.1/fpm/php.ini \

    && sed -i "s/max_input_time = 60/max_input_time = 3600/" /etc/php/5.6/fpm/php.ini \
    && sed -i "s/max_input_time = 60/max_input_time = 3600/" /etc/php/7.0/fpm/php.ini \
    && sed -i "s/max_input_time = 60/max_input_time = 3600/" /etc/php/7.1/fpm/php.ini \

    && sed -i "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php/5.6/fpm/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php/7.0/fpm/php.ini \
    && sed -i "s/max_execution_time = 30/max_execution_time = 3600/" /etc/php/7.1/fpm/php.ini \

    && sed -i -e "s/;sendmail_path =/sendmail_path = \/usr\/sbin\/exim \-t/g" /etc/php/5.6/fpm/php.ini \
    && sed -i -e "s/;sendmail_path =/sendmail_path = \/usr\/sbin\/exim \-t/g" /etc/php/7.0/fpm/php.ini \
    && sed -i -e "s/;sendmail_path =/sendmail_path = \/usr\/sbin\/exim \-t/g" /etc/php/7.1/fpm/php.ini \

# increase open file limit for nginx and apache
    && echo "\n\n* soft nofile 800000\n* hard nofile 800000\n\n" >> /etc/security/limits.conf \

    && service mysql stop \
    && service postgresql stop \
    && service redis-server stop \
    && service fail2ban stop \

    && sed -i -e "s/\/var\/lib\/mysql/\/ajenti\/var\/lib\/mysql/g" /etc/mysql/my.cnf \

# setup redis like memcache
    && sed -i -e "s/127\.0\.0\.1/\*/g" /etc/redis/redis.conf \
    && sed -i -e 's:^save:# save:g' \
      -e 's:^bind:# bind:g' \
      -e 's:^logfile:# logfile:' \
      -e 's:daemonize yes:daemonize no:' \
      -e 's:# maxmemory \(.*\)$:maxmemory 256mb:' \
      -e 's:# maxmemory-policy \(.*\)$:maxmemory-policy allkeys-lru:' \
      /etc/redis/redis.conf \
    && sed -i -e "s/\/etc\/redis/\/ajenti\/etc\/redis/g" /etc/init.d/redis-server \

    && mkdir -p /ajenti-start/etc \
    && mkdir -p /ajenti-start/var/spool \
    && mkdir -p /ajenti-start/var/lib \

    && mv /etc/php /ajenti-start/etc/php \
    && rm -rf /etc/php \
    && ln -s /ajenti/etc/php /etc/php \

    && mv /etc/ssh /ajenti-start/etc/ssh \
    && rm -rf /etc/ssh \
    && ln -s /ajenti/etc/ssh /etc/ssh \

    && mv /etc/nginx   /ajenti-start/etc/nginx \
    && rm -rf /etc/nginx \
    && ln -s /ajenti/etc/nginx /etc/nginx \

    && mv /etc/redis   /ajenti-start/etc/redis \
    && rm -rf /etc/redis \
    && ln -s /ajenti/etc/redis /etc/redis \

    && mkdir -p /var/lib/redis \
    && chown -R redis:redis /var/lib/redis \
    && mv /var/lib/redis /ajenti-start/var/lib/redis \
    && rm -rf /var/lib/redis \
    && ln -s /ajenti/var/lib/redis /var/lib/redis \

    && mkdir -p /var/lib/mongodb \
    && chown -R mongodb:mongodb /var/lib/mongodb \
    && mv /var/lib/mongodb /ajenti-start/var/lib/mongodb \
    && rm -rf /var/lib/mongodb \
    && ln -s /vesta/var/lib/mongodb /var/lib/mongodb \

    && mv /etc/openvpn /ajenti-start/etc/openvpn \
    && rm -rf /etc/openvpn \
    && ln -s /ajenti/etc/openvpn /etc/openvpn \

    && mv /etc/fail2ban /ajenti-start/etc/fail2ban \
    && rm -rf /etc/fail2ban \
    && ln -s /ajenti/etc/fail2ban /etc/fail2ban \

    && mv /etc/ajenti /ajenti-start/etc/ajenti \
    && rm -rf /etc/ajenti \
    && ln -s /ajenti/etc/ajenti /etc/ajenti \

    && mv /etc/mysql   /ajenti-start/etc/mysql \
    && rm -rf /etc/mysql \
    && ln -s /ajenti/etc/mysql /etc/mysql \

    && mv /var/lib/mysql /ajenti-start/var/lib/mysql \
    && rm -rf /var/lib/mysql \
    && ln -s /ajenti/var/lib/mysql /var/lib/mysql \
    
    && mv /etc/postgresql   /ajenti-start/etc/postgresql \
    && rm -rf /etc/postgresql \
    && ln -s /ajenti/etc/postgresql /etc/postgresql \
    
    && mv /var/lib/postgresql /ajenti-start/var/lib/postgresql \
    && rm -rf /var/lib/postgresql \
    && ln -s /ajenti/var/lib/postgresql /var/lib/postgresql \

    && mv /root /ajenti-start/root \
    && rm -rf /root \
    && ln -s /ajenti/root /root \

    && mv /var/lib/ajenti /ajenti-start/var/lib/ajenti \
    && rm -rf /var/lib/ajenti \
    && ln -s /ajenti/var/lib/ajenti /var/lib/ajenti \

    && mv /etc/memcached.conf /ajenti-start/etc/memcached.conf \
    && rm -rf /etc/memcached.conf \
    && ln -s /ajenti/etc/memcached.conf /etc/memcached.conf \

    && mv /etc/timezone /ajenti-start/etc/timezone \
    && rm -rf /etc/timezone \
    && ln -s /ajenti/etc/timezone /etc/timezone \

    && mv /etc/bind /ajenti-start/etc/bind \
    && rm -rf /etc/bind \
    && ln -s /ajenti/etc/bind /etc/bind \

    && mv /etc/profile /ajenti-start/etc/profile \
    && rm -rf /etc/profile \
    && ln -s /ajenti/etc/profile /etc/profile \

    && mv /var/log /ajenti-start/var/log \
    && rm -rf /var/log \
    && ln -s /ajenti/var/log /var/log \

    && mv /etc/mongod.conf /ajenti-start/etc/mongod.conf \
    && rm -rf /etc/mongod.conf \
    && ln -s /ajenti/etc/mongod.conf /etc/mongod.conf \

    && mv /etc/couchdb /ajenti-start/etc/couchdb \
    && rm -rf /etc/couchdb \
    && ln -s /ajenti/etc/couchdb /etc/couchdb \

    && mv /var/lib/couchdb /ajenti-start/var/lib/couchdb \
    && rm -rf /var/lib/couchdb \
    && ln -s /ajenti/var/lib/couchdb /var/lib/couchdb \
    
# pagespeed stuff
    && mkdir -p /var/ngx_pagespeed_cache \
    && chmod 755 /var/ngx_pagespeed_cache \
    && chown www-data:www-data /var/ngx_pagespeed_cache \

# finish cleaning up
    && rm -rf /backup/.etc \
    && rm -rf /tmp/* \
    && apt-get -yf autoremove \
    && apt-get clean 

VOLUME ["/backup", "/home", "/ajenti"]

EXPOSE 22 25 53 54 80 110 143 443 465 587 993 995 1194 3000 3306 5432 5984 6379 8000 8001 10022 11211 27017
