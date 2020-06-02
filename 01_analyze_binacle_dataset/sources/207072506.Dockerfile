FROM unocha/base-php7:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

# A little bit of metadata management.
# See http://label-schema.org/
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.name="base-php-nr" \
      org.label-schema.description="This service provides a base php-fpm platform with NewRelic." \
      org.label-schema.architecture="x86_64" \
      org.label-schema.distribution="Alpine Linux" \
      org.label-schema.distribution-version="3.9" \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm gd gettext iconv imagick json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm"

ENV NR_VERSION php5-8.7.0.242-linux-musl

ENV PHP_NEWRELIC_LICENSE="" \
    PHP_NEWRELIC_APPNAME=""

COPY run_newrelic etc/php7/conf.d/10_newrelic.ini /

RUN curl -s -o /tmp/newrelic.tar.gz \
      https://download.newrelic.com/php_agent/release/newrelic-$NR_VERSION.tar.gz && \
    mkdir -p /etc/newrelic /var/log/newrelic && \
    tar xvf /tmp/newrelic.tar.gz -C /tmp && \
    mv /tmp/newrelic-$NR_VERSION/daemon/newrelic-daemon.x64 \
       /usr/bin/newrelic-daemon && \
    mv /tmp/newrelic-$NR_VERSION/agent/x64/newrelic-$(php --info | awk '/^PHP API/ {print $NF}').so \
       /usr/lib/php7/modules/newrelic.so && \
    mv /tmp/newrelic-$NR_VERSION/scripts/newrelic.cfg.template \
       /etc/newrelic/newrelic.cfg && \
    rm -rf /tmp/newrelic-php5-$NR_VERSION /tmp/newrelic.tar.gz && \
    rm -f /etc/php7/conf.d/newrelic.ini && \
    mkdir -p /etc/services.d/newrelic && \
    mv /run_newrelic /etc/services.d/newrelic/run && \
    mv /10_newrelic.ini /etc/php7/conf.d/10_newrelic.ini
