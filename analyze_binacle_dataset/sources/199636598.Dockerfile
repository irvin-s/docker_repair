FROM daocloud.io/nginx:1.10.1

ADD sources.list /etc/apt/sources.list
RUN apt-get update && apt-get install -y vim lrzsz

ADD nginx.conf /etc/nginx/nginx.conf
ADD php_handler.conf /etc/nginx/php_handler.conf

# Write Permission
RUN usermod -u 1000 www-data

# Create directory
RUN mkdir /docker/www -p
RUN mkdir /docker/log/nginx -p

RUN chown -R www-data.www-data /docker/www
RUN chown -R www-data.www-data /docker/log/nginx

RUN touch /docker/log/nginx/access.log /docker/log/nginx/error.log;
RUN chmod 777 /docker/log/nginx/access.log /docker/log/nginx/error.log;

CMD ["nginx", "-g", "daemon off;"]