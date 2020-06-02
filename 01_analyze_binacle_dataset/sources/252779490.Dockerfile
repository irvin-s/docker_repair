FROM debian:8  
MAINTAINER Caio Bentes <caiosbentes@gmail.com>  
  
COPY sources.list /etc/apt/sources.list  
  
RUN apt-get update  
RUN apt-get -y install nginx  
ENTRYPOINT ["nginx", "-g", "daemon off;"]  

