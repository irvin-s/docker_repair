FROM debian:latest  
MAINTAINER Didier Franc <contact@didierfranc.com>  
  
COPY /scripts /  
RUN sh install.sh  
  
VOLUME /db  
VOLUME /cloud  
  
CMD ["bash","start.sh"]  

