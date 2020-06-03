FROM nginx:1.11-alpine

COPY dist /usr/share/nginx/html



# # host with apache 
# FROM ubuntu:16:04
# RUN apt update
# RUN apt install -y apache2
# COPY dist /var/www/html
# CMD /usr/sbin/apache2ctl -D FOREGROUND
# EXPOSE 80