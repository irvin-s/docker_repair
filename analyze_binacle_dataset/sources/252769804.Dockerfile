FROM nginx:latest  
  
COPY docker-entrypoint.sh /  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["nginx", "-g", "daemon off;"]  
  
RUN rm /etc/nginx/conf.d/*  
RUN mkdir -p /var/www/letsencrypt  
  
VOLUME /etc/nginx /var/www  
  
COPY nginx/ /etc/nginx/  

