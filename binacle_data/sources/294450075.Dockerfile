FROM php:7.2.8-fpm-alpine3.7

LABEL maintainer="nICKZHUO <sidewindermax@hotmail.com>"

ENV php_conf /usr/local/etc/php-fpm.conf
ENV fpm_conf /usr/local/etc/php-fpm.d/www.conf
ENV php_vars /usr/local/etc/php/conf.d/docker-vars.ini

# Nginx版本
ENV NGINX_VERSION 1.15.2

ENV LD_PRELOAD /usr/lib/preloadable_libiconv.so php
RUN apk add --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing gnu-libiconv

RUN addgroup -S www \
  && adduser -D -S -h /var/cache/www -s /sbin/nologin -G www www \ 
  && apk add --no-cache --virtual .build-deps \
    autoconf \
    gcc \
    vim \
    git \
    libc-dev \
    make \
    openssl-dev \
    pcre-dev \
    zlib-dev \
    linux-headers \
    curl \
    gnupg \
    libxslt-dev \
    gd-dev \
    geoip-dev \
    perl-dev
  
  RUN curl -fSL http://nginx.org/download/nginx-$NGINX_VERSION.tar.gz -o nginx.tar.gz \
    && mkdir -p /usr/src \
    && tar -zxC /usr/src -f nginx.tar.gz \
    && cd /usr/src/nginx-$NGINX_VERSION \
    && ./configure --prefix=/usr/local/nginx \
      --user=www --group=www \
      --error-log-path=/var/log/nginx_error.log \
      --http-log-path=/var/log/nginx_access.log \
      --pid-path=/var/run/nginx.pid \
      --with-pcre \
      --with-http_ssl_module \
      --without-mail_pop3_module \
      --without-mail_imap_module \
      --with-http_gzip_static_module && \
      make && make install

RUN echo @testing http://nl.alpinelinux.org/alpine/edge/testing >> /etc/apk/repositories && \
#    sed -i -e "s/v3.4/edge/" /etc/apk/repositories && \
    echo /etc/apk/respositories && \
    apk update && \
    apk add --no-cache bash \
    openssh-client \
    wget \
    supervisor \
    curl \
    libcurl \
    python \
    python-dev \
    py-pip \
    augeas-dev \
    openssl-dev \
    ca-certificates \
    dialog \
    autoconf \
    make \
    gcc \
    musl-dev \
    linux-headers \
    libmcrypt-dev \
    libpng-dev \
    icu-dev \
    libpq \
    libxslt-dev \
    libffi-dev \
    freetype-dev \
    sqlite-dev \
    libjpeg-turbo-dev

# 必须这样装mcrypt
RUN pecl install mcrypt-1.0.1 && \
    pecl install redis

# 跑GD要配置下
RUN docker-php-ext-configure gd \
      --with-gd \
      --with-freetype-dir=/usr/include/ \
      --with-png-dir=/usr/include/ \
      --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install pdo_mysql mysqli gd exif fileinfo intl json opcache

RUN docker-php-ext-enable redis.so && \
  docker-php-ext-enable mcrypt.so && \
  docker-php-source delete

# 安装composer    
RUN EXPECTED_COMPOSER_SIGNATURE=$(wget -q -O - https://composer.github.io/installer.sig) && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '${EXPECTED_COMPOSER_SIGNATURE}') { echo 'Composer.phar Installer verified'; } else { echo 'Composer.phar Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

# 安装pip相关    
RUN pip install -U pip && \
    pip install -U certbot && \
    mkdir -p /etc/letsencrypt/webrootauth && \
    apk del gcc musl-dev linux-headers libffi-dev augeas-dev python-dev make autoconf

# supervisor的配置文件复制过去
# supervisor配置文件
ADD ./conf/supervisord/supervisord.conf /etc/
# 分解的supervisor配置
RUN mkdir -p /etc/supervisor/
ADD ./conf/supervisord/php-fpm.conf /etc/supervisor/
ADD ./conf/supervisord/nginx.conf /etc/supervisor/

# nginx配置文件 symfony放在site里 注意路径是 /usr/local/nginx/conf/
COPY ./conf/nginx/nginx.conf /usr/local/nginx/conf/
COPY ./conf/nginx/symfony.conf /usr/local/nginx/conf/vhost/

# 优化 php-fpm 配置
RUN echo "cgi.fix_pathinfo=0" > ${php_vars} &&\
    echo "upload_max_filesize = 100M"  >> ${php_vars} &&\
    echo "post_max_size = 100M"  >> ${php_vars} &&\
    echo "variables_order = \"EGPCS\""  >> ${php_vars} && \
    echo "memory_limit = 128M"  >> ${php_vars} && \
    echo "date.timezone =  Asia/Shanghai"  >> ${php_vars}
    
RUN sed -i \
    -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" \
    -e "s/pm.max_children = 5/pm.max_children = 4/g" \
    -e "s/pm.start_servers = 2/pm.start_servers = 3/g" \
    -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" \
    -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" \
    -e "s/;pm.max_requests = 500/pm.max_requests = 200/g" \
    -e "s/user = www-data/user = www/g" \
    -e "s/group = www-data/group = www/g" \
    -e "s/;listen.mode = 0660/listen.mode = 0666/g" \
    -e "s/;listen.owner = www-data/listen.owner = www/g" \
    -e "s/;listen.group = www-data/listen.group = www/g" \
    -e "s/listen = 127.0.0.1:9000/listen = \/dev\/shm\/php-fpm.sock/g" \
    -e "s/^;clear_env = no$/clear_env = no/" \
    ${fpm_conf}

# 挂载代码文件到容器
COPY ./code/index.php /data/www/public/

# 添加启动脚本
ADD scripts/start.sh /start.sh
RUN chmod 755 /start.sh

EXPOSE 80

CMD ["/start.sh"]