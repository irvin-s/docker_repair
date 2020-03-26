FROM nginx:1.13-alpine  
MAINTAINER Mitchell Cowie <mcowie@bakerdist.com>  
  
ENV PHP_HOST phpfpm  
ENV PHP_PORT 9000  
ENV APP_MAGE_MODE default  
ENV APP_MAGE_SRC /var/www/html  
  
COPY ./conf/default.conf /etc/nginx/conf.d/  
COPY ./bin/start.sh /usr/local/bin/start.sh  
  
WORKDIR /var/www/html  
  
CMD ["/usr/local/bin/start.sh"]  

