# cloudfleet calendar  
#  
# VERSION 0.1  
#  
FROM library/nginx  
  
RUN mkdir -p /usr/share/nginx/html  
WORKDIR /usr/share/nginx/html  
ADD ./nginx-default-dist.conf /etc/nginx/conf.d/default.conf  
ADD ./nginx-dist.conf /etc/nginx/nginx.conf  
ADD ./mime.types /etc/nginx/mime.types  
ADD ./h5bp/ /etc/nginx/h5bp/  
ADD carddavmate/ /usr/share/nginx/html/  
ADD ./config.js /usr/share/nginx/html/config.js  

