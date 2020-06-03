FROM nginx:1.13  
MAINTAINER Kevin <work.didelotkev.ovh>  
  
# Copy the cv app to /var/www/mycv  
RUN mkdir -p /var/www/mycv  
COPY src/ /var/www/mycv  
  
# Configure nginx  
COPY nginx_conf/nginx.conf /etc/nginx/nginx.conf  
  
VOLUME /var/log/nginx  
  
EXPOSE 80  

