FROM nginx:1.11-alpine  
  
COPY startup.sh /usr/local/bin/  
COPY index.html /usr/share/nginx/html  
COPY default.conf /etc/nginx/conf.d/  
  
RUN echo "daemon off;" >> /etc/nginx/nginx.conf  
  
ENTRYPOINT startup.sh

