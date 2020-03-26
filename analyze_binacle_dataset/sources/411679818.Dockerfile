FROM gzevd/alpine:3.8

# persistent / runtime deps
ENV PHPIZE_DEPS \
  autoconf \
  dpkg-dev dpkg \
  file \
  g++ \
  gcc \
  libc-dev \
  make \
  pkgconf \
  re2c

RUN apk add --no-cache --virtual .persistent-deps \
  ca-certificates \
  curl \
  apache2 \
  apache2-utils \
  xz \
# https://github.com/docker-library/php/issues/494
  libressl \
  openssh-client \
  mysql-client

RUN set -xe; \
  mkdir -p /run/apache2/ \
  && sed -i 's/^#ServerName.*/ServerName localhost/' /etc/apache2/httpd.conf \
  && sed -i 's/^#LoadModule rewrite_module/LoadModule rewrite_module/' /etc/apache2/httpd.conf \
  && sed -i 's/^Listen 80/Listen 0.0.0.0:80/' /etc/apache2/httpd.conf \
  && ln -sf /dev/stdout /var/log/apache2/access.log \
  && ln -sf /dev/stderr /var/log/apache2/error.log

ENV PHP_INI_DIR /usr/local/etc/php
RUN mkdir -p $PHP_INI_DIR/conf.d

# Apply stack smash protection to functions using local buffers and alloca()
# Make PHP's main executable position-independent (improves ASLR security mechanism, and has no performance impact on x86_64)
# Enable optimization (-O2)
# Enable linker optimization (this sorts the hash buckets to improve cache locality, and is non-default)
# Adds GNU HASH segments to generated executables (this is used if present, and is much faster than sysv hash; in this configuration, sysv hash is also generated)
# https://github.com/docker-library/php/issues/272
ENV PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2"
ENV PHP_CPPFLAGS="$PHP_CFLAGS"
ENV PHP_LDFLAGS="-Wl,-O1 -Wl,--hash-style=both -pie"

ENV GPG_KEYS 1729F83938DA44E27BA0F4D3DBDB397470D12172 B1B44D8F021E4E2D6021E995DC9FF8D3EE5AF27F

ENV PHP_VERSION 7.2.19
ENV PHP_URL="https://secure.php.net/get/php-$PHP_VERSION.tar.xz/from/this/mirror" PHP_ASC_URL="https://secure.php.net/get/php-$PHP_VERSION.tar.xz.asc/from/this/mirror"
ENV PHP_SHA256="4ffa2404a88d60e993a9fe69f829ebec3eb1e006de41b6048ce5e91bbeaa9282"

RUN set -xe; \
  apk add --no-cache --virtual .fetch-deps \
  gnupg \
  wget \
  ; \
  \
  mkdir -p /usr/src; \
  cd /usr/src; \
  \
  wget -O php.tar.xz "$PHP_URL"; \
  \
  if [ -n "$PHP_SHA256" ]; then \
    echo "$PHP_SHA256 *php.tar.xz" | sha256sum -c -; \
  fi; \
  \
  if [ -n "$PHP_ASC_URL" ]; then \
    wget -O php.tar.xz.asc "$PHP_ASC_URL"; \
    export GNUPGHOME="$(mktemp -d)"; \
    for key in $GPG_KEYS; do \
      gpg --keyserver pgp.mit.edu --recv-keys "$key" || \
      gpg --keyserver keyserver.pgp.com --recv-keys "$key" || \
      gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key" ; \
    done; \
    gpg --batch --verify php.tar.xz.asc php.tar.xz; \
    rm -rf "$GNUPGHOME"; \
  fi; \
  \
  apk del .fetch-deps

COPY docker-php-source /usr/local/bin/

RUN set -xe \
  && apk add --no-cache --virtual .build-deps \
    $PHPIZE_DEPS \
    curl-dev \
    libedit-dev \
    libxml2-dev \
    libressl-dev \
    apache2-dev \
    freetype-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libsodium-dev \
  \
  && export CFLAGS="$PHP_CFLAGS" \
    CPPFLAGS="$PHP_CPPFLAGS" \
    LDFLAGS="$PHP_LDFLAGS" \
  && docker-php-source extract \
  && cd /usr/src/php \
  && gnuArch="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)" \
  && ./configure \
    --build="$gnuArch" \
    --sysconfdir="$PHP_INI_DIR" \
    --with-layout=GNU \
    --with-config-file-path="$PHP_INI_DIR" \
    --with-config-file-scan-dir="$PHP_INI_DIR/conf.d" \
    \
