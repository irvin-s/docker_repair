FROM nginx:alpine  
MAINTAINER Alexander Pinnecke <alexander.pinnecke@googlemail.com>  
  
ENV BASIC_AUTH_FILE /etc/nginx/basic_auth  
  
ADD proxy.conf /etc/nginx/conf.d/default.conf  
ADD entrypoint.sh /entrypoint.sh  
CMD ["/entrypoint.sh"]  

