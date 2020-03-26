FROM ubuntu:16.04

ENV TZ=Asia/Seoul
ENV DEBIAN_FRONTEND=noninteractive
ENV MYSQL_DATA_DIR=/var/lib/mysql
ENV MYSQL_PID_DIR=/var/run/mysqld
ENV MYSQL_ROOT_PASSWORD=secret
ENV APACHE_ENVVARS=/etc/apache2/envvars
ENV APP_DIR=/var/www/html

#-------------------------------------------------------------------------------
# Install Packages
#-------------------------------------------------------------------------------

RUN { \
    echo mysql-community-server mysql-community-server/data-dir select ''; \
    echo mysql-community-server mysql-community-server/root-pass password ''; \
    echo mysql-community-server mysql-community-server/re-root-pass password ''; \
    echo mysql-community-server mysql-community-server/remove-test-db select false; \
} | debconf-set-selections

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        curl \
        wget \
        ca-certificates \
        cron \
        git \
        supervisor \
        apache2 \
        php \
        php-cli \
        php-curl \
        php-gd \
        php-gmp \
        php-intl \
        php-mbstring \
        php-mcrypt \
        php-mysql \
        php-sqlite3 \
        php-xdebug \
        php-xml \
        libapache2-mod-php \
        mysql-server \
        mysql-client \
        redis-server \
        vim \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#-------------------------------------------------------------------------------
# Timezone Setting
#-------------------------------------------------------------------------------

RUN echo $TZ | tee /etc/timezone \
    && dpkg-reconfigure --frontend noninteractive tzdata

#-------------------------------------------------------------------------------
# Copy Settings
#-------------------------------------------------------------------------------

RUN mkdir -p /var/redis /var/log/redis
COPY dockerfiles /

#-------------------------------------------------------------------------------
# Configure MySQL
#-------------------------------------------------------------------------------

RUN sed -i "s/user[\t ]*=.*/user=root/g" /etc/mysql/debian.cnf \
    && sed -i "s/password[\t ]*=.*/password=/g" /etc/mysql/debian.cnf

#-------------------------------------------------------------------------------
# Configure Apache
#-------------------------------------------------------------------------------

# @see https://github.com/docker-library/php/blob/e573f8f7fda5d7378bae9c6a936a298b850c4076/7.0/apache/Dockerfile#L38
RUN sed -ri 's/^export ([^=]+)=(.*)$/: ${\1:=\2}\nexport \1/' "$APACHE_ENVVARS" \
    && . "$APACHE_ENVVARS" \
    && for dir in \
        "$APACHE_LOCK_DIR" \
        "$APACHE_RUN_DIR" \
        "$APACHE_LOG_DIR" \
        "$APP_DIR" \
    ; do \
        rm -rvf "$dir" \
            && mkdir -p "$dir" \
            && chown -R "$APACHE_RUN_USER:$APACHE_RUN_GROUP" "$dir"; \
    done

RUN a2dissite 000-default \
    && a2ensite default \
    && a2enmod rewrite deflate headers \
    && service apache2 restart

#-------------------------------------------------------------------------------
# Install Cron Job
#-------------------------------------------------------------------------------

# 앱 폴더를 마운트하므로 빌드할 때 .env 파일을 읽을 수 없습니다.
#RUN source "$APP_DIR/.env" \
#    && if [ "$CRON_WORK" = "true" ]; then crontab /root/crontab; fi;

RUN crontab /root/crontab

#-------------------------------------------------------------------------------
# Run Environment
#-------------------------------------------------------------------------------

VOLUME ["$APP_DIR", "$MYSQL_DATA_DIR"]
EXPOSE 80 9001 3306 6379 1000
WORKDIR "$APP_DIR"
RUN /bin/bash /init_mysql.sh
RUN /bin/bash /refresh_mysql_pid.sh
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]