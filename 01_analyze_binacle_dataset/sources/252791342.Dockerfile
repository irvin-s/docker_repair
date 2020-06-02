FROM debian:8.3  
MAINTAINER Michał Czeraszkiewicz <contact@czerasz.com>  
  
RUN apt-get update && \  
apt-get -y install putty-tools && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY ./entrypoint.sh /entrypoint.sh  
ENTRYPOINT /entrypoint.sh  

