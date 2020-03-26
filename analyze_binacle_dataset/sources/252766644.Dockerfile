FROM nginx:alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY conf-generator.sh /usr/local/bin/  
  
ENTRYPOINT ["conf-generator.sh"]

