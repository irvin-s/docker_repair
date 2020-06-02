FROM nginx:1.11-alpine  
  
ADD ./ng2-admin /var/www  
  
COPY ng2-admin/dist /var/www  
COPY docker/nginx/conf.d/* /etc/nginx/conf.d/  
  
RUN chmod 755 /var/www/run-prod.sh  
  
ENTRYPOINT ["/var/www/run-prod.sh"]  
  

