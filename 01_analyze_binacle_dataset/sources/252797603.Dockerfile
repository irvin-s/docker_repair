# Version: 0.0.1  
FROM ubuntu:17.10  
MAINTAINER Ken Siu "kensoft@gmail.com"  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN echo 'Hi, I am in your container!'\  
> /usr/share/nginx/html/index.html  
EXPOSE 80

