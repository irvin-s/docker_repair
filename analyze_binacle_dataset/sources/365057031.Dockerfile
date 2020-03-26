FROM marmelab/composer-hhvm 
RUN apt-get update	
RUN apt-get install -y  nginx vim
# nginx config
RUN sed -i -e"s/keepalive_timeout\s*65/keepalive_timeout 2/" /etc/nginx/nginx.conf
RUN sed -i -e"s/keepalive_timeout 2/keepalive_timeout 2;\n\tclient_max_body_size 100m/" /etc/nginx/nginx.conf
ADD . /app
EXPOSE 80
RUN cd /app; hhvm /usr/local/bin/composer install

ADD ./nginx-site.conf /etc/nginx/sites-available/default
EXPOSE 80
WORKDIR /app

ADD ./nginx.conf /etc/nginx/nginx.conf
ADD ./startup.sh /app/startup.sh
ADD ./public/wp-config.php /app/public.built/wp-config.php
CMD ["/bin/bash","/app/startup.sh"]
