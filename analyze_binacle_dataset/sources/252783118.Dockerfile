FROM node:0.12.7-slim  
  
MAINTAINER Thomas Krampl  
  
RUN apt-get update -y && \  
apt-get install -y php5-cli curl php5-curl git php5-mcrypt php5-gd && \  
curl -sS https://getcomposer.org/installer | php && \  
mv composer.phar /usr/local/bin/composer && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN npm install -g bower grunt-cli  

