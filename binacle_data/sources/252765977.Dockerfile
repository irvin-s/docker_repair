FROM nginx:1.10  
MAINTAINER Adam Jarvis <adam.d.jarvis@ibm.com>  
  
# Add host  
ADD ./vhost.conf /etc/nginx/conf.d/default.conf  
  
WORKDIR /srv/www  

