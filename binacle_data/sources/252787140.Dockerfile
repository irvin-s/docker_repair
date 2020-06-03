# Version: 0.0.1  
FROM ubuntu:14.04  
MAINTAINER Brayden Li "braydenli@163.com"  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN echo 'Hello, World!' > /usr/share/nginx/html/index.html  
  
EXPOSE 80  
ENTRYPOINT ["nginx"]  
CMD ["-h"]  
  

