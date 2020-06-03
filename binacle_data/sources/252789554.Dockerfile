FROM durenworks/webphp-dev:0.2.3  
# Docker maintainer  
MAINTAINER Airlangga Cahya Utama <airlangga@durenworks.com>  
  
# Set composer env  
ENV COMPOSER_HOME /root  
  
# Install composer and git  
RUN apt-get update -yq && \  
apt-get install -yq --no-install-recommends git mysql-client beanstalkd && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
curl -sS https://getcomposer.org/installer | php && \  
mkdir -p /build/script && \  
mv composer.phar /build/script/  
  
# Copy config file  
COPY build /build  
RUN cp -R /build/etc/* /etc  
  
# Expose ports.  
EXPOSE 80  

