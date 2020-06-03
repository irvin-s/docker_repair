FROM php:alpine  
LABEL maintainer="Ian <ian.vizarra@gmail.com>"  
  
RUN apk update && apk upgrade && apk add bash git  
  
# Install PHP extensions  
ADD install-php.sh /usr/sbin/install-php.sh  
RUN chmod +x /usr/sbin/install-php.sh  
RUN /usr/sbin/install-php.sh  
  
# Download and install NodeJS  
ENV NODE_VERSION 8.9.4  
ADD install-node.sh /usr/sbin/install-node.sh  
RUN chmod +x /usr/sbin/install-node.sh  
RUN /usr/sbin/install-node.sh  
RUN npm i -g yarn  
  
RUN mkdir -p /etc/ssl/certs && update-ca-certificates  
  
EXPOSE 80  
EXPOSE 443  

