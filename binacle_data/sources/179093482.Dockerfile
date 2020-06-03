FROM debian:wheezy

ENV DEBIAN_FRONTEND noninteractive

# Update the package repository
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget curl locales

# Configure timezone and locale
RUN echo "Europe/Madrid" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN export LANGUAGE=es_ES.UTF-8 && export LANG=es_ES.UTF-8 && export LC_ALL=es_ES.UTF-8 && locale-gen en_US.UTF-8 && dpkg-reconfigure locales

RUN echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.org.list
RUN echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list.d/dotdeb.org.list

RUN echo "deb http://packages.dotdeb.org wheezy-php56 all" >> /etc/apt/sources.list.d/dotdeb.org.list
RUN echo "deb-src http://packages.dotdeb.org wheezy-php56 all" >> /etc/apt/sources.list.d/dotdeb.org.list

RUN wget -O- http://www.dotdeb.org/dotdeb.gpg | apt-key add -

RUN apt-get clean
RUN apt-get update

RUN apt-get install -y sudo gettext php5-fpm

COPY www.ini.conf /etc/php5/fpm/pool.d/www.conf
RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" /etc/php5/fpm/php.ini
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

# Redirect error logging to /dev/stderr
RUN ln -sf /dev/stderr /var/log/php5-fpm.log

EXPOSE 9000
CMD ["/usr/sbin/php5-fpm"]