FROM attractgrouphub/alpine-php7-nginx-composer  
  
MAINTAINER igorskubiy@attractgroup.com  
  
RUN apk add --no-cache supervisor nodejs bash git make g++ openssl && \  
npm install npm@latest -g && \  
npm install --global gulp && \  
composer global require "hirak/prestissimo:^0.3"

