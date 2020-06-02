# cloudfleet cockpit  
#  
# VERSION 0.4  
FROM nginx  
  
RUN mkdir -p /usr/share/nginx/html  
WORKDIR /usr/share/nginx/html  
ADD ./nginx-dist.conf /etc/nginx/conf.d/default.conf  
ADD ./ /usr/share/nginx/html/  