# make sure invalid --configure-flags are fatal errors intead of just warnings
    --enable-option-checking=fatal \
    --with-apxs2=/usr/bin/apxs \
    \
    --disable-rpath \
    --disable-debug \
    --disable-static \
    --disable-embed \
    --disable-cgi \
    --without-db1 \
    --without-db2 \
    --without-db3 \
    --without-db4 \
    --without-qdbm \
    --without-pdo_sqlite \
    --without-sqlite3 \
    \
# --enable-ftp is included here because ftp_ssl_connect() needs ftp to be compiled statically (see https://github.com/docker-library/php/issues/236)
    --enable-ftp \
# --enable-mbstring is included here because otherwise there's no way to get pecl to use it properly (see https://github.com/docker-library/php/issues/195)
  --enable-mbstring \
# --enable-mysqlnd is included here because it's harder to compile after the fact than extensions are (since it's a plugin for several extensions, not an extension in itself)
  --enable-mysqlnd \
  --enable-pdo \
  --enable-zip \
  --enable-opcache \
    \
    # https://wiki.php.net/rfc/libsodium
    --with-sodium=shared \
    --with-curl \
    --with-libedit \
    --with-openssl \
    --with-zlib \
    --with-gd \
    --with-freetype-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/ \
    --with-png-dir=/usr/include/ \
    --with-pdo-mysql=mysqlnd \
    \
    # bundled pcre does not support JIT on s390x
    # https://manpages.debian.org/stretch/libpcre3-dev/pcrejit.3.en.html#AVAILABILITY_OF_JIT_SUPPORT
    $(test "$gnuArch" = 's390x-linux-gnu' && echo '--without-pcre-jit') \
    \
  && make -j "$(nproc)" \
  && make install \
  # Copy default php.ini and configure it
  && cp php.ini-production $PHP_INI_DIR/php.ini \
  && { find /usr/local/bin /usr/local/sbin -type f -perm +0111 -exec strip --strip-all '{}' + || true; } \
  && make clean \
  && docker-php-source delete \
  \
  && runDeps="$( \
    scanelf --needed --nobanner --recursive /usr/local \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u \
      | xargs -r apk info --installed \
      | sort -u \
  )" \
  && apk add --no-cache --virtual .php-rundeps $runDeps \
  \
  && apk del .build-deps \
  \
# https://github.com/docker-library/php/issues/443
&& pecl update-channels \
&& rm -rf /tmp/pear ~/.pearrc \
&& sed -i 's,lib/apache2/libphp7.so,modules/libphp7.so,' /etc/apache2/httpd.conf

ENV MEMCACHED_DEPS zlib-dev libmemcached-dev cyrus-sasl-dev
RUN set -xe; \
  apk add --no-cache --update \
  libmemcached-libs \
  zlib
RUN set -xe; \
  apk add --no-cache --update --virtual .phpize-deps $PHPIZE_DEPS \
  && apk add --no-cache --update --virtual .memcached-deps $MEMCACHED_DEPS \
  && pecl install memcached \
  && echo "extension=memcached.so" > $PHP_INI_DIR/conf.d/20_memcached.ini \
  && rm -rf /usr/share/php7 \
  && rm -rf /tmp/* \
  && apk del .memcached-deps .phpize-deps

COPY docker-php-ext-* docker-php-entrypoint /usr/local/bin/

# sodium was built as a shared module (so that it can be replaced later if so desired), so let's enable it too (https://github.com/docker-library/php/issues/598)
RUN docker-php-ext-enable opcache sodium

COPY override_php.ini $PHP_INI_DIR/conf.d/

COPY apache2-foreground /usr/local/bin/
COPY php-module.conf /etc/apache2/conf.d/

WORKDIR /var/www/localhost/htdocs

EXPOSE 80
ENTRYPOINT ["docker-php-entrypoint"]
CMD ["apache2-foreground"]
