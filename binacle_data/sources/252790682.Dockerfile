FROM nginx:latest  
RUN rm /etc/nginx/conf.d/default.conf  
ADD sites-enabled/ /etc/nginx/conf.d

