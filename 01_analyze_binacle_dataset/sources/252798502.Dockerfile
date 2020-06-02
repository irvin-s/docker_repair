#  
# Define base image and maintainer  
#  
FROM phusion/baseimage:0.9.15  
MAINTAINER Deny Dias <deny@macpress.com.br>  
  
#  
# Start baseimage-docker's init system  
#  
CMD ["/sbin/my_init"]  
  
#  
# Define Metadata  
#  
ARG BUILD_DATE  
ARG VCS_REF  
LABEL org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.docker.dockerfile="/Dockerfile" \  
org.label-schema.license="GPLv3" \  
org.label-schema.name="BYOD Baseimage" \  
org.label-schema.url="https://hub.docker.com/r/denydias/byod-baseimage/" \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.vcs-type="Git" \  
org.label-schema.vcs-url="https://github.com/denydias/byod-baseimage"  
#  
# Set default environment  
#  
ENV DEBIAN_FRONTEND=noninteractive \  
DEF_RUNAS_USER=www-data \  
DEF_RUNAS_UID=33 \  
DEF_RUNAS_GROUP=users \  
DEF_NGINX_MAX_WORKER_PROCESSES=8 \  
DEF_NGINX_UPLOAD_MAX_SIZE=50M \  
DEF_TIMEZONE="America/Sao_Paulo" \  
DEF_DR_RT=development \  
TERM=linux \  
WWW_DIR=/opt/drupal \  
TWIG_VER="1.24.0"  
#  
# Install nginx, php-fpm and extensions for Drupal  
#  
RUN add-apt-repository -y ppa:nginx/stable \  
&& apt-get update \  
&& apt-get upgrade -y  
RUN apt-get install -y --no-install-recommends \  
git \  
htop \  
make \  
mysql-client \  
nginx \  
php-pear \  
php5 \  
php5-cli \  
php5-fpm \  
php5-curl \  
php5-dev \  
php5-gd \  
php5-imagick \  
php5-imap \  
php5-intl \  
php5-mcrypt \  
php5-ming \  
php5-mysql \  
php5-ps \  
php5-pspell \  
php5-recode \  
php5-sqlite \  
php5-tidy \  
php5-xmlrpc \  
php5-xsl \  
pwgen \  
re2c \  
tree \  
wget \  
&& apt-get clean \  
&& pecl install uploadprogress \  
&& echo "extension=uploadprogress.so" > \  
/etc/php5/mods-available/uploadprogress.ini \  
&& php5enmod uploadprogress \  
&& wget -qO- https://github.com/twigphp/Twig/archive/v${TWIG_VER}.tar.gz \  
| tar xz -C /tmp/ \  
&& cd /tmp/Twig-${TWIG_VER}/ext/twig \  
&& phpize && ./configure && make && make install \  
&& echo "extension=twig.so" > /etc/php5/mods-available/twig.ini \  
&& php5enmod twig \  
&& rm -rf /etc/nginx \  
/var/lib/apt/lists/* \  
/tmp/* \  
/var/tmp/* \  
/tmp/Twig-${TWIG_VER} \  
&& mkdir -p /var/log/nginx \  
/var/cache/nginx  
  
#  
# Install Drush  
#  
RUN wget -q http://files.drush.org/drush.phar \  
&& chmod +x drush.phar \  
&& mv drush.phar /usr/local/bin/drush  
  
#  
# Install Drupal Console  
#  
RUN wget -q https://drupalconsole.com/installer -O drupal.phar \  
&& chmod +x drupal.phar \  
&& mv drupal.phar /usr/local/bin/drupal  
  
#  
# Copy and set permissions for configuration and initialization scripts  
#  
COPY etc /etc  
RUN chmod 750 /etc/my_init.d/*.sh \  
&& chmod 750 /etc/service/*/run  
  
#  
# Open ports  
#  
EXPOSE 80

