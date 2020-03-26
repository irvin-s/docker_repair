FROM nginx:alpine  
MAINTAINER Shuhei Nomura <info@danmaq.com>  
ADD ./*.js /usr/share/nginx/html/  
ADD ./*.map /usr/share/nginx/html/  
ADD ./default.css /usr/share/nginx/html/  
ADD ./index.html /usr/share/nginx/html/  

