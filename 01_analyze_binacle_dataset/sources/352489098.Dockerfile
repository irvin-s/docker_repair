FROM ubuntu:latest

RUN apt-get update
RUN apt-get -y install apache2 libapache2-mod-php5 php5-mysql php5-intl php5-curl curl

RUN a2enmod php5
RUN a2enmod rewrite

ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

EXPOSE 80

CMD /usr/sbin/apache2ctl -D FOREGROUND
