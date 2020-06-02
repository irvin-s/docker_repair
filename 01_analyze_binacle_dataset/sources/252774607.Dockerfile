FROM ubuntu:latest  
  
MAINTAINER Bartek Mis <bartek.mis@gmail.com>  
  
WORKDIR /tmp  
  
RUN apt-get update && \  
apt-get -y upgrade && \  
apt-get -y install \  
php7.0 \  
php7.0-cli \  
php7.0-gd \  
php7.0-curl \  
php7.0-json \  
php7.0-mbstring \  
php7.0-mysql \  
php7.0-xml \  
php7.0-xsl \  
php7.0-zip  
  
RUN mkdir -p /var/www  
  
VOLUME ["/var/www"]  
  
WORKDIR /var/www  
  
EXPOSE 3306  
ENTRYPOINT ["php", "artisan"]  
  
CMD ["--help"]

