FROM nginx  
  
MAINTAINER Aloha1003  
  
RUN apt-get update; apt-get install -y \  
openssl  
  
RUN mkdir -p /etc/nginx/external  
ADD nginx.conf /etc/nginx/  
ADD ssl_configure.sh /opt/ssl_configure.sh  
RUN chmod a+x /opt/ssl_configure.sh  
RUN /opt/ssl_configure.sh  
CMD ["nginx"]  
EXPOSE 80 443

