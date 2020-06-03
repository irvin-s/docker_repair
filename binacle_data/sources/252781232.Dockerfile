FROM nginx:latest  
COPY nginx.conf /etc/nginx/nginx.conf  
  
ADD start.sh /usr/local/bin/  
RUN chmod +x /usr/local/bin/start.sh  
  
CMD ["/usr/local/bin/start.sh"]

