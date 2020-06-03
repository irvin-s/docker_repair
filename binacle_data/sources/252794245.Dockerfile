FROM nginx  
COPY nginx.conf /etc/nginx/nginx.conf  
  
RUN mkdir -p /etc/nginx/ssl/  
RUN mkdir -p /etc/nginx/external/  

