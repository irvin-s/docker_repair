FROM nginx  
  
COPY conf.d/default.template /etc/nginx/conf.d/default.template  
COPY start.sh /start.sh  
  
RUN chmod +x /start.sh  
  
CMD ["/start.sh"]  

