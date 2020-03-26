FROM nginx  
COPY ./default.conf /etc/nginx/conf.d/default.conf  
COPY . /var/www  
RUN service nginx start

