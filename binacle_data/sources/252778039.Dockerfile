FROM python:3-alpine  
  
MAINTAINER Guilherme Salazar <gmesalazar@gmail.com>  
  
RUN \  
apk add --no-cache git openjdk8 && \  
apk add --no-cache --virtual .deps build-base linux-headers && \  
pip install esrally && \  
apk del .deps  
  
COPY rally.ini /root/.rally/  
COPY docker-entrypoint.sh /usr/bin/  
  
ENTRYPOINT ["docker-entrypoint.sh"]  

