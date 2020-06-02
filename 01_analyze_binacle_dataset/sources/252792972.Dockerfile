FROM nginx:1.13.9  
RUN apt-get update && apt-get --assume-yes install \  
apt-utils \  
apache2-utils  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
RUN mkdir -p /etc/nginx/cache  

