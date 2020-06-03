FROM nginx:1.10.1-alpine  
MAINTAINER BlackGlory <woshenmedoubuzhidao@blackglory.me>  
  
RUN apk update \  
&& apk add \--no-cache nodejs git python make g++  
  
ADD . /tmp  
  
RUN cd /tmp \  
&& npm install \  
&& npm run build \  
&& cp -rf build/* /usr/share/nginx/html \  
&& cp nginx.conf /etc/nginx/conf.d/default.conf \  
&& rm -rf /tmp  

