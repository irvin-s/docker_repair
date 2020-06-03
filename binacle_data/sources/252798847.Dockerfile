FROM mysql:5.6  
  
MAINTAINER Davi Marcondes Moreira <davi.marcondes.moreira@gmail.com>  
  
ARG VCS_REF  
ARG BUILD_DATE  
  
COPY ./releases/* /releases/  
  
VOLUME /var/lib/mysql  

