FROM nginx:1.11.3  
# Generate nginx config file from template  
COPY nginx.conf.template /tmp/nginx.conf.template  
COPY initialize.sh /tmp/initialize.sh  
COPY sites-enabled /etc/nginx/sites-enabled  
  
CMD "/tmp/initialize.sh"  

