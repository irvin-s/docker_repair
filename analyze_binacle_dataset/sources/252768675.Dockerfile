FROM gendosu/alpine-apache:latest  
  
MAINTAINER pavletto  
  
RUN apk add --no-cache apache2-proxy; \  
addgroup -g 1000 -S www; \  
adduser -G www -u 1000 -s /bin/sh -D www;  
  
COPY conf /etc/apache2  
  
ENV BITRIX_BACKEND_HOST=php  
  
COPY ./entrypoint.sh /  
RUN ["chmod", "+x", "/entrypoint.sh"]  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 80 443  

