FROM nginx  
  
RUN mkdir -p /var/log/nginx && touch /var/log/nginx/access.log  
  
ADD /nginx.conf /etc/nginx/conf.d/default.conf  
ADD /web /www  

