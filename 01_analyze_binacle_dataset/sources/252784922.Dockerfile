FROM nginx:latest  
  
COPY nginx.conf /etc/nginx/nginx.conf  
  
ENTRYPOINT ["nginx"]  

