FROM debian:jessie-slim  
MAINTAINER Emmanuel Dyan <emmanueldyan@gmail.com>  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
# Installation  
RUN sed -i -e 's/ main/ main non-free/' /etc/apt/sources.list  
RUN apt-get update && \  
apt-get upgrade -y && \  
# Install requirements  
apt-get install -y --no-install-recommends apache2 libapache2-mod-fastcgi && \  
# Clean  
apt-get clean && \  
apt-get autoremove -y && \  
rm -Rf /var/lib/apt/lists/* /usr/share/man/* /usr/share/doc/*  
  
# COnfiguration  
COPY vhost.conf /etc/apache2/sites-available/vhost.conf  
RUN a2enmod actions fastcgi rewrite && \  
a2dissite 000-default.conf && \  
a2ensite vhost.conf && \  
mkdir /var/lib/php-fcgi  
  
RUN chmod 644 /var/log/apache2  
  
ENV APACHE_UID 33  
ENV APACHE_GID 33  
EXPOSE 80  
COPY run.sh /run.sh  
RUN chmod u+x /run.sh  
  
CMD ["/run.sh"]  

