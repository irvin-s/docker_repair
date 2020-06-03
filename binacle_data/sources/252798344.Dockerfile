FROM debian:testing  
MAINTAINER jakub.blaszczyk@sap.com  
  
ONBUILD RUN apt-get update  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM xterm  
  
ADD files/entrypoint.sh /entrypoint.sh  
  
RUN apt-get update && apt-get install -y openjdk-8-jdk  
  
VOLUME /input  
VOLUME /output  
  
ENTRYPOINT ["/entrypoint.sh"]  

