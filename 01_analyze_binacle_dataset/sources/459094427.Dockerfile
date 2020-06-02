###
# Heroku Phalcon Docker
##

FROM heroku/cedar:14

RUN useradd -d /app -m app
USER app
RUN mkdir /app/build
RUN mkdir /app/src
WORKDIR /app/src

# Path
ENV HOME /app
ENV BUILD_HOME /app/build
ENV APACHE_ROOT ${HOME}/apache
ENV PHP_ROOT ${HOME}/php
ENV MCRYPT_ROOT ${HOME}/libs/libmcrypt
ENV PCRE_ROOT ${HOME}/libs/pcre
ENV MEMCACHED_ROOT ${HOME}/libs/libmemcached

# Version
ENV APACHE_VERSION 2.4.12
ENV PHP_VERSION 5.6.9
ENV LIBMCRYPT_VERSION 2.5.8
ENV APR_VERSION 1.5.2
ENV APR_UTIL_VERSION 1.5.4
ENV LIBPCRE_VERSION 8.37

# Download Url
ENV APACHE_URL http://www.us.apache.org/dist/httpd/httpd-${APACHE_VERSION}.tar.gz
ENV PHP_URL http://us.php.net/distributions/php-${PHP_VERSION}.tar.gz
ENV MCRYPT_URL http://downloads.sourceforge.net/project/mcrypt/Libmcrypt/${LIBMCRYPT_VERSION}/libmcrypt-${LIBMCRYPT_VERSION}.tar.gz
ENV APR_URL http://www.us.apache.org/dist/apr/apr-${APR_VERSION}.tar.gz
ENV APR_UTIL_URL http://www.us.apache.org/dist/apr/apr-util-${APR_UTIL_VERSION}.tar.gz
ENV PCRE_URL ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-${LIBPCRE_VERSION}.tar.gz
ENV COMPOSER_URL http://getcomposer.org/composer.phar

ENV PHALCON_REPO git://github.com/phalcon/cphalcon.git

# Dir
ENV APACHE_DIR httpd-${APACHE_VERSION}
ENV PHP_DIR php-${PHP_VERSION}
ENV MCRYPT_DIR libmcrypt-${LIBMCRYPT_VERSION}
ENV APR_DIR apr-${APR_VERSION}
ENV APR_UTIL_DIR apr-util-${APR_UTIL_VERSION}
ENV PCRE_DIR pcre-${LIBPCRE_VERSION}
ENV PHALCON_DIR cphalcon

ENV CURL_FLAGS --location --silent

ENV PATH $PATH:$PHP_ROOT/bin:$APACHE_ROOT/bin
ENV PORT 3000

# ========
# Building
# ========

RUN cd $BUILD_HOME && \
    # Download Source Code
    curl $CURL_FLAGS "$APACHE_URL" | tar zx && \
    curl $CURL_FLAGS "$APR_URL" | tar zx && \
    curl $CURL_FLAGS "$APR_UTIL_URL" | tar zx && \
    curl $CURL_FLAGS "$PCRE_URL" | tar zx && \
    curl $CURL_FLAGS "$PHP_URL" | tar zx && \
    curl $CURL_FLAGS "$MCRYPT_URL" | tar zx && \

    git clone -q --depth=1 $PHALCON_REPO && \

    # =====
    # Build
    # =====

    # PCRE
    cd $PCRE_DIR && \
    ./configure --prefix=$PCRE_ROOT && \
    make && make install && \
    cd $BUILD_HOME && \

    # Apache
    mv $APR_DIR $APACHE_DIR/srclib/apr && \
    mv $APR_UTIL_DIR $APACHE_DIR/srclib/apr-util && \
    cd $APACHE_DIR && \
    ./configure --prefix=$APACHE_ROOT --with-pcre=$PCRE_ROOT --enable-rewrite && \
    make && make install && \
    cd $BUILD_HOME && \

    # MCRYPT
    cd $MCRYPT_DIR && \
    #autoconf -W no-obsolete -W no-syntax && \
    #automake && \
    ./configure --prefix=$MCRYPT_ROOT && \
    make && make install && \
    cd $BUILD_HOME && \

    # PHP
    cd $PHP_DIR && \
    ./configure \
    --prefix=$PHP_ROOT \
    --with-config-file-path=$PHP_ROOT \
    --with-apxs2=$APACHE_ROOT/bin/apxs \
    --enable-opcache \
    --with-mysql \
    --with-pdo-mysql \
    --with-pgsql \
    --with-pdo-pgsql \
    --with-iconv \
    --with-gd \
    --with-curl \
    --enable-soap=shared \
    --with-openssl \
    --enable-mbstring \
    --with-curl \
    --with-mcrypt=$MCRYPT_ROOT \
    --with-jpeg-dir=/usr && \
    make && make install && \
    cp php.ini-production $PHP_ROOT/php.ini && \
    cd $BUILD_HOME && \

    # PEAR
    $PHP_ROOT/bin/pecl channel-update pecl.php.net && \

    # Extension
    # Auto use default prompt
    printf "\n" | pecl install mongo && \
    printf "\n" | pecl install redis && \

    # Phalcon
    cd $PHALCON_DIR/build && \
    ./install && \

    # =====
    # Clean
    # =====
    rm -rf $BUILD_HOME

# Configure
RUN sed -ire 's/^Listen.*$/Listen \${PORT}/g' $APACHE_ROOT/conf/httpd.conf && \
    sed -ire 's/^DocumentRoot.*$/DocumentRoot\ "\/app\/src"/g' $APACHE_ROOT/conf/httpd.conf && \
    sed -ire 's/<Directory "\/app\/apache\/htdocs">/<Directory "\/app\/src">/g' $APACHE_ROOT/conf/httpd.conf && \
    sed -ire 's/AllowOverride\ None/AllowOverride\ All/g' $APACHE_ROOT/conf/httpd.conf
RUN echo "<IfModule dir_module>\nDirectoryIndex index.html index.php\n</IfModule>" >> $APACHE_ROOT/conf/httpd.conf && \
    echo "<FilesMatch \.php$>\nSetHandler application/x-httpd-php\n</FilesMatch>" >> $APACHE_ROOT/conf/httpd.conf
RUN echo "zend_extension=opcache.so" >> $PHP_ROOT/php.ini && \
    echo "extension=phalcon.so" >> $PHP_ROOT/php.ini && \
    echo "extension=mongo.so" >> $PHP_ROOT/php.ini && \
    echo "extension=redis.so" >> $PHP_ROOT/php.ini

USER root
COPY ./ext/package.sh /app/package.sh
RUN chmod +x /app/package.sh

# Copy SourceCode
ONBUILD COPY . /app/src
ONBUILD USER root
ONBUILD RUN chown -R app /app
ONBUILD USER app

# Setup Dependency
ONBUILD RUN if [ -f /app/src/composer.json ]; then \
            curl --silent --max-time 60 --location "$COMPOSER_URL" > $HOME/src/composer.phar; \
            php $HOME/src/composer.phar install --prefer-dist; \
            rm $HOME/src/composer.phar; \
            fi

# Configure Profile
ONBUILD USER app
ONBUILD RUN mkdir -p /app/.profile.d
ONBUILD RUN echo "export PATH=\"$PATH:$PHP_ROOT/bin:$APACHE_ROOT/bin\"" > /app/.profile.d/php.sh
ONBUILD RUN echo "cd /app/src" >> /app/.profile.d/php.sh

ONBUILD EXPOSE 3000
