#version v0.0.3  
FROM ubuntu:14.04  
MAINTAINER Tinding "Tinding@gmail.com"  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN echo 'Hi,I am in your container'>/usr/share/nginx/html/index.html  
EXPOSE 80  
EXPOSE 336  
ENTRYPOINT ["/usr/sbin/nginx"]  

