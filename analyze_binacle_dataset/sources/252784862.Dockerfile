FROM nginx  
  
MAINTAINER Daniel Holzmann <daniel@codelovers.at>  
  
ADD conf/common.conf /etc/nginx/common.conf  
ADD conf/fastcgi_params /etc/nginx/fastcgi_params  
ADD conf/nginx.conf /etc/nginx/nginx.conf  
ADD conf/hhvm.conf /etc/nginx/hhvm.conf  
  
# server configs  
RUN rm -f /etc/nginx/conf.d/*  
ADD conf/server-hhvm.conf /etc/nginx/conf.d/server-hhvm.conf  
  
EXPOSE 8080  

