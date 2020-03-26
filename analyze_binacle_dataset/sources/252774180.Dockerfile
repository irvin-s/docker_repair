FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
RUN rm -fr /etc/nginx/conf.d/default.conf  
  
COPY docker-entrypoint.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/docker-entrypoint.sh  
  
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]  

