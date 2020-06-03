FROM nginx:alpine  
MAINTAINER Florian Baltes <3baltes@informatik.uni-hamburg.de>  
COPY dist /usr/share/nginx/html  
ADD nginx.conf /etc/nginx/conf.d/default.conf  
EXPOSE 80  

