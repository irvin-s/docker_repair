FROM nginx:alpine  
  
COPY build /usr/share/nginx/html  
  
VOLUME ["/usr/share/nginx/html"]  
  
EXPOSE 80  

