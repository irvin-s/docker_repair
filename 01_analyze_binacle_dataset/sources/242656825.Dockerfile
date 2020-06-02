FROM nginx:1.11.9

# add Nginx custom configurations here
ADD nginx.conf /etc/nginx/nginx.conf
RUN mkdir /var/log/shared
