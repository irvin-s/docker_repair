FROM nginx:alpine  
  
RUN rm /etc/nginx/conf.d/*  
  
COPY nginx.conf /etc/nginx/conf.d/  
  
COPY index.html /etc/nginx/html/

