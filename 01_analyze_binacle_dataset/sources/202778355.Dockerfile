FROM nginx
MAINTAINER Justin Menga <justin.menga@gmail.com>
 
# Copy todobackend nginx configuration file
COPY todobackend.conf /etc/nginx/conf.d/todobackend.conf