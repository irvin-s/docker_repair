FROM debian:8.3  
  
MAINTAINER AttractGroup  
  
RUN apt-get clean && apt-get update  
  
RUN apt-get install -y \  
curl \  
mcrypt \  
wget \  
nginx \  
php5 \  
php5-common \  
php5-cli \  
php5-fpm \  
php5-curl \  
php5-gd \  
php5-imap \  
php5-mcrypt \  
php5-mysql \  
supervisor \  
git-core \  
cron \  
iproute \  
nodejs \  
npm  
  
RUN npm cache clean  
RUN npm install -g n  
RUN n stable  
RUN curl -L https://npmjs.org/install.sh | sh  
  
EXPOSE 80

