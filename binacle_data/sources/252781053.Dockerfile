FROM nginx:latest  
  
COPY site.conf /etc/nginx/conf.d/default.conf  
COPY index.html /var/www/kiwi_entry_task/index.html  
COPY localhost.* /var/cert/  

