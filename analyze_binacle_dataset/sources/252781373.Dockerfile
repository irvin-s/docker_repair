FROM nginx  
  
ENV NGINX_ROOT /var/www/drupal/web  
ENV NGINX_SERVER_NAME drupal.dev  
  
COPY config/default.conf /etc/nginx/conf.d/default.conf  
  
COPY docker_entrypoint.sh /entrypoint.sh  
  
CMD ["nginx", "-g", "daemon off;"]  
  
ENTRYPOINT ["/entrypoint.sh"]  

