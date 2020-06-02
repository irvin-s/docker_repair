FROM nginx:1.11.3  
RUN apt-get update && apt-get install -y rsync  
  
# Generate nginx config file from template  
COPY nginx_conf /tmp/nginx_conf  
COPY initialize.sh /tmp/initialize.sh  
  
COPY misc/dhparam.pem /etc/ssl/certs/dhparam.pem  
  
CMD "/tmp/initialize.sh"  

