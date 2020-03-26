FROM durenworks/webphp-dev:0.2.6  
# Docker maintainer  
MAINTAINER Airlangga Cahya Utama <airlangga@durenworks.com>  
  
# Set composer env  
ENV COMPOSER_HOME /root  
# Install composer and git  
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash - && \  
apt-get install -yq nodejs g++ python make && \  
apt-get install -yq \--no-install-recommends git && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \  
curl -sS https://getcomposer.org/installer | php -- \  
\--filename=composer \  
\--install-dir=/usr/local/bin \  
\--version=1.0.3 && \  
npm install \--global npm && \  
npm install \--global gulp && \  
npm cache clean && \  
mkdir -p /srv/web && \  
rm /etc/cron.d/php5  
# Copy config file  
COPY build /build  
RUN cp -R /build/etc/* /etc  
# Expose ports.  
EXPOSE 80  

