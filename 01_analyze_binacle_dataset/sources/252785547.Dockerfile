FROM ubuntu:14.04  
MAINTAINER Martijn van Maurik <docker@vmaurik.nl>  
  
RUN apt-get update  
RUN apt-get upgrade -y  
RUN apt-get install -y memcached  
  
EXPOSE 11211  
  
USER daemon  
  
CMD ["memcached", "-m", "255"]  

