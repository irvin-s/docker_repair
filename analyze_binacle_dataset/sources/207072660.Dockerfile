FROM unocha/php7:%%UPSTREAM%%

MAINTAINER UN-OCHA Operations <ops+docker@humanitarianresponse.info>

# Thanks to orakili <docker@orakili.net>

# A little bit of metadata management.
ARG VERSION
ARG UPSTREAM
ARG VCS_URL
ARG VCS_REF
ARG BUILD_DATE

ENV NGINX_SERVERNAME=localhost \
    PAGER=more

LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vendor="UN-OCHA" \
      org.label-schema.version=$VERSION \
      org.label-schema.name="php7-k8s" \
      org.label-schema.description="This service provides an nginx / php-fpm platform with composer, drush and wp-cli." \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.vcs-ref=$VCS_REF \
      info.humanitarianresponse.nginx=$UPSTREAM \
      info.humanitarianresponse.php=$VERSION \
      info.humanitarianresponse.php.modules="bcmath bz2 calendar ctype curl dom exif fileinfo fpm ftp gd gettext iconv igbinary imagick imap intl json mcrypt memcached opcache openssl pdo pdo_mysql pdo_pgsql phar posix redis shmop soap sysvmsg sysvsem sysvshm simplexml sockets wddx xml xmlreader xmlwriter xsl zip zlib" \
      info.humanitarianresponse.php.sapi="fpm" \
      info.humanitarianresponse.composer="1.8.4" \
      info.humanitarianresponse.drush=$DRUSH_RELEASE \
      info.humanitarianresponse.wp=$WP_RELEASE

# Insert all our custom config files.
COPY etc/drush/drushrc.php \
       etc/php7/php-fpm.d/www.conf \
       etc/nginx/ etc/services.d/run_nginx \
     /tmp/

# Install NGINX for standard operation.
RUN \
    apk -U upgrade && \
    apk add -U nginx nginx-mod-http-upload-progress nginx-mod-http-lua && \
    mkdir -p /etc/services.d/nginx && \
    rm -rf /etc/nginx/* && \
    mv /tmp/apps /tmp/fastcgi.conf /tmp/koi-utf /tmp/map_block_http_methods.conf /tmp/mime.types /tmp/upstream_phpcgi_unix.conf \
       /tmp/blacklist.conf /tmp/fastcgi_params /tmp/koi-win /tmp/map_https_fcgi.conf /tmp/nginx.conf \
       /tmp/sites-enabled /tmp/win-utf \
         /etc/nginx && \
    mv /tmp/run_nginx /etc/services.d/nginx/run && \
    mkdir -p  /var/cache/nginx && \
    chown appuser:root /var/cache/nginx /var/tmp/nginx && \
    rm -rf /var/cache/apk/* && \
    \
    # Drop in our fpm pool config that uses a socket.
    mv /tmp/www.conf /etc/php7/php-fpm.d/www.conf && \
    \
    # Add our default drushrc.php file.
    mkdir -p /etc/drush && \
    mv /tmp/drushrc.php /etc/drush/drushrc.php && \
    # Cleanup.
    rm -rf /tmp/*

# Add a health check for the FPM server on port 9000.
HEALTHCHECK --interval=60s --timeout=5s \
        CMD REDIRECT_STATUS=true SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET cgi-fcgi -bind -connect /var/run/php-fpm7.sock

EXPOSE 80
