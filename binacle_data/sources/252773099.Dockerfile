FROM bezrukovp/main-base  
MAINTAINER Pavel Bezrukov "bezrukov.ps@gmail.com"  
# Install front server  
RUN apt-get -y -q install nginx  
  
ADD etc/nginx/conf /etc/nginx/conf  
ADD etc/nginx/sites-available /etc/nginx/sites-available  
RUN mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.bak  
ADD etc/nginx/nginx.conf /etc/nginx/nginx.conf  
  
EXPOSE 80  
EXPOSE 443  

