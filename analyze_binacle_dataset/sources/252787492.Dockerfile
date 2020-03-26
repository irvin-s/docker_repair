FROM debian:jessie  
  
ENV DEBIAN_FRONTEND noninteractive  
COPY ./install /install  
RUN set -x  
  
# Install base packages  
COPY ./install/sources.list /etc/apt/sources.list  
RUN /bin/bash /install/global.sh  
  
# Apache  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache2  
RUN /bin/bash /install/apache.sh  
WORKDIR /var/www/vhosts  
EXPOSE 80  
EXPOSE 443  
# NodeJS  
ENV NPM_CONFIG_LOGLEVEL info  
ENV NODE_VERSION 8.7.0  
ENV YARN_VERSION 1.2.0  
RUN /bin/bash /install/nodejs.sh  

