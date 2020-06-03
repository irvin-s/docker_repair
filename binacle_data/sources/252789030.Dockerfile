FROM node:6-slim  
MAINTAINER drupal-docker <info@drupaldocker.org>  
  
WORKDIR /var/www/html  
  
COPY ./ /var/www/html  
  
RUN npm install http-server gitbook-cli -g \  
&& gitbook install \  
&& gitbook build \  
&& cd _book  
  
EXPOSE 80  
CMD [ "http-server", "./_book", "-p 80" ]  

