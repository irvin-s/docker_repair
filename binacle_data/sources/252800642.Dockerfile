FROM gliderlabs/alpine  
MAINTAINER Patrick O'Connor <patrick@dontreboot.me>  
  
# Install nginx, make it work well with docker, and get it ready to run  
RUN apk-install nginx && echo "daemon off;" >> /etc/nginx/nginx.conf \  
&& mkdir -p /tmp/nginx/client-body  
# Bring in the baymax  
COPY html /usr/html  
COPY start_nginx.sh /  
  
# Expose port 80  
EXPOSE 80  
  
# Run nginx  
CMD /start_nginx.sh  

