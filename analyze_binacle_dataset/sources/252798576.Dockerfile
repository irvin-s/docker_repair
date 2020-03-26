FROM ubuntu:16.04  
MAINTAINER Jojo <jojo@openparse.io>  
  
# Update distrib  
RUN apt-get update  
  
# Install certbot and nginx  
RUN apt-get install -y nginx dnsmasq  
RUN apt-get install -y letsencrypt  
  
# Copy files  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY proxy.conf /etc/nginx/conf.d/  
COPY entrypoint.sh /entrypoint.sh  
  
# Volumes  
VOLUME /etc/nginx/sites-enabled  
VOLUME /etc/letsencrypt  
  
# Environment variables  
ENV LETSENCRYPT_EMAIL none  
ENV RSA_KEY_SIZE 4096  
ENV STARTUP_WAIT 0  
# Ports  
EXPOSE 80  
EXPOSE 443  
# Command  
CMD /entrypoint.sh  

