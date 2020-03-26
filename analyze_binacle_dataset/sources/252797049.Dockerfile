# cloudfleet cockpit  
#  
# VERSION 0.4  
#  
# This file is copied over from app/ to dist/ automatically during grunt build  
# and is used by marina to build the blimp-cockpit image  
FROM library/nginx  
  
RUN mkdir -p /usr/share/nginx/html  
WORKDIR /usr/share/nginx/html  
ADD ./nginx-default-dist.conf /etc/nginx/conf.d/default.conf  
ADD ./nginx-dist.conf /etc/nginx/nginx.conf  
ADD ./mime.types /etc/nginx/mime.types  
ADD ./h5bp/ /etc/nginx/h5bp/  
ADD ./ /usr/share/nginx/html/  

