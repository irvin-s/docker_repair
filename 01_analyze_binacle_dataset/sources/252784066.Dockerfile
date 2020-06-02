FROM nginx:latest  
  
# Install OpenSSL so we can generate SSL certs if needed  
RUN apt-get update; apt-get install -y openssl  
  
# Add nginx configuration and static HTML  
RUN mkdir -p /etc/nginx/certs  
ADD default.conf /etc/nginx/conf.d/default.conf  
COPY html /usr/share/nginx/html  
  
# Add entrypoint script for creating a self-signed certificate  
ADD entrypoint.sh /usr/local/bin/entrypoint.sh  
RUN chmod a+x /usr/local/bin/entrypoint.sh  
  
ENTRYPOINT ["entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  

