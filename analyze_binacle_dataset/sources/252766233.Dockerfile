FROM debian:jessie  
MAINTAINER Amit Barik (Original author: Gabriel Wicke <gwicke@wikimedia.org>)  
  
# Waiting in antiticipation for built-time arguments  
# https://github.com/docker/docker/issues/14634  
ENV MEDIAWIKI_VERSION REL1_28  
  
# XXX: Consider switching to nginx.  
RUN set -x; \  
apt-get update \  
&& apt-get install -y --no-install-recommends \  
ca-certificates \  
apache2 \  
libapache2-mod-php5 \  
php5-mysql \  
php5-cli \  
php5-gd \  
php5-curl \  
imagemagick \  
netcat \  
git \  
&& rm -rf /var/lib/apt/lists/* \  
&& rm -rf /var/cache/apt/archives/* \  
&& a2enmod rewrite \  
&& a2enmod proxy \  
&& a2enmod proxy_http \  
# Remove the default Debian index page.  
&& rm /var/www/html/index.html  
  
  
# MediaWiki setup  
## https://www.mediawiki.org/wiki/Download_from_Git#Fetch_external_libraries  
RUN set -x; \  
mkdir -p /usr/src \  
&& git clone \  
\--depth 1 \  
-b $MEDIAWIKI_VERSION \  
https://gerrit.wikimedia.org/r/p/mediawiki/core.git \  
/usr/src/mediawiki \  
&& rm -rf /usr/src/mediawiki/extensions \  
&& rm -rf /usr/src/mediawiki/skins \  
&& rm -rf /usr/src/mediawiki/vendor \  
&& git clone \  
\--depth 1 \  
-b $MEDIAWIKI_VERSION \  
https://gerrit.wikimedia.org/r/p/mediawiki/extensions.git \  
/usr/src/mediawiki/extensions \  
&& git clone \  
\--depth 1 \  
-b $MEDIAWIKI_VERSION \  
https://gerrit.wikimedia.org/r/p/mediawiki/skins.git \  
/usr/src/mediawiki/skins \  
&& git clone \  
\--depth 1 \  
-b $MEDIAWIKI_VERSION \  
https://gerrit.wikimedia.org/r/p/mediawiki/vendor.git \  
/usr/src/mediawiki/vendor \  
&& cd /usr/src/mediawiki/extensions \  
&& git submodule update --init VisualEditor \  
&& cd VisualEditor \  
&& git checkout $MEDIAWIKI_VERSION \  
&& git submodule update --init \  
&& cd /usr/src/mediawiki/skins \  
&& git submodule update --init Vector \  
&& cd Vector \  
&& git checkout $MEDIAWIKI_VERSION  
#&& cd /usr/src/mediawiki/vendor \  
#&& git submodule update --init --recursive \  
#&& cd /usr/src/mediawiki/skins \  
#&& git submodule update --init --recursive \  
COPY php.ini /usr/local/etc/php/conf.d/mediawiki.ini  
  
COPY apache/mediawiki.conf /etc/apache2/  
RUN echo "Include /etc/apache2/mediawiki.conf" >> /etc/apache2/apache2.conf  
  
COPY docker-entrypoint.sh /entrypoint.sh  
  
EXPOSE 80 443  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["apachectl", "-e", "info", "-D", "FOREGROUND"]  

