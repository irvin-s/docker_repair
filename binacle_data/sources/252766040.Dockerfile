FROM kyma/docker-nginx  
COPY src/ /var/www  
RUN rm /etc/nginx/sites-enabled/*  
COPY conf/default.conf /etc/nginx/sites-enabled/default.conf  
CMD 'nginx'  

