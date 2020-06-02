FROM andykirkham/base-dockers-php5-cli:latest  
MAINTAINER Andy Kirkham <andy@spiders-lair.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-key adv --keyserver hkps.pool.sks-keyservers.net --recv D58C6920  
RUN sh -c "echo 'deb http://package.crossbar.io/ubuntu trusty main' \  
> /etc/apt/sources.list.d/crossbar.list"  
RUN apt-get update  
RUN apt-get install -y crossbar  
  

