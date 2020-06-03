FROM nginx  
MAINTAINER Andi N. Dirgantara  
  
COPY stag.cannesstore.com.conf /etc/nginx/conf.d/stag.cannesstore.com.conf  
COPY andi.dirgantara.co.conf /etc/nginx/conf.d/andi.dirgantara.co.conf  
EXPOSE 80

