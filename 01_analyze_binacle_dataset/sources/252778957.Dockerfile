# DOCKER-VERSION 1.1.2  
# DESCRIPTION Elliptics  
FROM ubuntu:14.04  
MAINTAINER Konstantin Burykin <burkostya@gmail.com>  
  
RUN apt-get -y update  
RUN apt-get install -y wget  
  
ADD assets/setup /app/setup  
RUN chmod 755 /app/setup/install  
RUN /app/setup/install  
  
ADD assets/config/ioserv.json /app/setup/ioserv.json  
  
ADD assets/init /app/init  
RUN chmod 755 /app/init  
  
EXPOSE 1025  
VOLUME ["/opt/elliptics"]  
  
ENTRYPOINT ["/app/init"]  
CMD ["app:start"]  

