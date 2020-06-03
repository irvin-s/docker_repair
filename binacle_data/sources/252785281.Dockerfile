FROM nginx:1.11.1  
MAINTAINER Francois Raubenheimer <cois.io>  
  
COPY magento.conf /etc/nginx/conf.d  
COPY default.conf /etc/nginx/conf.d  

