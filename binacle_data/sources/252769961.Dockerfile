FROM debian:latest  
  
MAINTAINER artemstd <artemstd@gmail.com>  
  
ARG DEBIAN_FRONTEND=noninteractive  
  
# nginx  
RUN apt-get update && apt-get install -y nginx  
  
RUN echo 'daemon off;' >> /etc/nginx/nginx.conf  
  
EXPOSE 80  
ENTRYPOINT ["nginx"]  

