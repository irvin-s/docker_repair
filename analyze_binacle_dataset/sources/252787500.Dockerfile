FROM nginx:stable-alpine  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY . /usr/share/nginx/html  
RUN rm /usr/share/nginx/html/nginx.conf  

