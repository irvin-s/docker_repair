FROM      ubuntu:14.04
MAINTAINER Matt Webb "mattrw89@gmail.com"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive

RUN locale-gen $LANG; echo "LANG=\"${LANG}\"" > /etc/default/locale; dpkg-reconfigure locales

RUN apt-get update;
RUN apt-get install -y wget
RUN apt-get install -y apt-transport-https
RUN wget -O - https://repo.varnish-cache.org/ubuntu/GPG-key.txt | apt-key add -
RUN echo deb https://repo.varnish-cache.org/ubuntu/ trusty varnish-4.0 >> /etc/apt/sources.list.d/varnish-cache.list
RUN apt-get update
RUN apt-get install -y varnish
RUN apt-get install -y software-properties-common

RUN wget -O - http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add -
RUN echo deb http://dl.hhvm.com/ubuntu trusty main | tee /etc/apt/sources.list.d/hhvm.list
RUN echo deb http://archive.ubuntu.com/ubuntu trusty main universe | tee /etc/apt/sources.list
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update

RUN \
  apt-get install -y \
  hhvm-fastcgi \
  nginx \
  mysql-client

RUN adduser --disabled-login --gecos 'Wordpress' wordpress

VOLUME ['/home/wordpress']

ADD wordpress/wp_version_writer.py /home/wordpress/scripts/wp_version_writer.py
ADD wordpress/wp_version_checker.py /home/wordpress/scripts/wp_version_checker.py

RUN apt-get install -y python-dev
RUN mkdir /home/wordpress/builtin_wordpress; mkdir /home/wordpress/live_wordpress;
RUN cd /home/wordpress/builtin_wordpress; wget $(python ../scripts/wp_version_writer.py) -O latest.tar.gz; tar -xvzf latest.tar.gz; rm latest.tar.gz; mv wordpress/* .; rm -R wordpress

EXPOSE 9999 443 80

ENV NFILES 131072
ENV MEMLOCK 82000

ADD nginx/nginx.conf /etc/nginx/nginx.conf
ADD varnish/varnish4-wordpress /etc/varnish/default.vcl
ADD start.sh /start.sh
RUN chmod 755 /start.sh
ADD wordpress/wp-config.php /home/wordpress/_config/wp-config.php
ADD wordpress/production-config.php /home/wordpress/_config/production-config.php
RUN chown wordpress:wordpress /home/wordpress/_config/*.php
RUN chown wordpress:wordpress -R /home/wordpress/builtin_wordpress/*

RUN ls -la /home/wordpress/builtin_wordpress

CMD ["/start.sh"]
