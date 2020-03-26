FROM nginx:1.13-alpine  
  
COPY livereload-injection.conf /etc/nginx/conf.d/default.conf  

