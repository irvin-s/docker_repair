FROM dock0/foreman  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --noconfirm --needed nginx  
ADD nginx /etc/nginx/  
ADD run /service/nginx/run  
ENV HTTP_PORT 1080  
ENV HTTPS_PORT 1443  
EXPOSE $HTTP_PORT $HTTPS_PORT  

