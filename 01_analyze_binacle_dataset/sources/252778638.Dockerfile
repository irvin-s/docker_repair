FROM nginx  
MAINTAINER Benedikt Stegmaier <dev@bstegmaier.de>  
  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y \  
wget \  
unzip  
  
WORKDIR /tmp  
RUN wget https://github.com/nrenner/brouter-web/archive/master.zip \  
&& unzip master.zip \  
&& mv brouter-web-master/* /usr/share/nginx/html  
  
VOLUME /usr/share/nginx/html/profiles  
COPY config.js /usr/share/nginx/html/  
  
# nginx is exposed on port 80  

