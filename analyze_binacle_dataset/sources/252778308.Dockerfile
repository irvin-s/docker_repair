FROM ubuntu:latest  
MAINTAINER Aqsa  
RUN apt-get update  
RUN apt-get install nano  
CMD ["php", "-a"]  

