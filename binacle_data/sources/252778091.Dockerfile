FROM nginx:latest  
MAINTAINER Jonathan Hawk <jonathan@appertly.com>  
  
ADD mime.types /etc/nginx/mime.types  
ADD nginx.conf /etc/nginx/nginx.conf  
ADD ssl.conf /etc/nginx/conf.d/ssl.conf  
ADD default.conf /etc/nginx/conf.d/default.conf  
RUN apt-get update \  
&& apt-get install -y ca-certificates  
  
ADD start.sh /scripts/start.sh  
RUN chmod +x /scripts/start.sh  
  
CMD ["/scripts/start.sh"]  

