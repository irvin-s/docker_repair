# DOCKER-VERSION 1.0.1  
# DESCRIPTION Cocaine  
FROM ubuntu:12.04  
MAINTAINER Konstantin Burykin <burkostya@gmail.com>  
  
RUN apt-get install -y curl  
  
ADD assets/setup /app/setup  
RUN chmod 755 /app/setup/install  
RUN /app/setup/install  
  
ADD assets/config/cocaine.conf /app/setup/cocaine.conf  
  
ADD assets/init /app/init  
RUN chmod 755 /app/init  
  
ENTRYPOINT ["/app/init"]  
CMD ["app:start"]  

