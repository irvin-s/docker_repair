FROM leanlabs/nginx:1.0.1  
COPY conf.d /etc/nginx/conf.d  
COPY certs /etc/nginx/certs  
COPY sites-enabled /etc/nginx/sites-enabled  
  
EXPOSE 80  

