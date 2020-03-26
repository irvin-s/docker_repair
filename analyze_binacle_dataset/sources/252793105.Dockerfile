FROM ubuntu:14.04  
MAINTAINER Dan Kang <dann.kang@gmail.com>  
  
RUN apt-get update  
RUN apt-get install -y nginx  
RUN echo "\ndaemon off;" >> /etc/nginx/ngionx.conf  
RUN chown -R www-data:www-data /var/lib/nginx  
  
VOLUME ["/data", "/etc/nginx/site-enabled", "/var/log/nginx"]  
  
WORKDIR /etc/nginx  
  
CMD ["nginx"]  
  
EXPOSE 80  
EXPOSE 443  

