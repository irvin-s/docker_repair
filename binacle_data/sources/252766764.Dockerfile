# nagios  
#  
# VERSION 1.0  
FROM tozd/postfix  
MAINTAINER Andres F. Lamilla, "aflamillac@gmail.com"  
# se actualiza la base de datos de apt  
RUN apt-get update -qq  
  
# instalacion de los paquetes necesarios para la app  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y -q wget \  
build-essential \  
apache2 \  
apache2-utils \  
iputils-ping \  
php5-gd \  
libapache2-mod-php5 \  
libssl-dev \  
unzip \  
libdigest-hmac-perl \  
libnet-snmp-perl \  
libcrypt-des-perl \  
mailutils \  
python-pip  
  
COPY pre-conf.sh /sbin/pre-conf  
RUN chmod +x /sbin/pre-conf ; sync  
RUN /bin/bash -c /sbin/pre-conf && rm /sbin/pre-conf  
  
COPY ./etc /etc  
  
EXPOSE 80  

