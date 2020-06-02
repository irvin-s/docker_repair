FROM nginx  
#COPY static /var/www/html  
COPY src/default.conf /etc/nginx/conf.d/default.conf  
COPY src/nginx.conf /etc/nginx/nginx.conf

