FROM dock0/nginx  
MAINTAINER akerl <me@lesaker.org>  
RUN pacman -S --noconfirm --needed gawk  
ADD site.conf /etc/nginx/sites/keysite.conf  
ADD keys /srv/keys  
ADD build /opt/build  
RUN cd /srv/keys && /opt/build  

