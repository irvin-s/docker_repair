FROM phusion/baseimage:0.9.15
MAINTAINER Brian Prodoehl <bprodoehl@connectify.me>

ENV HOME /root
CMD ["/sbin/my_init"]
EXPOSE 80 443

# 0.9.15 is getting a bit long in the tooth, so lets grab security fixes
RUN apt-get update && apt-get -y dist-upgrade

RUN echo "deb http://ppa.launchpad.net/nginx/development/ubuntu $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/nginx-development.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C300EE8C
RUN add-apt-repository universe && add-apt-repository multiverse
RUN apt-get update -q && \
    apt-get install -qy mysql-client nginx php5-cli php5-gd php5-fpm php5-json \
                        php5-mysql php5-curl wget && \
    apt-get clean

RUN mkdir /etc/service/nginx
ADD runit/nginx.sh /etc/service/nginx/run

RUN mkdir /etc/service/php5-fpm
ADD runit/php5-fpm.sh /etc/service/php5-fpm/run

ADD config/nginx.conf /etc/nginx/nginx.conf
ADD config/nginx-default.conf /etc/nginx/sites-available/default
ADD config/php.ini /etc/php5/fpm/php.ini

RUN cd /usr/share/nginx/html && \
    export PIWIK_VERSION=2.14.3 && \
    wget http://builds.piwik.org/piwik-${PIWIK_VERSION}.tar.gz && \
    tar -xzf piwik-${PIWIK_VERSION}.tar.gz && \
    rm piwik-${PIWIK_VERSION}.tar.gz && \
    mv piwik/* . && \
    rm -r piwik && \
    chown -R www-data:www-data /usr/share/nginx/html && \
    chmod 0770 /usr/share/nginx/html/tmp && \
    chmod 0770 /usr/share/nginx/html/config && \
    chmod 0600 /usr/share/nginx/html/config/* && \
    rm /usr/share/nginx/html/index.html

# Install MaxMind GeoCity Lite database
RUN cd /usr/share/nginx/html/misc && \
    wget http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz && \
    gunzip GeoLiteCity.dat.gz && \
    chown www-data:www-data GeoLiteCity.dat && \
	mv GeoLiteCity.dat GeoIPCity.dat

ADD config/piwik-schema.sql /usr/share/nginx/html/config/base-schema.sql

ADD scripts/generate-certs.sh /etc/my_init.d/05-certs.sh
ADD scripts/init-piwik.sh /etc/my_init.d/10-piwik.sh

RUN touch /etc/service/sshd/down
