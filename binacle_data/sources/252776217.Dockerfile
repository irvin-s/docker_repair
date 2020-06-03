FROM nginx:latest  
  
RUN rm -rf /etc/nginx/conf.d/*  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY .htpasswd /etc/nginx/.htpasswd  

