FROM nginx:latest  
  
ADD default.conf /etc/nginx/conf.d/default.conf  
ADD start.sh /start.sh  
RUN chmod +x /start.sh  
  
CMD ["/start.sh"]

