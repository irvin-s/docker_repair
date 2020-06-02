FROM postgres:9.4  
MAINTAINER Sunlight Foundation <labs-contact@sunlightfoundation.com>  
  
RUN apt-get update  
RUN apt-get install -y \  
binutils \  
libproj-dev \  
gdal-bin \  
postgresql-9.4-postgis  
  
RUN mkdir -p /docker-entrypoint-initdb/  
ADD ./docker-entrypoint-initdb/ /docker-entrypoint-initdb/  

