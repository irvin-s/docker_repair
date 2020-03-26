FROM phusion/baseimage:0.9.16
MAINTAINER y_hokkey github.com/hokkey
# an original dockerfile is by michael-harris github.com/michael-harris/resourcespace-docker

# Set correct environment variables.
ENV HOME /root

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update System
RUN \
  apt-get update \
  && apt-get -y upgrade \
  && apt-get -y install \
      apache2 php5 php5-dev php5-gd php5-mysql php5-ldap php5-imap subversion vim imagemagick \
      ghostscript antiword xpdf mysql-client libav-tools postfix \
      libimage-exiftool-perl wget zip \
  && apt-get clean \
  && rm -r /var/lib/apt/lists/*

# Install locales
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen cs_CZ.UTF-8 \
    && locale-gen de_DE.UTF-8 \
    && locale-gen es_ES.UTF-8 \
    && locale-gen fr_FR.UTF-8 \
    && locale-gen it_IT.UTF-8 \
    && locale-gen pl_PL.UTF-8 \
    && locale-gen pt_BR.UTF-8 \
    && locale-gen ru_RU.UTF-8 \
    && locale-gen sl_SI.UTF-8 \
    && locale-gen uk_UA.UTF-8

# Enable apache mods.
RUN a2enmod php5 && a2enmod rewrite && php5enmod imap

# Modify apache2.conf
RUN sed -i -e 's/Options Indexes FollowSymLinks/Options -Indexes +FollowSymLinks/g' /etc/apache2/apache2.conf

# Modify php.ini
RUN sed -i -e 's/upload_max_filesize\s*=\s*2M/upload_max_filesize = 1G/g' \
        -e 's/post_max_size\s*=\s*8M/post_max_size = 1G/g' \
        -e 's/max_execution_time\s*=\s*30/max_execution_time = 1000/g' \
        -e 's/memory_limit\s*=\s*128M/memory_limit = 1G/g' \
        /etc/php5/apache2/php.ini

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV RS_REVISION 7009

# Base URL
ENV BASE_URL //localhost/resourcespace

# MYSQL settings
ENV MYSQL_USER_NAME root
ENV MYSQL_PASSWORD yourpassword
ENV MYSQL_DB resourcespace

# SMTP settings
ENV USE_SMTP false
ENV SMTP_SECURE tls
ENV SMTP_HOST smtp.gmail.com
ENV SMTP_PORT 465
ENV SMTP_AUTH true
ENV SMTP_USERNAME yourname@gmail.com
ENV SMTP_PASSWORD yourpassword

# Add to Startup Items
RUN mkdir /etc/service/apache2
COPY conf/apache2.sh /etc/service/apache2/run
RUN chmod a+x /etc/service/apache2/run

# Add cron
COPY conf/resourcespace.sh /etc/cron.daily/resourcespace.sh
RUN chmod a+x /etc/cron.daily/resourcespace.sh

# Setup ResourceSpace
WORKDIR /var/www/html/

RUN \
  svn checkout -r $RS_REVISION http://svn.montala.net/svn/resourcespace resourcespace

WORKDIR resourcespace

# change permissions and replace Japanese words
RUN \
  mkdir filestore \
  && chown www-data:www-data -R filestore \
  && chown www-data:www-data -R plugins \
  && chown www-data:www-data -R gfx/homeanim \
  && chown www-data:www-data -R include \
  && sed -i -e 's/Log Out/ログアウト/g' \
         -e 's/ヘルプ助言/ヘルプ/g' \
         -e 's/チームセンター/サーバ設定/g' \
         -e 's/背景色/デザイン/g' \
         -e 's/簡単検索/検索/g' \
         -e 's/クリアー/クリア/g' \
         -e 's/国の指定/地域/g' \
         -e 's/日付指定/日付/g' \
         -e 's/結果表示/結果を表示/g' \
         -e 's/per page/表示件数/g' \
         -e 's/検索保存/保存された検索条件/g' \
         -e 's/画像のプレビュー/画像プレビュー/g' \
         -e 's/最善のリソース/ベストリソース/g' \
         -e 's/pixels/ピクセル/g' \
         languages/jp.php

COPY conf/rs-config.php include/config.php
VOLUME /var/www/resourcespace/filestore

EXPOSE 80
