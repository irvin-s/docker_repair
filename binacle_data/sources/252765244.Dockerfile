FROM nginx:latest  
RUN sed -i "s/listen 80;/listen 8080;/g" /etc/nginx/conf.d/default.conf  
EXPOSE 8080  

