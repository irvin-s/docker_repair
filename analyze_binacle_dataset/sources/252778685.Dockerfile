# This docker file is for the automated build on docker hub  
FROM ubuntu:16.04  
  
LABEL maintainer="e_ben_75-python@yahoo.com" \  
description="This is a Observium Server" \  
package-name="observium" \  
image-version="1.0"  
  
RUN apt-get update \  
&& apt-get install -y libapache2-mod-php7.0 \  
php7.0-cli \  
php7.0-mysql \  
php7.0-mysqli \  
php7.0-gd \  
php7.0-mcrypt \  
php7.0-json \  
php-pear \  
snmp \  
fping \  
mysql-client \  
python-mysqldb \  
rrdtool \  
subversion \  
whois \  
mtr-tiny \  
ipmitool \  
graphviz \  
imagemagick \  
apache2 \  
cron \  
nano \  
rsyslog \  
net-tools \  
&& apt-get clean \  
&& mkdir -p /opt/observium \  
&& mkdir /opt/observium/logs \  
&& mkdir /opt/observium/rrd  
  
COPY ./rsyslog.conf /etc/  
COPY ./30-observium.conf /etc/rsyslog.d/  
COPY ./50-default.conf /etc/rsyslog.d/  
COPY ./observium-community-latest.tar.gz /opt/  
COPY ./config.php /opt/observium/  
COPY ./observium.conf /etc/apache2/sites-available/  
COPY ./root-cron /var/spool/cron/crontabs/root  
COPY ./observium_startup /bin/  
  
WORKDIR /opt  
  
RUN tar zxvf observium-community-latest.tar.gz \  
&& a2dissite 000-default.conf \  
&& a2ensite observium.conf \  
&& phpenmod mcrypt \  
&& a2dismod mpm_event \  
&& a2enmod mpm_prefork \  
&& a2enmod php7.0 \  
&& a2enmod rewrite \  
&& chmod 600 /var/spool/cron/crontabs/root  
  
EXPOSE 80 443 514/udp 161/udp 162/udp 69/udp  
  
ENTRYPOINT ["observium_startup"]  

